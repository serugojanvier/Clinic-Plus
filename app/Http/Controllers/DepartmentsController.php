<?php

namespace App\Http\Controllers;

use App\Models\Department;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class DepartmentsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index()
     {
        return response()->json([
            'status'=> 1,
            'rows'  => Department::orderByDesc('id')->with('creator', 'leader')->get()
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
        if($request->has('id')){
           $department = Department::find($request->input('id'));
        } else{
           $department = new Department;
           $department->status = 1;
        }

       $department->fill($request->input());
       $department->save();

        return response()->json([
            'status' => 1,
            'row'   => Department::where('id', $department->id)
                                    ->with('creator', 'leader')
                                    ->first()
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
       $department = Department::findOrFail($id);
        if(!$department){
            return response()->json([
                'status'=>0,
                'error' =>'Department can\'t Found!'
            ]);
        }

        return response()->json([
            'status' => 1,
            'row'    => $department
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
        $DeletedDepartment = Department::findOrFail($id);
        if(!$DeletedDepartment){
            return response()->json([
                'status'=>0,
                'error' =>'Department can\'t Found!'
            ]);
        }

        $DeletedDepartment ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Department deleted Successfuly!'
        ]);
     }  

      /**
     * search fora category
     * @param Request $request
     * @return JsonResponse
     */
    public function search(Request $request)
    {
        $result = Department::select('id', 'name');
        $keyword = $request->get('query');
        if (empty($keyword)) {
            return  response()->json($result->orderBy('name', 'ASC')->take(250)->get());
        } else {
            return response()->json($result->where('name', 'LIKE', '%' . $keyword . '%')->orderBy('name', 'ASC')->get());
        }
    }
}
