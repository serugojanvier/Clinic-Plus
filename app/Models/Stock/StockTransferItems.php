<?php

namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class StockTransferItems extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'stock_transfer_items';
    protected $fillable = [
        'transfer_id',
        'product_id',	
        'quantity',	
        'price'
    ];

   // public $timestamps = false;

    /**
     * @return BelongsTo
     */
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id')
                    ->select('products.id', 'products.name', 'units.name as unit', 'product_categories.name as category')
                    ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                    ->leftJoin('product_categories', 'products.category_id', '=', 'product_categories.id');
    }
}
