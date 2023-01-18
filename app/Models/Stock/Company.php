<?php

namespace App\Models\Stock;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Company extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'name',	
        'phone',	
        'email',	
        'tin_number',
        'address_line',	
        'created_by',	
        'reference',
        'logo'
    ];

    /**
     *@return BelongsTo
     */
    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by')
                    ->select('users.name', 'users.id');
    }
}
