<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\Stock;
use App\Http\Controllers\Controller;

class StockController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  => Stock::orderByDesc('id')->get()
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
            $Stock = Stock::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $Stock = new Stock();
            $message = "Record Saved Successfuly!";
        }

        $Stock->fill($request->input());
        $Stock->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'   => Stock::find($Stock->id)
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Stock = Stock::findOrFail($id);
        if(!$Stock){
            return response()->json([
                'status'=>0,
                'error' =>'Stock can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$Stock
        ]);
     }


          /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedStock = Stock::findOrFail($id);
        if(!$DeletedStock){
            return response()->json([
                'status'=>0,
                'error' =>'Stock can\'t Found!'
            ]);
        }

        $DeletedStock ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Stock deleted Successfuly!'
        ]);
     }  
}
