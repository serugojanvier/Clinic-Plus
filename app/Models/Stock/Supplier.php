<?php

namespace App\Models\Stock;

use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Supplier extends Model
{
    use HasFactory, CrudTrait;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'company_id',
        'name',
        'phone',
        'email',
        'tin_number',
        'address',
        'created_by',
    ];
}
