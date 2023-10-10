<?php

namespace App\Models\Stock;

use App\Scopes\CompanyScope;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;

class ProductTracker extends Model
{
    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $table = 'products';

    protected $appends = ['receiveQty', 'transferedQty'];

    /**
     * @var $from
     */
    private $from;

    /**
     * @var $from
     */
    private $to;

    public function __construct()
    {
        $this->from = date('Y-m-d');
        if (!empty($from = \request()->get('from'))) {
            $this->from = $from;
        }
        $this->to = \request()->get('to');
    }

    /**
     * @return BelongsTo
     */
    public function unit()
    {
        return $this->belongsTo(Unit::class, 'id')
                    ->select('units.id', 'units.name')
                    ->withTrashed();
    }

        /**
     * @return BelongsTo
     */
    public function category()
    {
        return $this->belongsTo(ProductCategory::class, 'category_id')
                    ->select('product_categories.id', 'product_categories.name')
                    ->withTrashed();
    }


    public function getReceiveQtyAttribute()
    {
        $result = DB::table('stockin_histories')
                      ->selectRaw('COALESCE(SUM(stockin_histories.quantity), 0) AS total')
                      ->join('stock_receives', 'stockin_histories.stockin_id', '=', 'stock_receives.id')
                      ->where('stockin_histories.product_id', $this->id)
                      ->where('stock_receives.company_id', $this->company_id)
                      ->whereNull('stockin_histories.deleted_at');
        if (empty($this->to)) {
            $result->where('stock_receives.date_received', '=', $this->from);
        } else {
            $result->where('stock_receives.date_received', '>=', $this->from)
                   ->where('stock_receives.date_received', '<=', $this->to);
        }
        return $result->first()->total;
    }

    public function getTransferedQtyAttribute()
    {
        $result = DB::table('stock_transfer_items')
                      ->selectRaw('COALESCE(SUM(stock_transfer_items.quantity), 0) AS total')
                      ->join('stock_transfers', 'stock_transfer_items.transfer_id', '=', 'stock_transfers.id')
                      ->where('stock_transfer_items.product_id', $this->id)
                      ->where('stock_transfers.company_id', $this->company_id)
                      ->whereNull('stock_transfer_items.deleted_at');
        if (empty($this->to)) {
            $result->where('stock_transfers.date_transfered', '=', $this->from);
        } else {
            $result->where('stock_transfers.date_transfered', '>=', $this->from)
                   ->where('stock_transfers.date_transfered', '<=', $this->to);
        }
        return $result->first()->total;
    }

}
