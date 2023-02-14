<?php

use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

define( 'MINUTE_IN_SECONDS', 60 );
define( 'HOUR_IN_SECONDS', 60 * MINUTE_IN_SECONDS );
define( 'DAY_IN_SECONDS', 24 * HOUR_IN_SECONDS );
define( 'WEEK_IN_SECONDS', 7 * DAY_IN_SECONDS );
define( 'MONTH_IN_SECONDS', 30 * DAY_IN_SECONDS );
define( 'YEAR_IN_SECONDS', 365 * DAY_IN_SECONDS );


function generateReference($length) {
    $reference = implode('', [
        bin2hex(random_bytes(2)),
        bin2hex(random_bytes(2)),
        bin2hex(chr((ord(random_bytes(1)) & 0x0F) | 0x40)) . bin2hex(random_bytes(1)),
        bin2hex(chr((ord(random_bytes(1)) & 0x3F) | 0x80)) . bin2hex(random_bytes(1)),
        bin2hex(random_bytes(2))
    ]);

    return strlen($reference) > $length ? substr($reference, 0, $length) : $reference;
}

function generateRowCode($len = 8){
    return strtoupper(substr(base_convert(uniqid(mt_rand()), 16, 36), 0, $len));
}

function getMonthDays($month = NULL, $year = NULL)
{
    if(is_null($month)) $month = date('m');
    if(is_null($year)) $year = date('Y');
    $startDate = "01-" . $month . "-" . $year;
    $startTime = strtotime($startDate);
    $endTime = strtotime("+1 month", $startTime);
    for($i=$startTime; $i < $endTime; $i+=86400){
        $list[] = date('Y-m-d', $i);
    }
    return $list;
}

function getNotifiableUsers($user)
{
    return User::get();
}
