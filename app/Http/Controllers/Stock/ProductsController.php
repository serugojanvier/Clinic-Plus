<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Unit;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Http\Controllers\Controller;
use App\Models\Stock\ProductCategory;

class ProductsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index()
     {
        return response()->json([
            'status'=>1,
            'rows'  => Product::orderByDesc('id')->with('category', 'unit')->paginate(45)
        ]);
     }

      /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function store(Request $request)
     {
        // Check if request contain id then perfom update

        if($request->has('id')){
            $product = Product::find($request->input('id'));
        } else{
            $product = new Product();
            $product->reference = generateReference(20);
            $product->status = 1;
            $product->quantity = 0;
            if (empty($request->input('code'))) { 
                $product->code = generateRowCode(8);
            }
        }

        $product->fill($request->input());
        $product->save();

        return response()->json([
            'status' => 1,
            'row'    => Product::where('id', $product->id)->with('creator', 'company', 'category', 'unit')->first()
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id)
     {
        $product = Product::findOrFail($id);
        if(!$product){
            return response()->json([
                'status'=> 0,
                'error' => 'Product can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=> 1,
            'row'   => $product
        ]);
     }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $product = Product::findOrFail($id);
        if(!$product){
            return response()->json([
                'status'=>0,
                'error' =>'Product can\'t Found!'
            ]);
        }

        $product ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Product deleted Successfuly!'
        ]);
     } 

     /**
     * search fora category
     * @param Request $request
     * @return JsonResponse
     */
    public function search(Request $request)
    {
        $result = Product::select('products.id', 'products.name', 'code', 'cost_price', 'quantity', 'rhia_price', 'private_price','inter_price', 'units.name as unit')
                          ->leftJoin('units', 'products.unit_id', '=', 'units.id');
        if (!empty($request->get('with_quantity'))) {
            $result->where('quantity', '>', 0);
        }        
        $keyword = $request->get('query');
        if (empty($keyword)) {
            return  response()->json($result->orderBy('products.name', 'ASC')->take(250)->get());
        } else {
            return response()->json($result->where('products.name', 'LIKE', '%' . $keyword . '%')->orderBy('name', 'ASC')->get());
        }
    }

    /**
     * Get products extraxs
     * @return JsonResponse
     */
    public function extras()
    {
        return response()->json([
            'status'     => 1,
            'categories' => ProductCategory::orderBy('name', 'ASC')->get(),
            'units'      => Unit::all()
        ]);
    }

    /**
      * 
      * Handle Bulk Delete
      * @param string $id
      * @return \Illuminate\Http\JsonResponse
      */
      public function bulkDelete($ids)
      {
         $products = explode(",", $ids);
         Product::whereIn('id', $products)->delete();
         
         return response()->json([
             'status' => 1,
             'message' => 'Products deleted Successfuly!'
         ]);
      }
}
