<?php

namespace App\Http\Controllers;

use App\Models\Company;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class CompanyController extends Controller
{
     /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index()
     {
        return response()->json([
            'status' => 1,
            'rows'   => Company::OrderByDesc('id')->with('creator')->paginate(\request()->query('per_page') ?? 45)
        ]);
     }

     /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function store(Request $request)
     {
        // if request has id then perfom update
        if($request->has('id')){
            $company = Company::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $company = new Company();
            $message = "Record Saved Successfuly!";
            $company->reference = generateReference(20);
            $company->created_by = auth()->id();
        }

        $company->fill($request->input());
        $company->logo = $request->input('logo');
        $company->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'    => Company::where('id', $company->id)->with('creator')->first()
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
        $company = Company::findOrFail($id);
        if (!$company) {
            return response()->json([
                'status'=>0,
                'error' =>'Company can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$company
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
        $DeletedCompany = Company::findOrFail($id);
        if(!$DeletedCompany){
            return response()->json([
                'status'=>0,
                'error' =>'Company can\'t Found!'
            ]);
        }

        $DeletedCompany->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Company deleted Successfuly!'
        ]);
     }

     /**
      * 
      * Handle Bulk Delete
      * @param string $id
      * @return \Illuminate\Http\JsonResponse
      */
     public function bulkDelete($ids)
     {
        $companies = explode(",", $ids);
        Company::whereIn('id', $companies)->delete();
        
        return response()->json([
            'status' => 1,
            'message' => 'Companies deleted Successfuly!'
        ]);
     }
}
