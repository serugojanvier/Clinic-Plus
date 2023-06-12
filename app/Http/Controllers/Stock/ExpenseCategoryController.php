<?php

namespace App\Http\Controllers\stock;

use App\Models\Stock\ExpenseCategory;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ExpenseCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        // Show all data in Model

        return response()->json([
            'status'    => 1,
            'rows'       => ExpenseCategory::orderByDesc('id')->get()
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
        // create new and update exist one if found

        if($request->has('id')){
            $ExpenseCategory = ExpenseCategory::find($request->input('id'));
        }else{
            $ExpenseCategory = new ExpenseCategory();
        }

        $ExpenseCategory->fill($request->input());
        $ExpenseCategory->save();

        return response()->json([
            'status'    => 0,
            'row'       => ExpenseCategory::find($ExpenseCategory->id)
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
        $ExpenseCategory = ExpenseCategory::findOrFail($id);
        if(!$ExpenseCategory){
            return response()->json([
                'status'    =>0,
                'error'     =>'Expense Category can\'t be found!'
            ]);
        }

        return response()->json([
            'status'    =>1,
            'error'     => $ExpenseCategory
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
        $ExpenseCategory = ExpenseCategory::findOrFail($id);
        if(!$ExpenseCategory){
            return response()->json([
                'status'    =>0,
                'error'     =>'Expense Category can\'t be found!'
            ]);
        }
        $ExpenseCategory->delete();
        return response()->json([
            'status'    =>1,
            'error'     => 'Expense Category Deleted Successly!'
        ]);
    }
}
