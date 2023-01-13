<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\Supplier;
use App\Http\Controllers\Controller;

class SuppliersController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  => Supplier::orderByDesc('id')->get()
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
            $Supplier = Supplier::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $Supplier = new Supplier();
            $message = "Record Saved Successfuly!";
        }

        $Supplier->fill($request->input());
        $Supplier->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'   => Supplier::find($Supplier->id)
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Supplier = Supplier::findOrFail($id);
        if(!$Supplier){
            return response()->json([
                'status'=>0,
                'error' =>'Supplier can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$Supplier
        ]);
     }


          /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedSupplier = Supplier::findOrFail($id);
        if(!$DeletedSupplier){
            return response()->json([
                'status'=>0,
                'error' =>'Supplier can\'t Found!'
            ]);
        }

        $DeletedSupplier ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Supplier deleted Successfuly!'
        ]);
     }  
}
