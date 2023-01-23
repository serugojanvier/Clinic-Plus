<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Stock;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Models\Stock\StockOut;
use App\Models\Stock\StockoutItem;
use App\Models\Stock\StockReceive;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\Stock\StockinHistory;
use Illuminate\Support\Facades\Auth;
use App\Models\Stock\ProductCategory;
use Illuminate\Support\Facades\Storage;

class StockController extends Controller
{
    /**
     * Receive items from supplier
     * @param Request $request
     * @return JsonResponse
     */
    public function receive(Request $request)
    {
        $id = StockReceive::create([
            'date_received' => $request->input('date_received'),
            'supplier_id'   => $request->input('supplier_id'),
            'amount'        => $request->input('amount'),
            'vat'           => $request->input('vat'),
        ])->id;

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
            $stock = Stock::where('product_id', $item->product_id)->first();
            $stock->quantity -= $item->quantity;
            $stock->save();
        }
        $row->delete();
        return response()->json([
            'status' => 1,
            'message'  => 'Deleted successfully'
        ]);
    }

    /**
     * Add Items to recieve record
     * @param Request $request
     * @return JsonResponse
     */

     public function addReceiveItems(Request $request)
     {
        $row = StockReceive::findOrFail($request->input('record_id'));
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Record not found'
            ], 404);
        }
        $row->amount += $request->input('amount');
        $row->save();
        $items = json_decode($request->input('items'));
        $this->commitReceivedItems($row->id, $items);
        return response()->json([
            'status'  => 1,
            'message' => 'Records saved successfully'
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
            $stock = Stock::where('product_id', $item->id)->first();
            if(!$stock) {
                $stock = new Stock();
                $stock->product_id = $item->id;
            }
            $stock->quantity += $item->quantity;
            $stock->save();
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
          } while (Storage::disk('uploads')->exists($testPath));
  
          $check = $file->storeAs( $folder, $newFileName2 . '.' . $file->getClientOriginalExtension(),'uploads');
          return $check;
      }
}
