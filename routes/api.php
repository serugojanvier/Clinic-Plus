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
    Route::get('', 'UnitsController@index');
    Route::get('show/{id}', 'UnitsController@show');
    Route::post('store', 'UnitsController@store');
    Route::get('destroy/{id}', 'UnitsController@destroy');
  });
  
  Route::group(['prefix' =>'categories'], function(){
    Route::get('', 'ProductCategoryController@index');
    Route::get('show/{id}', 'ProductCategoryController@show');
    Route::post('store', 'ProductCategoryController@store');
    Route::get('destroy/{id}', 'ProductCategoryController@destroy');
  });

  Route::group(['prefix' =>'companies'], function(){
    Route::get('', 'CompanyController@index');
    Route::get('show/{id}', 'CompanyController@show');
    Route::post('store', 'CompanyController@store');
    Route::get('destroy/{id}', 'CompanyController@destroy');
  });

  Route::group(['prefix' => 'insurances'], function(){
    Route::get('', 'InsurancesController@index');
    Route::get('show/{id}', 'InsurancesController@show');
    Route::post('store', 'InsurancesController@store');
    Route::get('destroy/{id}', 'InsurancesController@destroy');
  });

  Route::group(['prefix' => 'suppliers'], function(){
    Route::get('', 'SuppliersController@index');
    Route::get('show/{id}', 'SuppliersController@show');
    Route::post('store', 'SuppliersController@store');
    Route::get('destroy/{id}', 'SuppliersController@destroy');
  });

  Route::group(['prefix' => 'products'], function(){
    Route::get('', 'ProductsController@index');
    Route::get('show/{id}', 'ProductsController@show');
    Route::post('store', 'ProductsController@store');
    Route::get('destroy/{id}', 'ProductsController@destroy');
  });

  Route::group(['prefix' => 'Stock'], function(){
    Route::get('', 'StockController@index');
    Route::get('show/{id}', 'StockController@show');
    Route::post('store', 'StockController@store');
    Route::get('destroy/{id}', 'StockController@destroy');
  });

  Route::group(['prefix' => 'StockInHistory'], function(){
    Route::get('', 'StockInHistoryController@index');
    Route::get('show/{id}', 'StockInHistoryController@show');
    Route::post('store', 'StockInHistoryController@store');
    Route::get('destroy/{id}', 'StockInHistoryController@destroy');
  });
  
  Route::group(['prefix' => 'StockReceives'], function(){
    Route::get('', 'StockReceivesController@index');
    Route::get('show/{id}', 'StockReceivesController@show');
    Route::post('store', 'StockReceivesController@store');
    Route::get('destroy/{id}', 'StockReceivesController@destroy');
  });

  Route::group(['prefix' => 'StockOut'], function(){
    Route::get('', 'StockOutController@index');
    Route::get('show/{id}', 'StockOutController@show');
    Route::post('store', 'StockOutController@store');
    Route::get('destroy/{id}', 'StockOutController@destroy');
  });

  Route::group(['prefix' => 'StockOutItems'], function(){
    Route::get('', 'StockOutItemsController@index');
    Route::get('show/{id}', 'StockOutItemsController@show');
    Route::post('store', 'StockOutItemsController@store');
    Route::get('destroy/{id}', 'StockOutItemsController@destroy');
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