<?php

namespace App\Models\Stock;

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

    /**
     * @return HasMany
     */
    public function items()
    {
        return $this->hasMany(StockinHistory::class, 'stockin_id', 'id');
    }
}
