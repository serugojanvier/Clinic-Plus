<?php

namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',	
        'phone',	
        'email',	
        'tin_number',
        'address_line',	
        'created_by',	
        'reference'
    ];
}
