<?php

namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockoutItem extends Model
{
    use HasFactory;

    protected $fillable = [
        'stockout_id',
        'product_id',
        'quantity',
        'price'
    ];

    public $timestamps = false;
}
