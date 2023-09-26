<?php

namespace App\Models\Stock;

use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class StockinHistory extends Model
{
    use HasFactory, SoftDeletes;
    
    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $table = 'stockin_histories';
    
    protected $fillable = [
        'company_id',
        'stockin_id',
        'product_id',	
        'quantity',	
        'price',
        'expiration_date',	
        'barcode',
        'consumed_qty',
        'status'
    ];

   // public $timestamps = false;

    protected $casts = [
        'expiration_date' => 'date'
    ];
    
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
