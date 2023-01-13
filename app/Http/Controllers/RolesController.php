<?php

namespace App\Http\Controllers;

use App\Models\Role;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class RolesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(){
        return response()->json([
            'status'=>1,
            'rows'  => Role::orderByDesc('id')->get()
        ]);
     }

      /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function store(Request $request){
        // check request contain id field then perform update

        if($request->has('id')){
            $Role = Role::find($request->input('id'));
            $message = "Record Updated Successfuly!";
        } else{
            $Role = new Role();
            $message = "Record Saved Successfuly!";
        }

        $Role->fill($request->input());
        $Role->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'=> Role::find($Role->id)
        ]);
     }

      /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Role = Role::findOrFail($id);
        if(!$Role){
            return response()->json([
                'status'=>0,
                'error' =>'Role can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   =>$Role
        ]);
     }

      /**
     * Remove the specified resource from storage.
     *
     * @param  int $is
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id){
        $DeletedRole = Role::findOrFail($id);
        if(!$DeletedRole){
            return response()->json([
                'status'=>0,
                'error' =>'Role can\'t Found!'
            ]);
        }

        $DeletedRole ->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Role deleted Successfuly!'
        ]);
     }  
}
