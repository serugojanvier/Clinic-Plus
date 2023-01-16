<?php

namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

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
