<?php

namespace App\Http\Controllers\Auth;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\Events\SuccessLoginEvent;
use JWTAuth;

class AuthController extends Controller
{
   /**
     * Create a new AuthController instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register', 'authenticate']]);
    }

    /**
     * Get a JWT via given credentials.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function login()
    {
        $credentials = request(['email', 'password']);
        //$token = JWTAuth::attempt($credentials, ['exp' => Carbon\Carbon::now()->addDays(7)->timestamp]);

        if (! $token = auth('api')->attempt($credentials)) {
            return response()->json(['status'=>0,'message' => __('Password is not correct'),'status'=>0], 401);
        }

        return $this->respondWithToken($token);
    }

    /**
     * Get the authenticated User.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function me()
    {
        //$user = auth()->user()->with('role');
        if(empty(Auth::id())) {
            $header = \request()->header('Authorization');
            $token = explode(" ", $header)[1];
            return response()->json(['user' => JWTAuth::setToken($token)->toUser()]);
        } else{
            return response()->json([
                'user' => User::where('id', Auth::id())->with('role', 'company', 'department')->first()
            ]);
        }
    }

    /**
     * Log the user out (Invalidate the token).
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function logout()
    {
        auth()->logout();
        return response()->json(['message' => 'Successfully logged out','status'=>1]);
    }

    /**
     * Refresh a token.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function refresh()
    {
        return $this->respondWithToken(auth()->refresh());
    }

    /**
     * Get the token array structure.
     *
     * @param  string $token
     *
     * @return \Illuminate\Http\JsonResponse
     */
    protected function respondWithToken($token)
    {
        $user = User::where('email', \request()->input('email'))->first();
        event(new SuccessLoginEvent($user));
        return response()->json([
            'status'=>1,
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * 60
        ]);
    }

    public function changePassword(Request $request)
    {
        if (!(Hash::check($request->get('current_password'), Auth::user()->password))) {
            return response()->json([
                'status' => 0,
                'error' => "Your current password does not matches with the password you provided. Please try again."
            ]);
        }
        if (strcmp($request->get('current_password'), $request->get('new_password')) == 0) {
            return response()->json([
                'status' => 0,
                'error'  => "New Password cannot be same as your current password. Please choose a different password."
            ]);
        }
        // $request->validate([
        //     'current_password' => 'required',
        //     'new_password'     => 'required|string|min:6',
        // ]);
        $user = Auth::user();
        $user->password = bcrypt($request->get('new_password'));
        $user->save();
        return response()->json([
            'status'  => 1,
            'message' => 'Password changed successfully !'
        ]);
    }

    public function readNotifications()
    {
        $user = User::where('id', Auth::id())->first();
        $user->unreadNotifications->markAsRead();
        return response()->json([
            'success' => true
        ]);
    }
}
