<?php

namespace App\Models\Stock;

use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class StockOut extends Model
{
    use HasFactory, CrudTrait;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'company_id',
        'date_taken',
        'category',
        'patient_id',
        'insurance_id',
        'created_by'
    ];
}
