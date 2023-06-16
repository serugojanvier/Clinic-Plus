<?php

namespace App\Models\Stock;

use App\Models\User;
use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ExpenseCategory extends Model
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
        'created_by'
    ];

        /**
     * @return BelongsTo
     */
    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by', 'id')
                    ->select('id', 'name')
                    ->withTrashed();
    }
}
