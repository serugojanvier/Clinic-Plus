<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Sale;
use App\Models\Stock\Stock;
use Illuminate\Http\Request;
use App\Models\Stock\SaleItem;
use App\Models\Stock\Payment;
use App\Models\Stock\Product;
use Illuminate\Support\Facades\DB;
use App\Models\Stock\PaymentMethod;
use App\Http\Controllers\Controller;

class POSController extends Controller
{
     /**
     * Get All sales Items 
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function salesItems(Request $request)
    {
        return response()->json([
            'status' => 1,
            'rows'   => Product::select('id', 'name', 'reference', 'private_price as price', 'quantity', 'category_id')
                                ->orderBy('products.name', 'ASC')
                                ->get()
        ]);
    }

     /**
     * List all Orders
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $result = Sale::selectRaw('id, reference, committed_date, discounted_total, amount_paid, amount_remain, client_id, paid, branch_id, create_user, comment, payment_date')
                        ->where('sales.type', 'POS_SALE');

        $from = date('Y-m-d');
        if(!empty($fromd = $request->get('from'))){
            $from = $fromd;
        }

        $to = $request->get('to');
        if (empty($to)){
            $result->where('committed_date', $from);
        } else {
            $result->where('committed_date', '>=', $from)
                    ->where('committed_date', '<=', $to);
        }

        if (!empty($branch = $request->get('branch_id'))) {
            $result->where('branch_id', $branch);
        }
        if (!empty($client = $request->get('client_id'))) {
            $result->where('client_id', $client);
        }
        if (!empty($waiter = $request->get('waiter_id'))) {
            $result->where('create_user', $waiter);
        }
       
        return response()->json([
            'status' => 1,
            'rows'   => $result->with('client')
                               ->orderBy('id', 'DESC')
                               ->paginate(45)
        ]);
    }

    /**
     * Place a new Order
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $data = [
            'total_amount'   => $request->input('total_amount'),	
            'discounted_total' => $request->input('discounted_total'),	
            'create_user'      => $request->input('waiter_id') ?? auth()->id(),	
            'comment'          => $request->input('comment'),	
            'amount_paid'      => $request->input('amount_paid') ?? 0,
            'amount_remain'    => $request->input('amount_remain'),	
            'discount_perc'    => $request->input('discount'),
            'discount_amount'  => $request->input('discount_amount'),
            'payment_date'     => $request->input('payment_date'),
            'client_id'        => is_numeric($request->input('client_id')) ? $request->input('client_id') : NULL,	
            'paid'             => $request->input('amount_remain') == 0,
            'committed_date'   => $request->input('committed_date') ?? date('Y-m-d')
        ];

        if ($request->has('id')) {
            $order = Sale::find($request->input('id'));
            $this->draftSaleItems($order, 'edit');
            Sale::where('id', $order->id)->update($data);
        } else {
            $data = array_merge($data, [
                'type'        => 'POS_SALE',
                'reference'   => generateRowCode(8)
            ]);
            $order = Sale::create($data);
        }
        if ($request->input('amount_paid') != 0) {
            $amountPaid = $request->input('amount_paid') ?? 0;
            Payment::create([
                'committed_date' => $request->input('payment_date'),	
                'transaction_id' => $order->id,	
                'payment_type'   => $request->input('payment_method'),
                'amount_paid'    => $amountPaid,	
                'comment'        => $request->input('comment'),
                'reference'      => $request->input('payment_ref'),
                'create_user'    => auth()->id()
            ]);
        }
    
        $items = json_decode($request->input('items'));
        foreach($items as $item) {
            SaleItem::create([
                'sale_id'  => $order->id,
                'item_id'  => $item->id,
                'quantity' => $item->quantity,
                'price'    => $item->price,
                'amount'   => $item->quantity * $item->price,
                'comment'  => $item->comment ?? NULL
            ]);
            /**
             * Remove products Qty
             */
            $product = Product::find($item->id);
            $product->quantity -= $item->quantity;
            $product->save();
        }
        
        return response()->json([
            'status'  => 1,
            'success' => 'Sale created successfully'
        ]);
    }

    /**
     * Handle Delete
     * @return JsonResponse
     */
    public function handleDestroy($saleId)
    {
        $sale = Sale::find($saleId);
        if (!$sale) {
            return response()->json([
                'status' => 0,
                'error'  => 'No record found'
            ], 404);
        }
        $this->draftSaleItems($sale);
        $sale->delete();
        return response()->json([
            'status' => 1,
            'message' => 'Deleted successfully'
        ]);
    }

    /**
     * Delete made payments for a particular sale
     * Delete sale Items
     * Delete consumed Ingredients
     * @param Modules\Api\Models\Sale $saleId
     * @return void
     */
    private function draftSaleItems(Sale $sale, $action = 'delete')
    {
        $items = SaleItem::where('sale_id', $sale->id)->get();
        foreach ($items as $row) {
            $product = Product::find($row->item_id);
            $product->quantity += $row->quantity;
            $product->save();
            if ($action == 'edit') {
                DB::table('sale_items')->where('id', $row->id)->delete();
            } else {
                $ingredient->delete();
            }
        }
        /** Delete all payments */
        $payments = Payment::where('transaction_id', $sale->id)->get();
        foreach ($payments as $payment) {
            handleAccountBalance($payment->account_id, -$payment->amount_paid);
            if ($action == 'edit') {
                //$payment->forceDelete();
                DB::table('payments')->where('id', $payment->id)->delete();
            } else {
                $payment->delete();
            }
        }
    }

    /**
     * Get Sales Items
     * @param int $id
     * @return ResponseJson
     */
    public function getSaleItems($id)
    {
        $items = SaleItem::selectRaw('sale_items.item_id, sale_items.quantity, sale_items.price, sale_items.amount as total_amount, products.name, units.name As unit')
                            ->join('products', 'sale_items.item_id', '=', 'products.id')
                            ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                            ->where('sale_id', $id)
                            ->get();
        //$items = $items->makeHidden(['product']);
        return response()->json([
            'status'  => 1,
            'items'   => $items
        ]);
    }

    /**
     * Public function get Dashboard
     * @param Request $request
     * @return JsonResponse
     */
    public function getDashboardData(Request $request)
    {
        $yearMonth = date('Y-m');
        $year = date('Y');
        if(!empty($from = $request->get('yearMonth'))){
            $yearMonth = date('Y-m', strtotime($from));
            $year = date('Y', strtotime($from));
        }

        $pendingChart = $paidChart = $labels = [];
        $days = getMonthDays(date('m', strtotime($yearMonth)), $year);
        for ($i = 1; $i <= count($days); $i++) {
            $labels[] = sprintf("%02d", $i);
            $pendingChart[] = Sale::where('type', 'POS_SALE')->where("committed_date", $days[$i - 1])->where('paid', 0)->sum('discounted_total');   
            $paidChart[]    = Sale::where('type', 'POS_SALE')->where("committed_date", $days[$i - 1])->where('paid', 1)->sum('discounted_total');   
        }

        $mostSold =  DB::table('sale_items')->selectRaw('products.name, SUM(sale_items.quantity) as freq')
                        ->join('sales', 'sale_items.sale_id', '=', 'sales.id')
                        ->join('products', 'sale_items.item_id', '=', 'products.id')
                        ->where('sales.committed_date', 'LIKE', "%{$yearMonth}%")
                        ->whereNull('sales.deleted_at');
        $branch = auth()->user()->branch_id;
        if (!$branch) {
            $branch = \request()->get('current_branch');
        }
        if (!empty($branch)) {
            $mostSold->where('sales.branch_id', $branch);
        }

        return response()->json([
            'sales_count'    => Sale::where('type', 'POS_SALE')->where('committed_date', 'LIKE', "%{$yearMonth}%")->count(),
            'total_sales'    => Sale::where('type', 'POS_SALE')->where('committed_date', 'LIKE', "%{$yearMonth}%")->sum('discounted_total'),
            'total_paid'     => Sale::where('type', 'POS_SALE')->where('committed_date', 'LIKE', "%{$yearMonth}%")->where('paid', 1)->sum('discounted_total'),
            'total_pending'  => Sale::where('type', 'POS_SALE')->where('committed_date', 'LIKE', "%{$yearMonth}%")->where('paid', 0)->sum('discounted_total'),
            'labels'         => $labels,
            'pending_chart'  => $pendingChart,
            'paid_chart'  => $paidChart,
            'most_sold'   => $mostSold->groupBy('sale_items.item_id')->orderBy('freq', 'DESC')->limit(10)->get()->pluck('freq', 'name')
        ]);
    }
  
    /** 
     * Get sale Collection
     * @param $reference
     * @return @return \Illuminate\Support\Collection
     */

     public function getSaleData(string $reference)
     {
        $sale = Sale::selectRaw('id, reference, committed_date, discounted_total, amount_paid, amount_remain, client_id, paid, branch_id, create_user')
                    ->where('reference', $reference)
                    //->with(/*'client', 'creator', 'branch', */'payment')
                    ->first()
                    ->makeVisible(['payments']);

        return response()->json([
            'status' => 1,
            'record' => $sale,
            'items'  => SaleItem::selectRaw('sale_items.item_id, sale_items.quantity, sale_items.price, sale_items.amount as total_amount, products.name, units.name As unit, products.id')
                            ->join('products', 'sale_items.item_id', '=', 'products.id')
                            ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                            ->where('sale_id', $sale->id)
                            ->get()
        ]);
     }

     /**
      * Get Payment methods
      * @return Jsonresponse
      */
      public function getPaymentMethod()
      {
        return response()->json([
            'status' => 1,
            'rows'   => PaymentMethod::get()
        ]);
      }
}