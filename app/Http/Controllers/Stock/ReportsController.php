<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Stock;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Models\Stock\StockOut;
use App\Models\Stock\StockoutItem;
use App\Models\Stock\StockReceive;
use Illuminate\Support\Facades\DB;
use App\Models\Stock\StockTransfer;
use App\Http\Controllers\Controller;
use App\Models\Stock\ProductTracker;
use App\Models\Stock\StockinHistory;
use Illuminate\Support\Facades\Auth;
use App\Models\Stock\ProductCategory;
use App\Models\Stock\StockTransferItems;

class ReportsController extends Controller
{
    /**
     * @var $from
     */
    private $from;

    /**
     * @var $to
     */
    private $to;

    public function __construct(Request $request)
    {
        $this->from = $request->input('from');
        $this->to = $request->input('to');
        if (empty($this->from)) {
            $this->from = date('Y-m-d');
        }
    }

   /**
     * Get all stock receives wih filters
    * @param Request $request
    * @return JsonResponse
    */
    public function getReceivesReport(Request $request)
    {
        $result = StockReceive::select('*');
        if (!empty($company = $request->input('company'))) {
            $result->where('company_id', $company);
        }
        if (!empty($supplier = $request->input('supplier'))) {
            $result->where('supplier_id', $supplier);
        }
        if (empty($this->to)) {
            $result->where('date_received', $this->from);
        } else {
            $result->where('date_received', '>=', $this->from)
                   ->where('date_received', '<=', $this->to);
        }
        return response()->json([
            'status' => 1,
            'rows'   => $result->with('supplier', 'creator')
                               ->orderBy('id', 'DESC')
                               ->paginate(45)
        ]);
    }

    /**
     * Get all stock receives wih filters
    * @param Request $request
    * @return JsonResponse
    */
    public function getTransfersReport(Request $request)
    {
        $result = StockTransfer::select('*');
        if (!empty($company = $request->input('company'))) {
            $result->where('company_id', $company);
        }
        if (!empty($department = $request->input('department'))) {
            $result->where('department_id', $department);
        }
        if (empty($this->to)) {
            $result->where('date_transfered', $this->from);
        } else {
            $result->where('date_transfered', '>=', $this->from)
                   ->where('date_transfered', '<=', $this->to);
        }
        return response()->json([
            'status' => 1,
            'rows'   => $result->with('department', 'creator', 'employee')
                               ->orderBy('id', 'DESC')
                               ->paginate(45)
        ]);
    }

    /**
     * Get Tracker Report
     * @param Request $request
     * @return JsonResponse
     */
    public function getTrackerReport(Request $request)
    {
        $result = Product::selectRaw('products.id, products.name, products.unit_id, products.quantity as currentQty, SUM(stockin_histories.quantity) AS receiveQty, SUM(stock_transfer_items.quantity) AS transferedQty');
        if (empty($this->to)) {
            $result->leftJoin('stockin_histories', function($join) {
                $join->on('products.id', '=', 'stockin_histories.product_id');
                $join->on(DB::raw("date(stockin_histories.created_at)"), "=", DB::raw("'".$this->from."'"));
            });
            $result->leftJoin('stock_transfer_items', function($join) {
                $join->on('products.id', '=', 'stock_transfer_items.product_id');
                $join->on(DB::raw("date(stock_transfer_items.created_at)"), "=", DB::raw("'".$this->from."'"));
            });
        } else {
            $result->leftJoin('stockin_histories', function($join) {
                $join->on('products.id', '=', 'stockin_histories.product_id');
                $join->on(DB::raw("date(stockin_histories.created_at)"), ">=", DB::raw($this->from));
                $join->on(DB::raw("date(stockin_histories.created_at)"), "<=", DB::raw($this->to));
            });
            $result->leftJoin('stock_transfer_items', function($join) {
                $join->on('products.id', '=', 'stock_transfer_items.product_id');
                $join->on(DB::raw("date(stock_transfer_items.created_at)"), ">=", DB::raw($this->from));
                $join->on(DB::raw("date(stock_transfer_items.created_ats)"), "<=", DB::raw($this->to));
            });
        }

        return response()->json([
            'status' => 1,
            'rows'   => $result->groupBy('products.id')
                               ->with('unit')
                               ->orderBy('products.name', 'ASC')
                               ->paginate(45)
        ]);
    }
    /**
     * Formula for tracker
     * (45-20) + (60+44) = 
        25+104 = 129

        (129+20) - (60+44) = 

        const prevQty = 129;
        let currentQty = 45;
        let receiveQty = 20;
        let transfered = 60;
        let wasted = 44;
     */


     /**
      * Track stock item based on \App\Models\Stock\ProductTracker Model
      * @param Request $request
      * @return JsonResponse
      */

    public function trackProductsStock(Request $request)
    {
        $result = ProductTracker::select('id','name','unit_id','quantity as currentQty');
        if (!empty($product = $request->get('product'))) {
            $result->where('id', $product);
        }
        return response()->json([
            'status' => 1,
            'rows'   => $result
                               ->with('unit')
                               ->orderBy('name', 'ASC')
                               ->paginate(45)
        ]);
    }
}