<?php

namespace App\Traits;
use App\Models\Stock\Company;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

 Trait CrudTrait {

    /**
     * Handle global fiels like company_id or created_by
     */
    public static function boot()
    {
        parent::boot();
        static::saving(function ($table) {
            $table->created_by = auth()->id();
            $table->company_id = auth()->user()->company_id;
        });
    }

    /**
     * @return belongsTo
     */
    public function company()
    {
        return $this->belongsTo(Company::class, 'company_id')
                     ->select('companies.id', 'companies.name');
    }

    /**
     * @return belongsTo
     */

     public function creator()
     {
        return $this->belongsTo(User::class, 'created_by')
                    ->select('users.id', 'users.name');
     }
 }