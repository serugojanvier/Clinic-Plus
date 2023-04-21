<?php
namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SaleItem extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'sale_id',
        'item_id',
        'quantity',
        'price',
        'amount',
        'comment'
    ];

    /**
     * Here Item is for POs
     * Product for Production Sales - coz it comes with stock quantity and price
     */
    protected $appends = ['item', 'product'];

    protected $hidden = ['item', 'product'];
   

    public function sale()
    {
        return $this->belongsTo(Sale::class, "sale_id", "id");
    }

    /**
     * Get Sold Item Details
     * @return \Illuminate\Support\Collection
     */
    public function getItemAttribute()
    {
        return Product::select('products.name', 'units.name As unit')
                        ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                        ->where('products.id', $this->item_id)
                        ->first();
    }

    /**
     * Get Production item details
     * @return \Illuminate\Support\Collection
     */
    public function getProductAttribute()
    {
        return Product::select('products.id','units.name As unit', 'products.name', 'products.quantity')
                        ->leftJoin('units', 'products.unit_id', '=', 'units.id')
                        ->where('products.id', $this->item_id)
                        ->first();
    }
}