<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\Insurance;
use App\Http\Controllers\Controller;

class InsurancesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  => Insurance::orderByDesc('id')->get()
        ]);
     }

     /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function store(Request $request){
        // check if request has id then perfom update

        if($request->has('id')){
            $Insurance = Insurance::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $Insurance = new Insurance;
            $message = "Record Saved Successfuly!";
        }

        $Insurance->fill($request->input());
        $Insurance->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'   => Insurance::find($Insurance->id)
        ]);
     }


      /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Insurance = Insurance::findOrFail($id);
        if(!$Insurance){
            return response()->json([
                'status'=>0,
                'error' =>'Insurance can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$Insurance
        ]);
     }


     /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedInsurance = Insurance::findOrFail($id);
        if(!$DeletedInsurance){
            return response()->json([
                'status'=>0,
                'error' =>'Insurance can\'t Found!'
            ]);
        }

        $DeletedInsurance ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Insurance deleted Successfuly!'
        ]);
     }  
}
