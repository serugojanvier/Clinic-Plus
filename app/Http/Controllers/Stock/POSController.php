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
            $pendingChart[] = Sale::where("committed_date", $days[$i - 1])->where('paid', 0)->sum('discounted_total');   
            $paidChart[]    = Sale::where("committed_date", $days[$i - 1])->where('paid', 1)->sum('discounted_total');   
        }

        return response()->json([
            'sales_count'    => Sale::where('committed_date', 'LIKE', "%{$yearMonth}%")->count(),
            'total_sales'    => Sale::where('committed_date', 'LIKE', "%{$yearMonth}%")->sum('discounted_total'),
            'total_paid'     => Sale::where('committed_date', 'LIKE', "%{$yearMonth}%")->where('paid', 1)->sum('discounted_total'),
            'total_pending'  => Sale::where('committed_date', 'LIKE', "%{$yearMonth}%")->where('paid', 0)->sum('discounted_total'),
            'labels'         => $labels,
            'pending_chart'  => $pendingChart,
            'paid_chart'  => $paidChart
        ]);
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
            'sales_count'    => Sale::where('committed_date', '>=', $from)->where('committed_date', '<=', $to)->count(),
            'total_sales'    => Sale::where('committed_date', '>=', $from)->where('committed_date', '<=', $to)->sum('discounted_total'),
            'total_paid'     => Sale::where('committed_date', '>=', $from)->where('committed_date', '<=', $to)->where('paid', 1)->sum('discounted_total'),
            'total_pending'  => Sale::where('committed_date', '>=', $from)->where('committed_date', '<=', $to)->where('paid', 0)->sum('discounted_total'),
        ]);
    }

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
            'rows'   => Product::select('id', 'name', 'image', 'reference', 'private_price as price', 'quantity as qty', 'category_id', 'unit_id')
                                ->orderBy('products.name', 'ASC')
                                ->with('unit','category')
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
        if (empty($isAdmin = $request->get('is_admin'))) {
            $result->where('create_user', auth()->id());
        }
       
        return response()->json([
            'status' => 1,
            'rows'   => $result->with('client', 'creator')
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
            'message' => 'Save sucessfully',
            'order'   => Sale::selectRaw('id, reference, committed_date, discounted_total, amount_paid, amount_remain, client_id, paid, branch_id, create_user, comment, payment_date')
                                 ->where('sales.id', $order->id)->with('client', 'creator', 'items')->first()
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
     * Delete sale Item
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
                $row->delete();
            }
        }
        /** Delete all payments */
        $payments = Payment::where('transaction_id', $sale->id)->get();
        foreach ($payments as $payment) {
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

      
     /**
      * Get Payment methods
      * @return Jsonresponse
      */

      public function getPaymentHistory(Request $request)
      {
        $result = Payment::select('*');

        $from = date('Y-m-d');
        if(!empty($fromd = $request->get('from'))){
            $from = $fromd;
        }

        $to = $request->get('to');
        if (empty($to)){
            $result->where('created_at', 'like', '%' . $from . '%');
        } else {
            $result->where('created_at', '>=', $from)
                    ->where('created_at', '<=', $to);
        }

        if (!empty($payment_type = $request->get('payment_type'))) {
            $result->where('payment_type', $payment_type);
        }
        
        return response()->json([
            'status' => 1,
            'rows'   => $result->with('transaction', 'creator')
                               ->orderBy('id', 'DESC')
                               ->paginate(45),
        ]);
      }

      /**
       * Handle Partial Payment
       */
    public function handlePartialPayment(Request $request)
    {
        $row = Sale::findOrFail($request->input('record_id'));
        if(!empty($row)){
            $row->amount_paid += $request->input('amount_paid');
            $row->amount_remain -= $request->input('amount_paid');
            $row->paid = $request->input('amount_remain') <= 0;
            $row->save();
            Payment::create([
                'committed_date' => $request->input('committed_date') ?? $request->input('payment_date'),	
                'transaction_id' => $row->id,	
                'payment_type'   => $request->input('payment_method'),
                'amount_paid'    => $request->input('amount_paid') ?? 0,	
                'comment'        => $request->input('comment'),
                'reference'      => $request->input('payment_ref'),
                'create_user'    => auth()->id()
            ]);
        }
        return response()->json([
            'status'  => 1,
            'message' => 'Record saved successfully'
        ]);
    }
}