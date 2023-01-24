<?php

namespace App\Models\Stock;

use App\Models\User;
use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class StockReceive extends Model
{
    use HasFactory, CrudTrait, SoftDeletes;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'reference',
        'company_id',
        'date_received',
        'supplier_id',
        'amount',
        'vat',
        'file_url',
        'created_by'
    ];

    protected $casts = [
        'date_received' => 'date'
    ];

    protected $appends = ['total_items'];

    /**
     * @return HasMany
     */
    public function items()
    {
        return $this->hasMany(StockinHistory::class, 'stockin_id', 'id');
    }

    /**
     * @return BelongsTo
     */
    public function supplier()
    {
        return $this->belongsTo(Supplier::class, 'supplier_id');
    }

    /**
     * @return BelongsTo
     */
    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    /**
     * @return BelongsTo
     */
    public function company()
    {
        return $this->belongsTo(Company::class, 'company_id');
    }

    /**
     * @return int
     */
    public function getTotalItemsAttribute()
    {
        return StockinHistory::where('stockin_id', $this->id)->count();
    }
}
