<?php
namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Payment extends Model
{
    use SoftDeletes;
 
    protected $fillable = [
        'committed_date',	
        'transaction_id',	
        'amount_paid',
        'payment_type',
        'comment',
        'reference',
        'create_user'
    ];

    protected $casts = [
        'committed_date' => 'date'
    ];

    protected $appends = [ 'payment_mode' ];

    public function transaction()
    {
        return $this->belongsTo(Sale::class, "transaction_id", "id");
    }

    /**
     * Get Payment method name
     *  @return \Illuminate\Support\Collection
     */
    public function getPaymentModeAttribute()
    {
        $result = PaymentMethod::select('id', 'name')->where('id', $this->payment_type)
                            ->withTrashed()
                            ->first();
        if (!$result) {
            $result = new \stdClass();
            $result->id = 1;
            $result->name = 'CASH'; 
        }

        return $result;
    }
}