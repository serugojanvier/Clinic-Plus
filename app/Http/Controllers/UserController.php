<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Validator;
class UserController extends Controller
{
     /**
     * Display a listing of the resource.
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function index(Request $request)
     {
        $users = User::select('*')->whereNotNull('role_id');
        if (!empty($company = auth()->user()->company_id)) {
            $users->company();
        }
        return response()->json([
            'status' => 1,
            'rows'   => $users->OrderByDesc('id')
                             ->with('creator','company', 'role')
                             ->paginate(45)
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
        if ($request->has('id')) {
            $user = User::find($request->input('id'));
            $message = "User Updated Successfuly!";
        } else {
            $rules = [
                'email' => ['required', 'email', 'unique:users'],
                'phone' => ['unique:users'],
            ];
            $messages = [
                'email.required' => 'Email field is required', 
                'email.email'    => 'Email field must be a valid email', 
                'email.unique'   => 'User with the same email address exists',
                'phone.unique'   => 'User with the same email address exists'
            ];

            $validator = Validator::make($request->all(), $rules, $messages);
            if ($validator->fails()) {
                return response()->json([
                    'status' => 0,
                    'error' => $validator->errors()
                ], 400);
            }

            $user = new User();
            $message = "User Saved Successfuly!";
            $user->status = 1;
            $user->role_id = 1;
        }

        $user->fill($request->input());
        $user->name = implode(" ", [$request->input('first_name'), $request->input('last_name')]);
        if($request->has('password')) {
            $user->password = Hash::make($request->input('password'));
        }
        $user->save();

        return response()->json([
            'status'=>  1,
            'message'=> $message,
            'row'    => User::where('id', $user->id)
                               ->with('creator','company', 'role')
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
        $user = User::findOrFail($id);
        if (!$user) {
            return response()->json([
                'status' => 0,
                'error' => 'User can\'t Found!'
            ]);
        }

        return response()->json([
            'status' => 1,
            'row'    => $user
        ]);
     }

     /**
     * Remove the specified resource from storage.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function destroy($id)
     {
        $user = User::findOrFail($id);
        if (!$user) {
            return response()->json([
                'status' => 0,
                'error'  => 'User can\'t Found!'
            ]);
        }

        $user->delete();

        return response()->json([
            'status'  => 1,
            'message' => 'User deleted Successfuly!'
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
        $users = explode(",", $ids);
        User::whereIn('id', $users)->delete();
        
        return response()->json([
            'status' => 1,
            'message' => 'Users deleted Successfuly!'
        ]);
     }

      /**
     * search fora category
     * @param Request $request
     * @return JsonResponse
     */
    public function search(Request $request)
    {
        $result = User::select('id', 'name');
        if (!empty($company = auth()->user()->company_id)) {
            $result->company();
        }
        $keyword = $request->get('query');
        if (empty($keyword)) {
            return  response()->json($result->orderBy('name', 'ASC')->take(250)->get());
        } else {
            return response()->json($result->where('name', 'LIKE', '%' . $keyword . '%')->orderBy('name', 'ASC')->get());
        }
    }
}
