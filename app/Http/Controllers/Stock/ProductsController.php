<?php

namespace App\Http\Controllers\Stock;

use Carbon\Carbon;
use App\Models\Stock\Unit;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Models\Stock\StockReceive;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Http\Controllers\Controller;
use App\Models\Stock\StockinHistory;
use Illuminate\Support\Facades\Auth;
use App\Models\Stock\ProductCategory;
use Illuminate\Support\Facades\Storage;

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
            'rows'  => Product::orderByDesc('id')->with('category', 'unit')->paginate(\request()->query('per_page') ?? 45)
        ]);
     }


     /**
      * Upload file
      */
      public function storeFile(Request $request)
      {
          $file = $request->file('file');
          $folder = 'product_images/';
          $id = Auth::id();
          if ($id) {
              $folder .= sprintf('%04d', (int)$id / 1000) . '/' . $id . '/';
          }
          $folder = $folder . date('Y/m/d');
          $newFileName = Str::slug(substr($file->getClientOriginalName(), 0, strrpos($file->getClientOriginalName(), '.')));
          if(empty($newFileName)) $newFileName = md5($file->getClientOriginalName());
  
          $i = 0;
          do {
              $newFileName2 = $newFileName . ($i ? $i : '');
              $testPath = $folder . '/' . $newFileName2 . '.' . $file->getClientOriginalExtension();
              $i++;
          } while (Storage::disk('public')->exists($testPath));
  
          $check = $file->storeAs( $folder, $newFileName2 . '.' . $file->getClientOriginalExtension(),'public');
          $product = Product::find($request->input('product_id'));
          
          $fullPath = Storage::path('public/'.$product->image);
          $pathToUnlink = str_replace('/','\\',$fullPath);
          if(!empty($product->image)) {
            unlink($pathToUnlink); 
          }
          
          $product->image = $check;
          $product->save();
          return response()->json([
            'status'  => 1,
            'path'    => $check,
            'message' => 'Saved sucessfully'
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
        $product->cost_price = $request->input('cost_price');
        $product->rhia_price = $request->input('rhia_price');
        $product->private_price = $request->input('private_price');
        $product->inter_price = $request->input('inter_price');
        $product->packaging = $request->input('packaging');
        $product->image = NULL;
        $product->save();
        $id = $product->id;

        return response()->json([
            'status' => 1,
            'row'    => Product::where('id', $product->id)->with('creator', 'company', 'category', 'unit')->first()
        ]);
     }

    /**
     * Show Expired Products.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function expired(){
        $expired = 'EXPIRED';
        // $expiredData = StockReceive::select('stockin_histories.quantity,stockin_histories.consumed_qty, stockin_histories.expiration_date, stockin_histories.status')
        //                             ->join('stockin_histories','stock_receives.id', '=', 'stockin_histories.stockin_id')
        //                             ->where('stockin_histories.status', $expired)
        //                             ->with('product')
        //                             ->paginate(\request()->query('per_page') ?? 45);
        $expiredData = StockReceive::select('stockin_histories.quantity','stockin_histories.consumed_qty','stockin_histories.expiration_date', 'products.name', 'stockin_histories.price', 'units.name AS unit', 'stockin_histories.status', 'product_categories.name AS category')
                        ->join('stockin_histories', 'stock_receives.id', '=', 'stockin_histories.stockin_id')
                        ->join('products', 'products.id', '=', 'stockin_histories.product_id')
                        ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                        ->leftJoin('product_categories', 'product_categories.id', '=', 'products.category_id')
                        ->where('stockin_histories.status', $expired)
                        ->paginate(\request()->query('per_page') ?? 45);
                        
        return response()->json([
            'status' => 1,
            'rows'  => $expiredData
        ]);
     }

    /**
     * Show Expired Products.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function expirationCheckInthreeMo(){
        $products = StockReceive::select('stockin_histories.quantity','stockin_histories.consumed_qty','stockin_histories.expiration_date', 'products.name', 'stockin_histories.price', 'units.name AS unit', 'stockin_histories.status', 'product_categories.name AS category')
                                ->join('stockin_histories', 'stock_receives.id', '=', 'stockin_histories.stockin_id')
                                ->join('products', 'products.id', '=', 'stockin_histories.product_id')
                                ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                                ->leftJoin('product_categories', 'product_categories.id', '=', 'products.category_id')
                                ->whereDate('stockin_histories.expiration_date', '<=', Carbon::now()->addMonths(3))
                                ->whereNotIn('stockin_histories.status', ['EXPIRED', 'CONSUMED'])
                                ->orderBy('stockin_histories.expiration_date', 'ASC')
                                ->get();

        if ($products->isNotEmpty()) {
            return response()->json([
                'message' => "expired products",
                'products' => $products
            ]);
        }
        
        return response()->json([
                'message' => "No expired products found",
                'products' => []
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
        if (empty($department = $request->input('department'))) {
            $result = Product::select('products.id', 'products.name', 'code', 'cost_price', 'quantity', 'rhia_price', 'private_price','inter_price', 'units.name as unit')
                          ->leftJoin('units', 'products.unit_id', '=', 'units.id');
            if (!empty($request->get('with_quantity'))) {
                $result->where('quantity', '>', 0);
            }
        } else {
            $result = Product::select('products.id', 'products.name', 'code', 'cost_price', 'stock.quantity', 'rhia_price', 'private_price','inter_price', 'units.name as unit')
                          ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                          ->leftJoin('stock', function($join) use ($department){
                            $join->on('products.id', '=', 'stock.product_id');
                            $join->on('stock.department_id', '=', DB::raw("{$department}"));
                          });
            if (!empty($request->get('with_quantity'))) {
                $result->where('stock.quantity', '>', 0);
            }
        }
          
        $keyword = $request->get('query');
        if (empty($keyword)) {
            return  response()->json($result->orderBy('products.name', 'ASC')->take(1000)->get());
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
