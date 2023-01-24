<?php

namespace App\Models\Stock;

use App\Models\User;
use App\Traits\CrudTrait;
use App\Models\Department;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class StockTransfer extends Model
{
    use HasFactory, CrudTrait, SoftDeletes;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'company_id',
        'department_id',
        'reference',
        'date_transfered',	
        'amount',	
        'taken_by',
        'created_by'
    ];

    protected $casts = [
        'date_transfered' => 'date'
    ];

    protected $appends = ['total_items'];

    /**
     * @return HasMany
     */
    public function items()
    {
        return $this->hasMany(StockTransferItems::class, 'stockin_id', 'id');
    }

    /**
     * @return BelongsTo
     */
    public function employee()
    {
        return $this->belongsTo(User::class, 'taken_by')
                    ->select('users.id', 'users.name');
    }

    /**
     * @return BelongsTo
     */
    public function department()
    {
        return $this->belongsTo(Department::class, 'department_id')
                    ->select('departments.id', 'departments.name');
    }

    /**
     * @return int
     */
    public function getTotalItemsAttribute()
    {
        return StockTransferItems::where('stockin_id', $this->id)->count();
    }
}
