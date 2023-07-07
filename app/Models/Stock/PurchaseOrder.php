<?php

namespace App\Models\stock;

use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use App\Models\stock\PurchaseOrderItem;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PurchaseOrder extends Model
{
    use HasFactory, CrudTrait, SoftDeletes;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $table = 'purchase_order';
    protected $fillable = [
        'reference',	
        'company_id',	
        'date_initiated',	
        'amount',	
        'status',	
        'created_by',
    ];

    protected $casts = [
        'date_initiated' => 'date'
    ];

    protected $appends = ['total_items'];
    
    public function getTotalItemsAttribute()
    {
        return PurchaseOrderItem::where('order_id', $this->id)->count();
    }
}
