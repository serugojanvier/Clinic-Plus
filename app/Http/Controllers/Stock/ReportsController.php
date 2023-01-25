<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Stock;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Models\Stock\StockOut;
use Illuminate\Support\Facades\DB;
use App\Models\Stock\StockReceive;
use App\Models\Stock\StockoutItem;
use App\Models\Stock\StockTransfer;
use App\Http\Controllers\Controller;
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
}