<?php

namespace App\Http\Controllers\stock;

use App\Models\Stock\Client;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class ClientsController extends Controller
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
            'rows' => Client::orderByDesc('id')->paginate(\request()->query('per_page') ?? 45)
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
       if($request->has('id')){
            $client = Client::find($request->input('id'));
            $message = "Client Info Updated Successfully";
       }else{
            $client = new Client();
            $message = "New Client Successfully";
       }

        $client->name = $request->input('name');
        $client->phone = $request->input('phone');
        $client->email = $request->input('email');
        $client->discount = $request->input('discount') || 0;
        $client->address = $request->input('address');

        $client->save();
        return response()->json([
            'status' =>1,
            'row' => Client::find($client->id),
            'message' => $message
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
       $client = Client::findOrFail($id);
       if(!$client){
            return response()->json([
                'status' => 0,
                'error' => "Client not Found!"
            ]);
       }

       return response()->json([
            'status' => 1,
            'row' => $client
       ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $client = Client::findOrFail($id);
        if(!$client){
            return response()->json([
                'status' => 0,
                'error' => "Client not Found!"
            ]);
       }

       $client->delete();

        return response()->json([
            'status' => 1,
            'row' => "Customer Deleted Successfully!"
        ]);
    }


        /**
     * search fora category
     * @param Request $request
     * @return JsonResponse
     */
    public function search(Request $request)
    {
        $result = Client::select('id', 'name');
        $keyword = $request->get('query');
        if (empty($keyword)) {
            return  response()->json($result->orderBy('name', 'ASC')->take(250)->get());
        } else {
            return response()->json($result->where('name', 'LIKE', '%' . $keyword . '%')->orderBy('name', 'ASC')->get());
        }
    }
}
