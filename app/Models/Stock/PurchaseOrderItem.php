<?php

namespace App\Models\Stock;

use App\Models\Stock\Stock;
use App\Models\Stock\Product;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PurchaseOrderItem extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'purchase_order_items';
    protected $fillable = [
        'order_id',
        'product_id',	
        'order_qty',
        'requested_qty',	
        'price'
    ];

    //protected $appends = ['stock_quantity'];

    /**
     * @return BelongsTo
     */
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id')
                    ->select('products.id', 'products.name', 'units.name as unit', 'product_categories.name as category', 'products.quantity')
                    ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                    ->leftJoin('product_categories', 'products.category_id', '=', 'product_categories.id');
    }

    /**
    *  Get Quantity for MENU & PRODUCTION ITEMS
    */
    public function getStockQuantityAttribute(){
        return Stock::where('product_id', $this->product_id)
                      ->whereNull('branch_id')
                      ->sum('quantity');
    }
}
