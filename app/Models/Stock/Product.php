<?php

namespace App\Models\Stock;

use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Product extends Model
{
    use HasFactory, CrudTrait, SoftDeletes;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'company_id',
        'quantity',
        'code',
        'reference',	
        'name',	
        'image',
        'packaging',
        'unit_id',	
        'cost_price',	
        'rhia_price',	
        'private_price',	
        'inter_price',	
        'category_id',
        'created_by'
    ];

    public function unit()
    {
        return $this->belongsTo(Unit::class, 'unit_id')->select('units.id', 'units.name');
    }

    public function category()
    {
        return $this->belongsTo(ProductCategory::class, 'category_id')->select('product_categories.id', 'product_categories.name');
    }
}
