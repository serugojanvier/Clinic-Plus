<?php

namespace App\Models\Stock;

use App\Models\User;
use App\Traits\CrudTrait;
use App\Models\Department;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Adjustment extends Model
{
    use HasFactory, CrudTrait, SoftDeletes;

    protected $table = 'stock_adjustments';

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'reference',
        'company_id',	
        'adjustment_date',	
        'reason',	
        'department_id',	
        'description'
    ];

    protected $casts = [
        'adjustment_date' => 'date'
    ];

    protected $appends = ['total_items'];

    /**
     * @return HasMany
     */
    public function items()
    {
        return $this->hasMany(AdjustedItem::class, 'adjustment_id', 'id');
    }

    /**
     * @return BelongsTo
     */
    public function department()
    {
        return $this->belongsTo(Department::class, 'department_id');
    }

    /**
     * @return int
     */
    public function getTotalItemsAttribute()
    {
        return AdjustedItem::where('adjustment_id', $this->id)->count();
    }
}
