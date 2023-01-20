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
            $insurance = Insurance::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $insurance = new Insurance;
            $insurance->status = 1;
            $message = "Record Saved Successfuly!";
        }

        $insurance->fill($request->input());
        $insurance->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'   => Insurance::find($insurance->id)
        ]);
     }

      /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $insurance = Insurance::findOrFail($id);
        if(!$insurance){
            return response()->json([
                'status'=>0,
                'error' =>'Insurance can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$insurance
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
