<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Stock\ProductCategory;

class ProductCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json([
            'status' => 1,
            'rows'   => ProductCategory::orderByDesc('id')->get()
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
            $Pcategory = ProductCategory::find($request->input('id'));
        } else{
            $Pcategory = new ProductCategory();
        }

        $Pcategory->fill($request->input());
        $Pcategory->save();

        return response()->json([
            'status'=>1,
            'row'   => ProductCategory::find($Pcategory->id)
        ]);
     }


     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Pcategory = ProductCategory::findOrFail($id);
        if(!$Pcategory){
            return response()->json([
                'status'=>0,
                'error' =>'Product Category can\'t Found!'
            ]);
        } else{
            return response()->json([
                'status'=>1,
                'row'   =>$Pcategory
            ]);
        }
     }

     /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $Pcategory = ProductCategory::findOrFail($id);
        if(!$Pcategory){
            return response()->json([
                'status'=>0,
                'error' =>'Product Category can\'t Found!'
            ]);
        }

        $Pcategory->delete();

        return response()->json([
            'status'=>0,
            'message'=>'Product Category deleted Successfuly!'
        ]);
     }
}
