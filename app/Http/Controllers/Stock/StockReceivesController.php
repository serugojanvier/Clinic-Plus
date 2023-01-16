<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\StockReceive;
use App\Http\Controllers\Controller;

class StockReceivesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  => StockReceive::orderByDesc('id')->get()
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
            $StockReceive = StockReceive::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $StockReceive = new StockReceive();
            $message = "Record Saved Successfuly!";
        }

        $StockReceive->fill($request->input());
        $StockReceive->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'   => StockReceive::find($StockReceive->id)
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $StockReceive = StockReceive::findOrFail($id);
        if(!$StockReceive){
            return response()->json([
                'status'=>0,
                'error' =>'Stock Received can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$StockReceive
        ]);
     }


          /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedStockReceive = StockReceive::findOrFail($id);
        if(!$DeletedStockReceive){
            return response()->json([
                'status'=>0,
                'error' =>'StockReceive can\'t Found!'
            ]);
        }

        $DeletedStockReceive ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'StockReceive deleted Successfuly!'
        ]);
     }
}
