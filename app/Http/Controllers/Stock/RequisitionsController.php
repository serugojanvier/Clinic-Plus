<?php
namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\Requisition;
use App\Http\Controllers\Controller;
use App\Models\Stock\RequisitionItem;

class RequisitionsController extends Controller
{

    /**
     * Return requisitions
     * @param Request $request
     * @return JsonResponse
     */
    public function index(Request $request)
    {
        $from = $request->input('from');
        $to = $request->input('to');
        if (empty($from)) {
            $from = date('Y-m-d');
        }
        
        $result = Requisition::select('*')->with('department', 'creator');
        if (!empty($status = \request()->query('status'))) {
            $result->where('status', $statu);
        }

        if (!empty($department = $request->input('department'))) {
            $result->where('department_id', $department);
        }
        if (empty($to)) {
            $result->where('date_initiated', $from);
        } else {
            $result->where('date_initiated', '>=', $from)
                   ->where('date_initiated', '<=', $to);
        }

        return response()->json([
            'status' => 1,
            'rows'   =>  $result->orderBy('status', 'ASC')
                            ->orderBy('id', 'DESC')
                            ->paginate(45)
        ]);
    }

    /**
     * Store Requisition Item
     * @param Request $request
     * @return JsonResponse
     */
    public function store(Request $request)
    {
        $items = json_decode($request->input('items'));
        $id = Requisition::create([
            'reference'      =>  generateReference(20),	
            'date_initiated' =>  $request->input('date_initiated'),
            'department_id' => $request->input('department_id'),
            'amount'        => $request->input('amount'),
            'status'        => 'PENDING'
        ])->id;

        foreach($items as $item){
            RequisitionItem::create([
                'requisition_id' => $id,
                'product_id'    => $item->id,
                'requested_qty' => $item->quantity,
                'price' => $item->price,
                'received_qty'  => 0
            ]);
        }
        return response()->json([
            'status' => 1,
            'message' => 'Requisition created successfully'
        ]);
    }

    /**
     * Get Requisition Items
     * @param string $reference
     * @return JsonResponse
     */
    public function getItems($reference)
    {
        $requisition = Requisition::where('reference', $reference)
                                    ->with('department')
                                    ->first();
        if (!$requisition) {
            return response()->json([
                'status'  => 0,
                'message' => 'Requisition not found. Try again'
            ], 404);
        }

        return response()->json([
            'status' => 1,
            'row'    => $requisition,
            'items'  => RequisitionItem::select('id', 'product_id', 'requested_qty as quantity', 'price', 'received_qty')
                                      ->where('requisition_id', $requisition->id)
                                      ->with('product')
                                      ->get()
        ]);
    }

   /**
    * Delete Requisition
    * @param int $id
     * @return JsonResponse
    */
    public function destroy($id) 
    {
        $row = Requisition::find($id);
        if (empty($row)) {
            return response()->json([
                'status'  => 0,
                'error' => 'No records found'
            ], 404);
        }

        $items = RequisitionItem::where('requisition_id', $row->id)->get();
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
     * Update requisition status
     * @param int $id
     * @return JsonResponse
     */
    public function updateStatus($id)
    {
        $requisition = Requisition::findOrFail($id);

        if(!empty($requisition)) {
            $requisition->status = "CANCELLED";
            $requisition->save();
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
        $row = RequisitionItem::findOrFail($itemId);
        if (!$row) {
            return response()->json([
                'status' => 0,
                'error'  => 'Item not found'
            ], 404);
        }
        $requisition = Requisition::find($row->requisition_id);
        $requisition->amount -= ($row->price * $row->requested_qty);
        $requisition->save();

        $row->delete();

        return response()->json([
            'status' => 1,
            'message'  => 'Deleted successfully'
        ]);
    }
}