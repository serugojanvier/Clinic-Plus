<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Stock\ProductCategory as Category;
class CategoriesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $categories = Category::select('*');
        if (!empty($parent = $request->get('parent_id'))) {
            $categories->where('parent_id', $parent);
        } else {
            $categories->where(function ($query) {
                $query->whereNull('parent_id')
                      ->orWhere('parent_id', 0)
                      ->orWhere('parent_id', '');
            });
        }
        return response()->json([
            'status' => 1,
            'rows'   => $categories->orderByDesc('id')->get()
        ]);
    }

        /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function subcategory(Request $request)
    {
        $categories = Category::select('*');
        $categories->where(function ($query) {
            $query->whereNotNull('parent_id');
        });
        
        return response()->json([
            'status' => 1,
            'rows'   => $categories->orderByDesc('id')->get()
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
            $category = Category::find($request->input('id'));
        } else{
            $category = new Category();
        }

        $category->fill($request->input());
        $category->save();

        return response()->json([
            'status'=>1,
            'row'   => Category::find($category->id)
        ]);
     }


     /**
     * Display the subcategories of specified category resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Pcategory = Category::where('parent_id','=',$id)->orderBy('id', 'ASC')->get();
        if (sizeof($Pcategory)==0) {
            return response()->json([
                'status' => 0,
                'error'  => 'SubCategory not found'
            ]);
        }

        return response()->json([
            'status' => 1,
            'rows'    => $Pcategory
        ]);
     }


     /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $Pcategory = Category::findOrFail($id);
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

    /**
     * search fora category
     * @param Request $request
     * @return JsonResponse
     */
    public function search(Request $request)
    {
        $result = Category::select('id', 'name');
        $keyword = $request->get('query');
        if (empty($keyword)) {
            return  response()->json($result->orderBy('name', 'ASC')->take(50)->get());
        } else {
            return response()->json($result->where('name', 'LIKE', '%' . $keyword . '%')->orderBy('name', 'ASC')->get());
        }
    }
}
