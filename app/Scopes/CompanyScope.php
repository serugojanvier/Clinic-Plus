<?php
 
namespace App\Scopes;
 
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Scope;
use Illuminate\Database\Eloquent\Builder;
 
class CompanyScope implements Scope
{
    /**
     * Apply the scope to a given Eloquent query builder.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $builder
     * @param  \Illuminate\Database\Eloquent\Model  $model
     * @return void
     */
    public function apply(Builder $builder, Model $model)
    {
        $company = \request()->query('current_company') ?? auth()->user()->company_id;
        if(!empty($company)) {
            $builder->where("{$model->getTable()}.company_id", $company);
        }
    }
} 