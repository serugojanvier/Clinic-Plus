<?php

namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockReceive extends Model
{
    use HasFactory;

    protected $fillable = [
        'company_id',
        'date_receives',
        'supplier_id',
        'amount',
        'vat',
        'file_url'
    ];
}
