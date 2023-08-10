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
use Illuminate\Support\Facades\Cache;
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
                               ->paginate(\request()->query('per_page') ?? 45)
        ]);
    }

    /**
     * Show a receive and its items
     * @param string reference
     * @return JsonResponse
     */
    public function downloadRecieveReport($reference){
        $row = StockReceive::where('reference', $reference)->first();
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'File not found'
            ], 404);
        }

        $pathToFile = storage_path('app/public/' . $row->file_url);
        if (!file_exists($pathToFile)) {
            return response()->json([
                'status' => 0,
                'error'  => 'File not found'
            ], 404);
        }

         return response()->streamDownload(function () use ($pathToFile) {
                $fileStream = fopen($pathToFile, 'rb');
                fpassthru($fileStream);
                fclose($fileStream);
            }, $filename);
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
                               ->paginate(\request()->query('per_page') ?? 45)
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

        // Log::info($result);

        return response()->json([
            'status' => 1,
            'rows'   => $result->groupBy('products.id')
                               ->with('unit')
                               ->orderBy('products.name', 'ASC')
                               ->paginate(\request()->query('per_page') ?? 45)
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
        $result = ProductTracker::select('id','name','unit_id','category_id','quantity as currentQty', 'company_id')
                                    ->where('company_id', auth()->user()->company_id);
        if (!empty($product = $request->get('product'))) {
            $result->where('id', $product)
                    ->where('company_id', auth()->user()->company_id);
        }

        if (!empty($category = $request->get('category'))) {
            $result->where('category_id', $category)
                    ->where('company_id', auth()->user()->company_id);
        }

        if (!empty($scategory = $request->get('scategory'))) {
            $result->where('category_id', $scategory)
                    ->where('company_id', auth()->user()->company_id);
        }

        return response()->json([
            'status' => 1,
            'rows'   => $result
                               ->with('unit','category')
                               ->orderBy('name', 'ASC')
                               ->paginate(\request()->query('per_page') ?? 200)
        ]);
    }

    /**
      * Get Dashboard
      * @param Request $request
      * @return JsonResponse
      */
    public function getDashboard(Request $request)
    {
        $receiveData =  $this->getReceivesDashboard();
        $transferData = $this->getTransfersDashboard();

        $cachesData = [
            'ReceiveData' => (int)$receiveData['amount'],
            'transferData' => (int)$transferData['amount']
        ];

        Cache::put('ReceiveAndTransferStockData', $cachesData, 60);

        return response()->json([
            'stock_value' => Product::selectRaw('COALESCE(SUM(quantity * cost_price), 0) as stock_value')
                                    ->first()
                                    ->stock_value,
            'branch_stock' => Stock::selectRaw('COALESCE(SUM(stock.quantity * products.cost_price), 0) as branch_stock')
                                    ->leftJoin('products', 'stock.product_id', '=', 'products.id')
                                    ->first()
                                    ->branch_stock,
            'receives_amount'  => $receiveData['amount'],      
            'receives_chart'   => $receiveData['chart'], 
            'transfers_amount' => $transferData['amount'],      
            'transfers_chart'  => $transferData['chart'],
            'total_products'   => Product::count(),
            'current_month'    => [date('Y-m-d', strtotime("first day of this month")), date('Y-m-d', strtotime("last day of this month"))]   
        ]);
    }

    /**
     * Get Both total amount and chart data for receive
     * @param array $dates
     * @param int $year
     * @return  array 
     */
    private function getReceivesDashboard($dates = array(), $year = NULL)
    {
        if (!$year) {
            $year = date('Y');
        }
        $amount = StockReceive::sum('amount');
        if (!empty($dates)) {
            $amount->whereBetween('date_received', $dates);
        }
        $monthsData = [];
        for ($i = 1; $i <= 12; $i++) {
            $d = sprintf('%02d', $i);
            $monthsData[] = StockReceive::where('date_received', 'LIKE', "%{$year}-{$d}%")
                                        ->sum('amount');
        }
        return [
            'amount' => $amount,
            'chart'  => $monthsData
        ];
    }

     /**
     * Get Both total amount and chart data for transfer
     * @param array $dates
     * @param int $year
     * @return  array 
     */
    private function getTransfersDashboard($dates = array(), $year = NULL)
    {
        if (!$year) {
            $year = date('Y');
        }
        $amount = StockTransfer::sum('amount');
        if (!empty($dates)) {
            $amount->whereBetween('date_transfered', $dates);
        }
        $monthsData = [];
        for ($i = 1; $i <= 12; $i++) {
            $d = sprintf('%02d', $i);
            $monthsData[] = StockTransfer::where('date_transfered', 'LIKE', "%{$year}-{$d}%")
                                        ->sum('amount');
        }
        return [
            'amount' => $amount,
            'chart'  => $monthsData
        ];
    }

    /**
     * Filter dashboard cards
     * @param Request $request
     * @return JsonResponse
     */
    public function filterDashboardCards(Request $request)
    {
        $from = date('Y-m-d', strtotime($request->get('from')));
        $to   = date('Y-m-d', strtotime($request->get('to')));
        return response()->json([
            'receives_amount'  => StockReceive::whereBetween('date_received', [$from, $to])->sum('amount'), 
            'transfers_amount' => StockTransfer::whereBetween('date_transfered', [$from, $to])->sum('amount')
        ]);
    }
}