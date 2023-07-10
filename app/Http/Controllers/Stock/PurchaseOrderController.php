<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\stock\PurchaseOrder;
use App\Http\Controllers\Controller;
use App\Notifications\ChannelServices;
use App\Models\stock\PurchaseOrderItem;
use Illuminate\Support\Facades\Notification;

class PurchaseOrderController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * Return PurchaseOrder
     * @param Request $request
     * @return JsonResponse
     */
    public function index(Request $request, $reference = NULL)
    {
        $from = $request->input('from');
        $to = $request->input('to');
        if (empty($from)) {
            $from = date('Y-m-d');
        }

        $result = PurchaseOrder::select('*')->with('creator');
        if (!empty($status = \request()->query('status'))) {
            $result->where('status', $status);
        }

        if (empty($to)) {
            $result->where('date_initiated', $from);
        } else {
            $result->where('date_initiated', '>=', $from)
                   ->where('date_initiated', '<=', $to);
        }

        if (!empty($reference)) {
            $result->where('reference', $reference);
        }

        return response()->json([
            'status' =>1,
            'rows'   =>  $result->orderBy('status', 'ASC')
                            ->orderBy('id', 'DESC')
                            ->paginate(\request()->query('per_page') ?? 45)
        ]);
    }

    /**
     * Store Purchase Order Item
     * @param Request $request
     * @return JsonResponse
     */
    public function store(Request $request)
    {
        $items = json_decode($request->input('items'));
        $reference = generateRowCode(20);
        $id = PurchaseOrder::create([
            'reference'      =>  $reference,	
            'date_initiated' =>  $request->input('date_initiated'),
            'amount'        => $request->input('amount'),
            'status'        => 'PENDING'
        ])->id;

        foreach($items as $item){
            PurchaseOrderItem::create([
                'order_id' => $id,
                'product_id'    => $item->id,
                'order_qty' => $item->quantity,
                'price' => $item->price,
                'requested_qty'  => $item->quantity
            ]);
        }
        $currentUser = auth()->user();
        $users = getNotifiableUsers($currentUser);
        $itemsCount = sizeof($items);
        $data = [
            'id'   => $id,
            'slug' => $reference,
            'type' => 'Purchase Order',
            'link' => 'purchase-order',
            'message' => "New Purchase Order from <b>{$currentUser->name}</b> of <b>{$itemsCount}</b> items!</b>" 
        ];
        Notification::sendNow($users, new ChannelServices($data));
        return response()->json([
            'status' => 1,
            'message' => 'Purchase Order created successfully'
        ]);
    }

    /**
     * Get Purchase Items
     * @param string $reference
     * @return JsonResponse
     */
    public function getItems($reference)
    {
        $PurchaseOrder = PurchaseOrder::where('reference', $reference)
                                    ->first();
        if (!$PurchaseOrder) {
            return response()->json([
                'status'  => 0,
                'message' => 'Purchase Order not found. Try again'
            ], 404);
        }

        return response()->json([
            'status' => 1,
            'row'    => $PurchaseOrder,
            'items'  => PurchaseOrderItem::select('id', 'product_id', 'order_qty as quantity', 'price', 'requested_qty')
                                      ->where('order_id', $PurchaseOrder->id)
                                      ->with('product')
                                      ->get()
        ]);
    }

   /**
    * Delete Purchase Order
    * @param int $id
     * @return JsonResponse
    */
    public function destroy($id) 
    {
        $row = PurchaseOrder::find($id);
        if (empty($row)) {
            return response()->json([
                'status'  => 0,
                'error' => 'No records found'
            ], 404);
        }

        $items = PurchaseOrderItem::where('order_id', $row->id)->get();
        foreach($items as $item) {
            $item->delete();
        }

        $row->delete();

        return response()->json([
            'status'  => 1,
            'message'   => 'Record have deleted successfully'
        ]);
    }

    /**
     * Update Purchase Order status
     * @param int $id
     * @return JsonResponse
     */
    public function updateStatus($id)
    {
        $PurchaseOrder = PurchaseOrder::findOrFail($id);

        if(!empty($PurchaseOrder)) {
            $PurchaseOrder->status = "CANCELLED";
            $PurchaseOrder->save();
        }
        return response()->json([
            'status'  => 1,
            'message' => 'Status Changed Successfully'
        ]);
    }

    /**
     * Delete Single item
     * @param int itemId
     * @return JsonResponse
     */
    public function deleteItem($itemId)
    {
        $row = PurchaseOrderItem::findOrFail($itemId);
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Item not found'
            ], 404);
        }
        $PurchaseOrder = PurchaseOrder::find($row->order_id);
        $PurchaseOrder->amount -= ($row->price * $row->order_qty);
        $PurchaseOrder->save();

        $row->delete();

        return response()->json([
            'status' => 1,
            'message'  => 'Deleted successfully'
        ]);
    }
}
