<?php
namespace App\Models\Stock;

use App\Models\User;
use App\Traits\CrudTrait;
use App\Models\Department;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Requisition extends Model
{
    use HasFactory, CrudTrait, SoftDeletes;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $table = 'requisitions';

    protected $fillable = [
        'reference',	
        'company_id',	
        'department_id',
        'date_initiated',	
        'amount',	
        'status',	
        'created_by',
    ];

    protected $casts = [
        'date_initiated' => 'date'
    ];

    protected $appends = ['total_items'];

    public function department()
    {
        return $this->belongsTo(Department::class, "department_id");
    }


    public function getTotalItemsAttribute()
    {
        return RequisitionItem::where('requisition_id', $this->id)->count();
    }
}