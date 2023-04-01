<?php

namespace App\Http\Controllers;

use App\Models\Subscription;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class SubscriptionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // check if request has the update
        if($request->has('id')){
            $Subscription = Subscription::find($request->input('id'));
            $message = "Subscription Updated SuccessFully";
        }else{
            $Subscription = new Subscription();
            $message = "Your Subscription Saved Successfully ! Check out your Email.";
        }

        $validator = Validator::make($request->all(),[
            'phone' => 'required',
            'email' => 'required|email',
            'address' => 'requied',
            'organization'=>'required',
            'address' =>'required'
        ]);

        if($validator->fails()){
            return response()->json([
                'status'=>0,
                'message'=>'Invalid Inputs',
                'errors'=>$validator->errors()
            ]);
        }
        
        $Subscription->fill($request->input());
        $Subscription->save();
        return response()->json([
            'status'=>1,
            'message'=>$message
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Subscription  $subscription
     * @return \Illuminate\Http\Response
     */
    public function show(Subscription $subscription)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Subscription  $subscription
     * @return \Illuminate\Http\Response
     */
    public function edit(Subscription $subscription)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Subscription  $subscription
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Subscription $subscription)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Subscription  $subscription
     * @return \Illuminate\Http\Response
     */
    public function destroy(Subscription $subscription)
    {
        //
    }
}
