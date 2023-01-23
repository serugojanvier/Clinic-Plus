<?php

namespace App\Models\Stock;

use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Stock extends Model
{
    use HasFactory;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }
    
    public static function boot()
    {
        parent::boot();
        static::saving(function ($table) {
            $table->company_id = auth()->user()->company_id;
        });
    }
    protected $table = "stock";
    public $timestamps = false;
    protected $fillable = [
        'company_id',	
        'product_id',	
        'quantity'
    ];
}
