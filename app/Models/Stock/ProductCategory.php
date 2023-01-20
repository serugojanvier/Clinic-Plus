<?php

namespace App\Models\Stock;

use App\Traits\CrudTrait;
use App\Scopes\CompanyScope;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ProductCategory extends Model
{
    use HasFactory, CrudTrait;
    
    protected static function booted()
    {
        static::addGlobalScope(new CompanyScope);
    }

    protected $fillable = [
        'company_id',
        'parent_id',
        'name',
        'description',
        'created_by'
    ];

    //public $timestamps = false;

    /**
     * 
     * Appendable columns
     */
    protected $appends = ['children_total'];

     /**
     * @return BelongsTo
     */
    public function parent(): BelongsTo
    {
        return $this->belongsTo(ProductCategory::class, 'parent_id')->withDefault();
    }

    /**
     * @return HasMany
     */
    public function children(): HasMany
    {
        return $this->hasMany(ProductCategory::class, 'parent_id');
    }

    /**
     * @return int
     */

     public function getChildrenTotalAttribute() : int
     {
        return self::where('parent_id', $this->id)->count();
     }
}
