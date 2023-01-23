<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Stock;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Models\Stock\StockOut;
use App\Models\Stock\StockoutItem;
use App\Models\Stock\StockReceive;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\Stock\StockinHistory;
use Illuminate\Support\Facades\Auth;
use App\Models\Stock\ProductCategory;
use Illuminate\Support\Facades\Storage;

class StockController extends Controller
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
        $from = $request->input('from');
        $to = $request->input('to');
        if (empty($from)) {
            $from = date('Y-m-d');
        }
    }

   /**
     * Get all stock receives wih filters
    * @param Request $request
    * @return JsonResponse
    */
    public function getReceives(Request $request)
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
            'rows'   => $result->with('supplier', 'creator', 'company')
                               ->orderBy('id', 'DESC')
                               ->paginate(45)
        ]);
    }
}