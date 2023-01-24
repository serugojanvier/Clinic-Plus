<?php

namespace App\Models;

use App\Models\User;
use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Department extends Model
{
    use HasFactory, CrudTrait, SoftDeletes;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'company_id',
        'name',
        'description',
        'leader_id',
        'status',
        'created_by'
    ];

    /**
     * @return BelongsTo
     */
    public function leader()
    {
        return $this->belongsTo(User::class, 'leader_id');
    }
}