<?php

namespace App\Models\Stock;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StockOut extends Model
{
    use HasFactory;

    protected $fillable = [
        'company_id',
        'date_taken',
        'category',
        'patient_id',
        'insurance_id',
        'created_by'
    ];
}
