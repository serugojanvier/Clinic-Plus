<?php

use App\Models\Stock\Unit;
use App\Scopes\CompanyScope;
use App\Models\Stock\Product;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::get('/', function () {
   $products = Product::whereNull('unit_id')->get();
   foreach($products as $product) {
    $row = Unit::inRandomOrder()
                ->first();
                if($row){

               
    $product->unit_id = $row->id;
    $product->save();
}
   }
});
