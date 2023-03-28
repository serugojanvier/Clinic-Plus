<?php

namespace App\Providers;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        $lastExpiredCheck = env('LAST_EXPIRATION_CHECK') ?? null;
        if (!$lastExpiredCheck || date('Y-m-d', strtotime($lastExpiredCheck)) < date('Y-m-d')) {
            // Log::info( $lastExpiredCheck);
              // check expired products
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
           $results = setEnvironment([(object)['key' => 'LAST_EXPIRATION_CHECK', 'value' => date('Y-m-d')]]);
        }
    }
}
