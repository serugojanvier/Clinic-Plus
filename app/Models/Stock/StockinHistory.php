<?php

namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockinHistory extends Model
{
    use HasFactory;

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
}
