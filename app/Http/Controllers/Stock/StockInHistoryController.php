<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Stock\StockinHistory;

class StockInHistoryController extends Controller
{
   /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  => StockinHistory::orderByDesc('id')->get()
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
            $StockinHistory = StockinHistory::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $StockinHistory = new StockinHistory();
            $message = "Record Saved Successfuly!";
        }

        $StockinHistory->fill($request->input());
        $StockinHistory->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'   => StockinHistory::find($StockinHistory->id)
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $StockinHistory = StockinHistory::findOrFail($id);
        if(!$StockinHistory){
            return response()->json([
                'status'=>0,
                'error' =>'StockinHistory can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$StockinHistory
        ]);
     }


          /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedStockinHistory = StockinHistory::findOrFail($id);
        if(!$DeletedStockinHistory){
            return response()->json([
                'status'=>0,
                'error' =>'StockinHistory can\'t Found!'
            ]);
        }

        $DeletedStockinHistory ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'StockinHistory deleted Successfuly!'
        ]);
     }
}
