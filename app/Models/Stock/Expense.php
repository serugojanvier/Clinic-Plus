<?php

namespace App\Models\Stock;

use App\Models\User;
use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use App\Models\Stock\PaymentMethod;
use App\Models\Stock\ExpenseCategory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Expense extends Model
{
    use HasFactory, CrudTrait, SoftDeletes;

    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }
    
    protected $fillable = [
        'company_id',
        'category_id',
        'description',
        'amount',
        'payment_method',
        'created_by',
        'committed_date'
    ];

    public function category(){
        return $this->belongsTo(ExpenseCategory::class, 'category_id')->select('expense_categories.id','expense_categories.name');
    }

    public function PaymentMethod(){
        return $this->belongsTo(PaymentMethod::class, 'payment_method')->select('payment_methods.id','payment_methods.name');
    }

    
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
