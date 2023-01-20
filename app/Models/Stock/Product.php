<?php

namespace App\Models\Stock;

use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Product extends Model
{
    use HasFactory;
    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'company_id',
        'code',
        'reference',	
        'name',	
        'unit_id',	
        'cost_price',	
        'rhia_price',	
        'private_price',	
        'inter_price',	
        'category_id',
        'created_by'
    ];
}
