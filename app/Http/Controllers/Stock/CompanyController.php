<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\Company;
use App\Http\Controllers\Controller;

class CompanyController extends Controller
{
     /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  =>Company::OrderByDesc('id')->get()
        ]);
     }

     /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function store(Request $request){

        // if request has id then perfom update
        if($request->has('id')){
            $Company = Company::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $Company = new Company();
            $message = "Record Saved Successfuly!";
        }

        $Company ->fill($request->input());
        $Company->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'    => Company::find($Company->id)
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Company = Company::findOrFail($id);
        if(!$Company){
            return response()->json([
                'status'=>0,
                'error' =>'Company can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$Company
        ]);
     }

     /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedCompany = Company::findOrFail($id);
        if(!$DeletedCompany){
            return response()->json([
                'status'=>0,
                'error' =>'Company can\'t Found!'
            ]);
        }

        $DeletedCompany ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Company deleted Successfuly!'
        ]);
     }
}
