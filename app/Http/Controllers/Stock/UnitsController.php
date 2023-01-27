<?php

namespace App\Http\Controllers\Stock;

use App\Models\Stock\Unit;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class UnitsController extends Controller
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
            'rows'   => Unit::orderByDesc('id')->get()
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
        //if request has Id, then peform update
        if ($request->has('id')) {
            $unit = Unit::find($request->input('id'));
        } else {
            $unit = new Unit();
        }
        $unit->name=$request->input('name');
        $unit->description=$request->input('description');
        $unit->save();

        return response()->json([
            'status' => 1,
            'row'    => Unit::find($unit->id)
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
        $unit = Unit::findOrFail($id);
        if (!$unit) {
            return response()->json([
                'status' => 0,
                'error'  => 'Unit not found'
            ]);
        }

        return response()->json([
            'status' => 1,
            'row'    => $unit
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
        $unit = Unit::findOrFail($id);
        if (!$unit) {
            return response()->json([
                'status' => 0,
                'error'  => 'Unit not found'
            ]);
        }

        $unit->delete();

        return response()->json([
            'status' => 1,
            'message' => "Deleted sucessfully"
        ]);
    }
}
