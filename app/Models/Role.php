<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    public static function boot()
    {
        parent::boot();
        static::saving(function ($table) {
            $table->company_id = auth()->user()->company_id;
        });
    }

    protected $fillable = [
        'name',	
        'permissions',	
        'company_id',
        'status',
        'description'
    ];

    public $timestamps = false;

    protected $casts = [
        'permissions' => 'object'
    ];
}
