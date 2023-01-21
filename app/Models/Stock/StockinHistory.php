<?php

namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockinHistory extends Model
{
    use HasFactory;

    protected $table = ['stockin_histories'];
    protected $fillable = [
        'stockin_id',
        'product_id',	
        'quantity',	
        'price',
        'expiration_date',	
        'barcode'
    ];

    public $timestamps = false;

    protected $casts = [
        'expiration_date' => 'date'
    ];
    
    /**
     * @return BelongsTo
     */
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', 'id')
                    ->select('products.id', 'products.name')
                    ->with('category', 'unit');
    }
}
