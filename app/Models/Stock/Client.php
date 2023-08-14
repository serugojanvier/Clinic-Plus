<?php

namespace App\Models\Stock;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Client extends Model
{
    use SoftDeletes;
    protected $fillable = [
        'name',
        'tinnumber',
        'phone',
        'email',
        'discount',
        'address'
    ];
}