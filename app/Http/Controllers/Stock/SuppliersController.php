<?php

namespace App\Http\Controllers\Stock;

use Illuminate\Http\Request;
use App\Models\Stock\Supplier;
use App\Http\Controllers\Controller;

class SuppliersController extends Controller
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
            'rows'   => Supplier::orderByDesc('id')->with('company', 'creator')->paginate(45)
        ]);
     }

     /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */

     public function store(Request $request){
        // check if request has id in it then perform update

        if($request->has('id')){
            $Supplier = Supplier::find($request->input('id'));
            $message  = "Record Updated Successfuly!";
        } else{
            $Supplier = new Supplier();
            $message = "Record Saved Successfuly!";
        }

        $Supplier->fill($request->input());
        $Supplier->save();

        return response()->json([
            'status'=>1,
            'message'=>$message,
            'row'   => Supplier::where('id', $Supplier->id)
                                ->with('company', 'creator')->first()
        ]);
     }

     /**
     * Display the specified resource.
     *
     * @param  int $id
     * @return \Illuminate\Http\JsonResponse
     */

     public function show($id){
        $Supplier = Supplier::findOrFail($id);
        if(!$Supplier){
            return response()->json([
                'status'=>0,
                'error' =>'Supplier can\'t Found!'
            ]);
        }

        return response()->json([
            'status'=>1,
            'row'   => $Supplier
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
        $supplier = Supplier::findOrFail($id);
        if(!$supplier){
            return response()->json([
                'status'=>0,
                'error' =>'Supplier can\'t Found!'
            ]);
        }

        $supplier->delete();

        return response()->json([
            'status'=>1,
            'message'=>'Supplier deleted Successfuly!'
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
         $suppliers = explode(",", $ids);
         Supplier::whereIn('id', $suppliers)->delete();
         
         return response()->json([
             'status' => 1,
             'message' => 'Suppliers deleted Successfuly!'
         ]);
      }

    /**
     * search fora category
     * @param Request $request
     * @return JsonResponse
     */
    public function search(Request $request)
    {
        $result = Supplier::select('id', 'name');
        $keyword = $request->get('query');
        if (empty($keyword)) {
            return  response()->json($result->orderBy('name', 'ASC')->take(250)->get());
        } else {
            return response()->json($result->where('name', 'LIKE', '%' . $keyword . '%')->orderBy('name', 'ASC')->get());
        }
    }
}
