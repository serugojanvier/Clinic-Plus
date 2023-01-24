<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::group(['namespace' => 'App\Http\Controllers\Auth' ,'middleware' => 'api', 'prefix' => 'auth'], function(){
    Route::post('login', 'AuthController@login')->middleware(['throttle:60,1']);
    Route::get('logout', 'AuthController@logout');
    Route::get('refresh', 'AuthController@refresh');
    Route::get('me', 'AuthController@me');
    Route::post('me', 'AuthController@updateUser');
    Route::post('change-password', 'AuthController@changePassword');
});

//Stock API'S
Route::group(['namespace' => 'App\Http\Controllers\Stock' ,'middleware' => 'auth:api', 'prefix' => 'stock'], function(){
  Route::group(['prefix' => 'units'], function(){
    Route::get('receives', 'StockController@index');
    Route::get('show/{id}', 'StockController@show');
    Route::post('store', 'StockController@store');
    Route::get('destroy/{id}', 'StockController@destroy');
  });
  
  Route::group(['prefix' =>'categories'], function(){
    Route::get('', 'CategoriesController@index');
    Route::get('show/{id}', 'CategoriesController@show');
    Route::post('store', 'CategoriesController@store');
    Route::get('destroy/{id}', 'CategoriesController@destroy');
  });

  Route::group(['prefix' =>'companies'], function(){
    Route::get('', 'CompanyController@index');
    Route::get('show/{id}', 'CompanyController@show');
    Route::post('store', 'CompanyController@store');
    Route::get('destroy/{id}', 'CompanyController@destroy');
    Route::get('bulk-destroy/{ids}', 'CompanyController@bulkDelete');
  });

  Route::group(['prefix' => 'insurances'], function(){
    Route::get('', 'InsurancesController@index');
    Route::get('show/{id}', 'InsurancesController@show');
    Route::post('store', 'InsurancesController@store');
    Route::get('destroy/{id}', 'InsurancesController@destroy');
  });

  Route::group(['prefix' => 'suppliers'], function(){
    Route::get('', 'SuppliersController@index');
    Route::get('search', 'SuppliersController@search');
    Route::get('show/{id}', 'SuppliersController@show');
    Route::post('store', 'SuppliersController@store');
    Route::get('destroy/{id}', 'SuppliersController@destroy');
    Route::get('bulk-destroy/{ids}', 'SuppliersController@bulkDelete');
  });

  Route::group(['prefix' => 'products'], function(){
    Route::get('', 'ProductsController@index');
    Route::get('extras', 'ProductsController@extras');
    Route::get('search', 'ProductsController@search');
    Route::get('show/{id}', 'ProductsController@show');
    Route::post('store', 'ProductsController@store');
    Route::get('destroy/{id}', 'ProductsController@destroy');
    Route::get('bulk-destroy/{ids}', 'ProductsController@bulkDelete');
  });

  Route::group(['prefix' => 'inventory'], function(){
    Route::post('receives/store', 'StockController@receive');
    Route::get('receives/show/{reference}', 'StockController@showReceive');
    Route::get('receives/{id}/destroy', 'StockController@deleteReceive');
    Route::get('receives/{id}/items', 'StockController@getReceiveItems');
    Route::get('receives/{id}/items/{itemId}/destroy', 'StockController@deleteReceiveItem');
    Route::get('destroy/{id}', 'StockController@destroy');
  });

  Route::group(['prefix' => 'reports'], function(){
    Route::get('receives', 'ReportsController@getReceivesReport');
    Route::get('show/{id}', 'ReportsController@show');
    Route::post('store', 'ReportsController@store');
    Route::get('destroy/{id}', 'ReportsController@destroy');
    
  });
});

// Shared API'S
Route::group(['namespace' => 'App\Http\Controllers' ,'middleware' => 'auth:api', 'prefix' => 'Shared'], function(){
  Route::group(['prefix' =>'Role'], function(){
    Route::get('', 'RolesController@index');
    Route::get('show/{id}', 'RolesController@show');
    Route::post('store', 'RolesController@store');
    Route::get('destroy/{id}', 'RolesController@destroy');
  });
});

Route::group(['namespace' => 'App\Http\Controllers' ,'middleware' => 'auth:api', 'prefix' => 'users'], function() {
  Route::get('', 'UserController@index');
  Route::get('show/{id}', 'UserController@show');
  Route::post('store', 'UserController@store');
  Route::get('destroy/{id}', 'UserController@destroy');
  Route::get('bulk-destroy/{ids}', 'UserController@bulkDelete');
});
