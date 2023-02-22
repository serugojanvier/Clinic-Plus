<?php

namespace App\Models;

use App\Models\Company;
use App\Scopes\CompanyScope;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable implements JWTSubject
{
    use Notifiable, SoftDeletes;

    protected $appends = ['alerts'];

    public function getAlertsAttribute()
    {
        return $this->unreadnotifications()->latest()->take(50)->get();
    }

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'company_id',
        'department_id',
        'first_name',
        'last_name',
        'name',
        'email',
        'password',
        'phone',
        'remember_token',
        'email_verified_at',
        'role_id',
        'last_login',
        'status',
        'created_by'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'last_login' => 'datetime',
    ];

        // Rest omitted for brevity

    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    /**
     *@return BelongsTo
     */
    public function role()
    {
        return $this->belongsTo(Role::class, "role_id");
    }

    /**
     *@return BelongsTo
     */
    public function company()
    {
        return $this->belongsTo(Company::class, "company_id")
                    ->select('companies.id', 'companies.name');
    }

    /**
     *@return BelongsTo
     */
    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by')
                    ->select('users.name', 'users.id');
    }

    /**
     * Scope a query to only include orders matching period of time.
     *
     * @param  \Illuminate\Database\Eloquent\Builder  $query
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeCompany($query)
    {
        $company = \request()->query('current_company') ?? auth()->user()->company_id;
        if(!empty($company)) {
            $query->where('company_id', $company);
        }
    }
    
    /**
     * @return BelongsTo
     */
    public function department()
    {
        return $this->belongsTo(Department::class, 'department_id')
                    ->select('departments.id', 'departments.name');
    }
}
