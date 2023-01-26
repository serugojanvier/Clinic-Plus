<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Stock;
use Illuminate\Http\Request;
use App\Models\Stock\Product;
use App\Models\Stock\Adjustment;
use App\Models\Stock\AdjustedItem;
use App\Http\Controllers\Controller;

class AdjustmentsController extends Controller
{
    /**
     * Get Ajustments based on filters
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
        $result = Adjustment::select('*');
        if (!empty($from)) {
            $result->where('adjustment_date', '>=', $from)
                    ->where('adjustment_date', '<=', $to);
        }
        if (!empty($department = $request->get('department'))) {
            $result->where('department_id', $department);
        }
        return response()->json([
            'status' => 1,
            'rows'   => $result->with('creator', 'department')
                            ->orderBy('id', 'DESC')
                            ->paginate(45)
        ]);
    }

    /**
     * Store adjusted items
     * @param Request $request
     * @return JsonResponse
     */
    public function store(Request $request)
    {
        $department = $request->input('department_id');
        $adjustmentId = Adjustment::create([
            'reference' => generateReference(20),
            'adjustment_date' => $request->input('adjustment_date'),
            'department_id'   => $department,
            'reason'          => $request->input('reason'), 
            'description' => $request->input('description')
        ])->id;

        $items = json_decode($request->input('items'));
        if (empty($department)) {
            foreach($items as $item)
            {
                $product = Product::findOrFail($item->id);
                $product->quantity += $item->adjusted;
                $product->save();
                AdjustedItem::create([
                    'product_id'     => $item->id,	
                    'quantity'       => $item->adjusted,	
                    'adjustment_id'  => $adjustmentId,
                    'details'        => $item
                ]);
            }
        } else {
            foreach($items as $item)
            {
                $stock = Stock::where('product_id', $item->id)
                                ->where('department_id', $department)
                                ->first();
                if (!$stock) {
                    $stock = new Stock();
                    $stock->product_id = $item->id;
                    $stock->department_id = $department;
                }
                $stock->quantity += $item->adjusted;
                $stock->save();
                AdjustedItem::create([
                    'product_id'     => $item->id,	
                    'quantity'       => $item->adjusted,			
                    'adjustment_id'  => $adjustmentId,
                    'details'        => $item
                ]);
            }
        }
        
        return response()->json([
            'status' => 1,
            'message' => 'Adjustment added successfully'
        ]);
    }

  
    public function getItems($reference)
    {
        $record = Adjustment::where('reference', $reference)->with('department')->first();
        if (!$record) {
            return response()->json([
                'status' => 0,
                'error'  => 'No record found'
            ], 404);
        }
        return response()->json([
            'status' => 1,
            'row'    => $record,
            'items'  => AdjustedItem::where('adjustment_id', $record->id)->get()
        ]);
    }

    public function destroy($id)
    {
        $record = Adjustment::findOrFail($id);
        if(!$record){
            return response()->json([
                'status' => 0,
                'error'  => 'No record found'
            ], 404);
        }

        $items = AdjustedItem::where('adjustment_id', $record->id)->get();
        
        foreach($items as $item)
        {
            if (empty($department = $record->department_id)) {
                $product = Product::findOrFail($item->product_id);
            } else {
                $product = Stock::where('product_id', $item->product_id)
                                ->where('department_id', $department)
                                ->first();
            }
            $product->quantity -= $item->quantity;
            $product->save();
            $item->delete();
        }
        $record->delete();
        return response()->json([
            'status'  => 1,
            'message' => 'Record deleted successfully'
        ]);
    }
}