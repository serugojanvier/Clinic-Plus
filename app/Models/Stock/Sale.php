<?php
namespace App\Models\Stock;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Sale extends Model
{
    use SoftDeletes;
  
    protected $fillable = [
        'type',
        'reference',	
        'committed_date',	
        'total_amount',	
        'discounted_total',	
        'create_user',	
        'comment',	
        'amount_paid',
        'amount_remain',	
        'discount_perc',
        'discount_amount',
        'payment_date',
        'client_id',	
        'paid',
        'branch_id'
    ];

    protected $casts = [
        'committed_date' => 'date',
        'payment_date'   => 'date',
    ];

    protected $appends = ['payments'];

    protected $hidden = ['payments'];
    
    /**
     * @return BelongsTo
     */
    public function client()
    {
        return $this->belongsTo(Client::class, "client_id", 'id')
                    ->select('id', 'name')
                    ->withTrashed();
    }


    /**
     * @return BelongsTo
     */
    public function creator()
    {
        return $this->belongsTo(User::class, 'create_user', 'id')
                    ->select('id', 'name')
                    ->withTrashed();
    }

    /**
     * Payment
     * return the first payment -  This is required for edit only
     * @return Illuminate\Support\Collection
     */
     public function getPaymentsAttribute()
     {
        return Payment::where('transaction_id', $this->id)->select('id', 'payment_type')->get();
     }

     /**
     * @return BelongsTo
     */
    public function items()
    {
        return $this->hasMany(SaleItem::class, "sale_id", "id")
                    ->select('sale_items.*', 'products.name')
                    ->join('products', 'sale_items.item_id', '=', 'products.id');
    }
}