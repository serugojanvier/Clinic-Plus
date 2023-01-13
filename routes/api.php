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
    Route::post('logout', 'AuthController@logout');
    Route::post('refresh', 'AuthController@refresh');
    Route::get('me', 'AuthController@me');
    Route::post('me', 'AuthController@updateUser');
    Route::post('change-password', 'AuthController@changePassword');
});

Route::group(['namespace' => 'App\Http\Controllers\Stock' ,'middleware' => 'auth:api', 'prefix' => 'stock'], function(){
  Route::group(['prefix' => 'units'], function(){
    Route::get('', 'UnitsController@index');
    Route::get('show/{id}', 'UnitsController@show');
    Route::post('store', 'UnitsController@store');
    Route::get('destroy/{id}', 'UnitsController@destroy');
  });
  
  Route::group(['prefix' =>'Pcategory'], function(){
    Route::get('', 'ProductCategoryController@index');
    Route::get('show/{id}', 'ProductCategoryController@show');
    Route::post('store', 'ProductCategoryController@store');
    Route::get('destroy/{id}', 'ProductCategoryController@destroy');
  });

  Route::group(['prefix' =>'Company'], function(){
    Route::get('', 'CompanyController@index');
    Route::get('show/{id}', 'CompanyController@show');
    Route::post('store', 'CompanyController@store');
    Route::get('destroy/{id}', 'CompanyController@destroy');
  });

  Route::group(['prefix' => 'Insurance'], function(){
    Route::get('', 'InsurancesController@index');
    Route::get('show/{id}', 'InsurancesController@show');
    Route::post('store', 'InsurancesController@store');
    Route::get('destroy/{id}', 'InsurancesController@destroy');
  });

  Route::group(['prefix' => 'Supplier'], function(){
    Route::get('', 'SuppliersController@index');
    Route::get('show/{id}', 'SuppliersController@show');
    Route::post('store', 'SuppliersController@store');
    Route::get('destroy/{id}', 'SuppliersController@destroy');
  });
});

Route::group(['namespace' => 'App\Http\Controllers' ,'middleware' => 'auth:api', 'prefix' => 'Shared'], function(){
  Route::group(['prefix' =>'Role'], function(){
    Route::get('', 'RolesController@index');
    Route::get('show/{id}', 'RolesController@show');
    Route::post('store', 'RolesController@store');
    Route::get('destroy/{id}', 'RolesController@destroy');
  });
});