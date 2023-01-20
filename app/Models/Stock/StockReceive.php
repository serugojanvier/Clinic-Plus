<?php

namespace App\Models\Stock;

use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class StockReceive extends Model
{
    use HasFactory, CrudTrait;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'company_id',
        'date_receives',
        'supplier_id',
        'amount',
        'vat',
        'file_url',
        'created_by'
    ];
}
