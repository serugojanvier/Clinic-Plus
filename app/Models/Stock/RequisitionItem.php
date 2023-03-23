<?php
namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class RequisitionItem extends Model
{
    protected $table = 'requisition_items';
    protected $fillable = [
        'requisition_id',
        'product_id',	
        'requested_qty',	
        'received_qty',
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
