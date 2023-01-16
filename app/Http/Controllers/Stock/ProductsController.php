<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Http\Controllers\Controller;

class ProductsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  => Product::orderByDesc('id')->get()
        ]);
     }

      /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function store(Request $request){
        // Check if request contain id then perfom update

        if($request->has('id')){
            $Product = Product::find($request->input('id'));
            $message = 'Updated Successfuly!';
        } else{
            $Product = new Product();
        }

        $Product->fill($request->input());
        $Product->save();

        return response()->json([
            'status'=>1,
            'row'   =>Product::find($Product->id)
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Product = Product::findOrFail($id);
        if(!$Product){
            return response()->json([
                'status'=>0,
                'error' =>'Product can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$Product
        ]);
     }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedProduct = Product::findOrFail($id);
        if(!$DeletedProduct){
            return response()->json([
                'status'=>0,
                'error' =>'Product can\'t Found!'
            ]);
        }

        $DeletedProduct ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Product deleted Successfuly!'
        ]);
     } 
}
