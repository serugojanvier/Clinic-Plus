<?php

namespace App\Http\Controllers;

use App\Models\Role;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class RolesController extends Controller
{
    /**
     * Display a all roles or a specified one.
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function index($id = NULL)
     {
         if (!is_null($id)) {
             return response()->json([
                 'status' => 1,
                 'row'    => Role::findOrFail($id)
             ]);
         }
         $result = Role::select('id', 'name', 'description', 'status');
         $company = \request()->query('current_company') ?? auth()->user()->company_id;
        if (!empty($company)) {
            $result->company();
        } else {
            $result->whereNull('company_id');
        }
         return response()->json([
             'status' => 1,
             'rows'   => $result->orderBy('id', 'DESC')->get()
         ]);
     }
 
     /**
     * Create or update \Role model resource.
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
     public function store(Request $request)
     {
         $row = Role::find($request->input('id'));
         $permissions = json_decode($request->input('permissions'));
         if (!$row) {
             $row = new Role();
             $row->status = 1;
         }
         $row->permissions = $permissions;
         $row->name        = $request->input('name');
         $row->description = $request->input('description');
         $row->status = 1;
         $row->save();
         return response()->json([
             'status'  => 1,
             'row' => Role::select('id', 'name', 'description', 'status')->where('id', $row->id)->first()
         ]);
     }
 
     /**
      * Handle destroy
      * @param int $id
      * @return JsonResponse
      */
     public function destroy($id)
     {
         Role::where('id', $id)->delete();
         return response()->json([
             'status'  => 1,
             'message' => 'Deleted successfully'
         ]);
     }
}
