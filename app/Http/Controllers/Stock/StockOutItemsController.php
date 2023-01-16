<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\StockoutItem;
use App\Http\Controllers\Controller;

class StockOutItemsController extends Controller
{
      /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  => StockoutItem::orderByDesc('id')->get()
        ]);
     }

     /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function store(Request $request){
        // check if request has id in it then perform update

        if($request->has('id')){
            $StockoutItem = StockoutItem::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $StockoutItem = new StockoutItem();
            $message = "Record Saved Successfuly!";
        }

        $StockoutItem->fill($request->input());
        $StockoutItem->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'   => StockoutItem::find($StockoutItem->id)
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $StockoutItem = StockoutItem::findOrFail($id);
        if(!$StockoutItem){
            return response()->json([
                'status'=>0,
                'error' =>'StockoutItem can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$StockoutItem
        ]);
     }


          /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedStockoutItem = StockoutItem::findOrFail($id);
        if(!$DeletedStockoutItem){
            return response()->json([
                'status'=>0,
                'error' =>'StockoutItem can\'t Found!'
            ]);
        }

        $DeletedStockoutItem ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'StockoutItem deleted Successfuly!'
        ]);
     }
}
