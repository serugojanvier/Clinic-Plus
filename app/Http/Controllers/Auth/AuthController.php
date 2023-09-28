<?php

namespace App\Http\Controllers\Auth;

use JWTAuth;
use Carbon\Carbon;
use App\Models\User;
use Illuminate\Http\Request;
use App\Events\SuccessLoginEvent;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

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
    public function login(Request $request)
    {
        $input = $request->input('username');
        if (filter_var($input, FILTER_VALIDATE_EMAIL)) {
            $field = 'email';
        } else {
            $field = 'phone';
        }

        $request->merge([$field => $input]);
        $credentials = request([$field, 'password']);
        //$token = JWTAuth::attempt($credentials, ['exp' => Carbon\Carbon::now()->addDays(7)->timestamp]);

        if (! $token = auth('api')->attempt($credentials)) {
            return response()->json(['status'=>0,'message' => __('Password is not correct'),'status'=>0], 401);
        }

        $expiredProducts = DB::table('stockin_histories')->where('expiration_date', '<', date('Y-m-d'))->whereNotIn('status', ['EXPIRED','CONSUMED'])->get();
        foreach ($expiredProducts as $row) {
            $product = DB::table('products')->where('id', $row->product_id)->first();
            $expiredQty = $row->quantity - $row->consumed_qty;
            if ($expiredQty > $product->quantity) {
                $productQuantity = 0;
            } else {
                $productQuantity = $product->quantity - $expiredQty;
            }
            DB::table('products')->where('id', $row->product_id)->update(['quantity' => $productQuantity]);
            DB::table('stockin_histories')->where('id', $row->id)->update(['status' => 'EXPIRED']);
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
        $user = User::where('email', \request()->input('email'))
                    ->orWhere('phone', \request()->input('phone'))
                    ->first();
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
        if (!(Hash::check($request->get('currentPassword'), Auth::user()->password))) {
            return response()->json([
                'status' => 0,
                'error' => "Your current password does not matches with the password you provided. Please try again."
            ]);
        }
        if (strcmp($request->get('currentPassword'), $request->get('newPassword')) == 0) {
            return response()->json([
                'status' => 0,
                'error'  => "New Password cannot be same as your current password. Please choose a different password."
            ]);
        }
        // $request->validate([
        //     'currentPassword' => 'required',
        //     'newPassword' => 'required|confirmed',
        // ]);
        $user = Auth::user();
        $user->password = bcrypt($request->get('newPassword'));
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

    public function readSingleNotifications($notificationId){
        $notification = Auth::user()->notifications()->find($notificationId);
        if($notification){
            $notification->markAsRead();
        }

        return response()->json([
            'success'=> true
        ]);
    }

    public function getNotificationsForToday(){
        $today = Carbon::now()->toDateString();
        $notifications = DB::table('notifications')
                            ->whereRaw('DATE(read_at) = ?', [$today])
                            ->select('data')
                            ->get();
        return response()->json([
            'notifications' =>$notifications,
        ],200);
    }
}
