<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Stock;
use App\Models\Stock\StockOut;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Models\Stock\StockReceive;
use Illuminate\Support\Facades\DB;
use App\Models\Stock\StockoutItem;
use App\Models\Stock\StockinHistory;
use App\Http\Controllers\Controller;
use App\Models\Stock\ProductCategory;

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
            'date_receives' => $request->input('date_receives'),
            'supplier_id'   => $request->input('supplier_id'),
            'amount'        => $request->input('amount'),
            'vat'           => $request->input('vat'),
            'file_url'      => $request->input('file_url'),
        ])->id;

        $items = json_decode($request->input('items'));
        $this->commitRecievedItems($id, $items);
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
        $this->commitRecievedItems($row->id, $items);
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
     private function commitRecievedItems($receivedId, $items)
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
      * Get all stock receives wih filters
      * @param Request $request
      * @return JsonResponse
      */
     public function getReceives(Request $request)
     {
       
     }
}
