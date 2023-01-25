<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Stock;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Models\Stock\StockOut;
use App\Models\Stock\Requisition;
use App\Models\Stock\StockoutItem;
use App\Models\Stock\StockReceive;
use Illuminate\Support\Facades\DB;
use App\Models\Stock\StockTransfer;
use App\Http\Controllers\Controller;
use App\Models\Stock\StockinHistory;
use Illuminate\Support\Facades\Auth;
use App\Models\Stock\ProductCategory;
use App\Models\Stock\RequisitionItem;
use Illuminate\Support\Facades\Storage;
use App\Models\Stock\StockTransferItems;

class StockController extends Controller
{
    /**
     * Receive items from supplier
     * @param Request $request
     * @return JsonResponse
     */
    public function receive(Request $request)
    {
        if (!empty($id = $request->input('receive_id'))) {
            $record = StockReceive::find($id);
            $record->date_received = $request->input('date_received');
            $record->supplier_id = $request->input('supplier_id');
            $record->amount = $request->input('amount');
            $record->vat = $request->input('vat');
            $record->save();
        } else {
            $id = StockReceive::create([
                'reference' => generateReference(20),
                'date_received' => $request->input('date_received'),
                'supplier_id'   => $request->input('supplier_id'),
                'amount'        => $request->input('amount'),
                'vat'           => $request->input('vat'),
            ])->id;
        }
        $items = json_decode($request->input('items'));
        $this->commitReceivedItems($id, $items);
        if (!empty($file = $request->file('file'))) {
            $result = $this->storeFile($request);
            $row = StockReceive::find($id);
            $row->file_url = $result;
            $row->save();
        }
        return response()->json([
            'status'  => 1,
            'message' => 'Records saved successfully'
        ]);
    }

    /**
     * Get Receive Items
     * @param int $id
     * @return JsonResponse
     */
    public function getReceiveItems($id)
    {
        $row = StockReceive::findOrFail($id);
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Record not found'
            ], 404);
        }
        return response()->json([
            'status' => 1,
            'items'  => StockinHistory::where('stockin_id', $id)
                                      ->with('product')->get()
        ]);
    }

    /**
     * Edit Receive items from supplier
     * @param int $id
     * @return JsonResponse
     */
    public function deleteReceive($id)
    {
        $row = StockReceive::findOrFail($id);
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Record not found'
            ], 404);
        }
        $items = StockinHistory::where('stockin_id', $row->id)->get();
        foreach($items as $item) {
            $product = Product::find($item->product_id);
            $product->quantity -= $item->quantity;
            $product->save();
            $item->delete();
        }
        $row->delete();
        return response()->json([
            'status' => 1,
            'message'  => 'Deleted successfully'
        ]);
    }

    /**
     * Delete Receive Item
     * @param int $id
     * @param int $itemId
     * @return JsonResponse
     */
    public function deleteReceiveItem($id, $itemId)
    {
        $row = StockinHistory::findOrFail($itemId);
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Item not found'
            ], 404);
        }
        $receive = StockReceive::find($row->stockin_id);
        $receive->amount -= ($row->price * $row->quantity);
        $receive->save();

        $product = Product::find($row->product_id);
        $product->quantity -= $row->quantity;
        $product->save();
        $row->delete();

        return response()->json([
            'status' => 1,
            'message'  => 'Deleted successfully'
        ]);
    }

     /**
      * Record stock of recieved items
      * @param int $receivedId
      * @params array $items
      * @return void
      */
     private function commitReceivedItems($receivedId, $items)
     {
         foreach($items as $item) {
            $product = Product::find($item->id);
            $product->cost_price = $item->price;
            if (!empty($item->alreadyExist) || !empty($item->rowId)) {
                $row = StockinHistory::find($item->rowId);
                if ($row->quantity != $item->quantity) {
                    if ($row->quantity > $item->quantity) {
                        $difference = $row->quantity - $item->quantity;
                        $product->quantity -= $difference;
                    } else {
                        $difference = $item->quantity - $row->quantity;
                        $product->quantity += $difference;
                    }
                    $product->save();
                    $row->quantity = $item->quantity;
                    $row->price = $item->price;
                    $row->save();
                }
            } else {
                $product->quantity += $item->quantity;
                $product->save();
                StockinHistory::create([
                    'stockin_id' => $receivedId,
                    'product_id' => $item->id,	
                    'quantity'   => $item->quantity,	
                    'price'      => $item->price,
                    'expiration_date' => $item->expiration_date ?? NULL,	
                    'barcode'    => $item->barcode ?? NULL
                ]);
            }
        }
     }

     /**
      * Upload file
      */
      private function storeFile($request)
      {
          $file = $request->file('file');
          $folder = '';
          $id = Auth::id();
          if ($id) {
              $folder .= sprintf('%04d', (int)$id / 1000) . '/' . $id . '/';
          }
          $folder = $folder . date('Y/m/d');
          $newFileName = Str::slug(substr($file->getClientOriginalName(), 0, strrpos($file->getClientOriginalName(), '.')));
          if(empty($newFileName)) $newFileName = md5($file->getClientOriginalName());
  
          $i = 0;
          do {
              $newFileName2 = $newFileName . ($i ? $i : '');
              $testPath = $folder . '/' . $newFileName2 . '.' . $file->getClientOriginalExtension();
              $i++;
          } while (Storage::disk('public')->exists($testPath));
  
          $check = $file->storeAs( $folder, $newFileName2 . '.' . $file->getClientOriginalExtension(),'public');
          return $check;
      }

      /**
       * Show a receive and its items
       * @params string reference
       * @return JsonResponse
       */
      public function showReceive($reference)
      {
        $row = StockReceive::where('reference', $reference)->with('supplier')->first();
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Record not found'
            ], 404);
        }
        return response()->json([
            'status' => 1,
            'row'    => $row,
            'items'  => StockinHistory::select('id', 'product_id', 'quantity', 'price')
                                        ->where('stockin_id', $row->id)
                                        ->with('product')->get()
        ]);
      }

     /**
     * Transfer items to department
     * @param Request $request
     * @return JsonResponse
     */
    public function transfer(Request $request)
    {
        if (!empty($id = $request->input('transfer_id'))) {
            $record = StockTransfer::find($id);
            $record->date_transfered = $request->input('date_transfered');
            $record->department_id = $request->input('department_id');
            $record->amount = $request->input('amount');
            $record->taken_by = $request->input('taken_by');
            $record->save();
        } else {
            $id = StockTransfer::create([
                'reference' => generateReference(20),
                'date_transfered' => $request->input('date_transfered'),
                'department_id'   => $request->input('department_id'),
                'amount'          => $request->input('amount'),
                'taken_by'        => $request->input('taken_by'),
                'requisition_id'  => $request->input('requisition_id')
            ])->id;

            if (!empty($requisitionId = $request->input('requisition_id'))) {
                $requisition = Requisition::find($requisitionId);
                $requisition->status = 'ACCEPTED';
                $requisition->save();
            }
        }
        $items = json_decode($request->input('items'));
        $this->commitTransferItems($id, $items, $request->input('department_id'));
        return response()->json([
            'status'  => 1,
            'message' => 'Records saved successfully'
        ]);
    }

    /**
     * Get Transfer Items
     * @param int $id
     * @return JsonResponse
     */
    public function getTransferItems($id)
    {
        $row = StockTransfer::findOrFail($id);
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Record not found'
            ], 404);
        }
        return response()->json([
            'status' => 1,
            'items'  => StockTransferItems::where('transfer_id', $id)
                                        ->with('product')->get()
        ]);
    }

    /**
     * Delete Transfer
     * @param int $id
     * @return JsonResponse
     */
    public function deleteTransfer($id)
    {
        $row = StockTransfer::findOrFail($id);
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Record not found'
            ], 404);
        }
        $items = StockTransferItems::where('transfer_id', $row->id)->get();
        foreach($items as $item) {
            $stock = Stock::where('product_id', $item->product_id)
                            ->where('department_id', $row->department_id)
                            ->first();
            $stock->quantity -= $item->quantity;
            $stock->save();
            $product = Product::find($item->product_id);
            $product->quantity += $item->quantity;
            $product->save();
            $item->delete();
        }

        if (!empty($row->requisition_id)) {
            $requisition = Requisition::find($row->requisition_id);
            $requisition->status = 'PENDING';
            $requisition->save();
        }
        $row->delete();
        return response()->json([
            'status' => 1,
            'message'  => 'Deleted successfully'
        ]);
    }

    /**
     * Delete Transfer Item
     * @param int $id
     * @param int $itemId
     * @return JsonResponse
     */
    public function deleteTransferItem($id, $itemId)
    {
        $row = StockTransferItems::findOrFail($itemId);
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Item not found'
            ], 404);
        }
        $transfer = StockTransfer::find($row->transfer_id);
        $transfer->amount -= ($row->price * $row->quantity);
        $transfer->save();

        $stock = Stock::where('product_id', $row->product_id)
                        ->where('department_id', $transfer->department_id)
                        ->first();
        $stock->quantity -= $row->quantity;
        $stock->save();
        $product = Product::find($row->product_id);
        $product->quantity += $row->quantity;
        $product->save();
        $row->delete();

        return response()->json([
            'status' => 1,
            'message'  => 'Deleted successfully'
        ]);
    }


     /**
      * Edit stock of received items
      * @param int $transferId
      * @params array $items
      * @return void
      */
     private function commitTransferItems($transferId, $items, $departmentId)
     {
         foreach($items as $item) {
            $stock = Stock::where('product_id', $item->id)
                            ->where('department_id', $departmentId)
                            ->first();
            $product = Product::find($item->id);
            if (!empty($item->alreadyExist) || !empty($item->rowId)) {
                $row = StockTransferItems::find($item->rowId);
                if ($row->quantity != $item->quantity) {
                    if ($row->quantity > $item->quantity) {
                        $difference = $row->quantity - $item->quantity;
                        $stock->quantity -= $difference;
                        $product->quantity += $difference;
                    } else {
                        $difference = $item->quantity - $row->quantity;
                        $stock->quantity += $difference;
                        $product->quantity -= $difference;
                    }
                    $stock->save();
                    $product->save();
                    $row->quantity = $item->quantity;
                    $row->price = $item->price;
                    $row->save();
                }
            } else {
                if(!$stock) {
                    $stock = new Stock();
                    $stock->product_id = $item->id;
                    $stock->department_id = $departmentId;
                }
                $stock->quantity += $item->quantity;
                $stock->save();
                $product->quantity -= $item->quantity;
                $product->save();
                StockTransferItems::create([
                    'transfer_id' => $transferId,
                    'product_id' => $item->id,	
                    'quantity'   => $item->quantity,	
                    'price'      => $item->price
                ]);
            }
        }
        if (!empty($requisitionId = \request()->input('requisition_id'))) {
            foreach ($items as $item) {
                $row = RequisitionItem::where('requisition_id', $requisitionId)
                                        ->where('product_id', $item->id)
                                        ->first();
                $row->requested_qty =  $item->quantity;
                $row->save();
            }
        }
     }

    /**
     * Show a transfer record and its items
     * @params string reference
     * @return JsonResponse
     */
    public function showTransfer($reference)
    {
        $row = StockTransfer::where('reference', $reference)->with('department', 'employee')->first();
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Record not found'
            ], 404);
        }
        return response()->json([
            'status' => 1,
            'row'    => $row,
            'items'  => StockTransferItems::select('id', 'product_id', 'quantity', 'price')
                                        ->where('transfer_id', $row->id)
                                        ->with('product')->get()
        ]);
    }
}
