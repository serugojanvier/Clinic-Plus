<?php

namespace App\Models;

use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

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

   /**
     * Scope a query to only include orders matching period of time.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeCompany($query)
    {
        $company = \request()->query('current_company') ?? auth()->user()->company_id;
        if(!empty($company)) {
            $query->where('company_id', $company);
        }
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
