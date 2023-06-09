<?php

namespace App\Http\Controllers\stock;

use App\Models\Stock\Expense;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ExpenseController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response()->json([
            'status' => 1,
            'rows'   => Expense::orderByDesc('id')->with('category','PaymentMethod','creator')->paginate(\request()->query('per_page') ?? 45)
        ]);
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Check if id exist then update or create

        if($request->has('id')){
            $expense  = Expense::find($request->input('id'));
        }else{
            $expense = new Expense();
        }

        $expense->fill($request->input());
        $expense->save();
        $id = $expense->id;
        
        return response()->json([
            'status'    =>1,
            'row'       => Expense::where('id',$id)->with('category')->first()
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
        // show one expense

        $expense = Expense::findOrFail($id);
        if(!$expense){
            return response()->json([
                'status'    =>0,
                'error'     =>'Expense can\'t be found!'
            ]);
        }

        return response()->json([
            'status'    =>1,
            'row'       => $expense
        ]);
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        // Destroy one expense

        $expense = Expense::findOrFail($id);
        if(!$expense){
            return response()->json([
                'status'    =>0,
                'error'     =>'Expense can\'t be found!'
            ]);  
        }
        $expense->delete();
        return response()->json([
            'status'    =>1,
            'message'     =>'Expense Deleted Successfuly!'
        ]);
    }
}
