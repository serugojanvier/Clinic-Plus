<?php
 namespace App\Traits;
 use Illuminate\Support\Facades\Auth;

 Trait CrudTrait {

    /**
     * Handle global fiels like company_id or created_by
     */
    public static function boot()
    {
        parent::boot();
        static::saving(function ($table) {
            if ($table->created_by) {
                $table->created_by = auth()->id();
            }

            if ($table->company_id) {
                $company = \request()->get('company_id') ?? auth()->user()->company_id;
                if ($company) {
                    $table->company_id = $company;
                }
            }
        });
    }
 }