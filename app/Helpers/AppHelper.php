<?php

use App\Models\User;
use Carbon\Carbon;
use App\Models\Stock\StockinHistory;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

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

    return strtoupper(strlen($reference) > $length ? substr($reference, 0, $length) : $reference);
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
    return User::where('company_id', $user->company_id)
                 ->where('id', '!=', $user->id)
                 ->get();
}


function setEnvironment(array $items)
{
    $str = file_get_contents(base_path('.env'));

    if (count($items) > 0) {
        foreach ($items as $item) {
            $key = strtoupper($item->key);
            $str .= "\n"; // In case the searched variable is in the last line without \n
            $keyPosition = strpos($str, "{$key}=");
            $endOfLinePosition = strpos($str, "\n", $keyPosition);
            $oldLine = substr($str, $keyPosition, $endOfLinePosition - $keyPosition);

            // If key does not exist, add it
            if (!$keyPosition || !$endOfLinePosition || !$oldLine) {
                $str .= "{$key}='{$item->value}'\n";
            } else {
                $str = str_replace($oldLine, "{$key}='{$item->value}'", $str);
            }
        }
    }

    $str = substr($str, 0, -1);
    if (!file_put_contents(base_path('.env'), $str)) return false;
    return true;
}

function handleConsumedItems(int $itemId, int $quantity)
{
    if ($quantity > 0) {
        $row = StockinHistory::where('product_id', $itemId)->whereNotIn('status', ['EXPIRED','CONSUMED'])->first();
        if ($row->quantity > ($row->consumed_qty + $quantity)) {
            $row->consumed_qty += $quantity;
            $row->save();
        } else {
            $remain = $row->quantity - $row->consumed_qty;
            $row->consumed_qty = $row->quantity;
            $row->status = 'CONSUMED';
            $row->save();
            $quantity -= $remain;
            if ($quantity > 0) {
                return handleConsumedItems($itemId, $quantity);
            }
        }
    } else {
        $row = StockinHistory::where('product_id', $itemId)
                                ->whereIn('status', ['IN_STOCK', 'CONSUMED'])
                                ->where('consumed_qty', '>', 0)
                                ->orderBy('id', 'DESC')
                                ->first();
        // Here will a + (-b) = a - b
        $quantity = $row->consumed_qty + $quantity;
        if ($quantity <= 0) {
            $row->consumed_qty = 0;
            $row->status = 'IN_STOCK';
            $row->save();
            if ($quantity != 0) {
                return handleConsumedItems($itemId, $quantity);
            }
        } else {
            $row->consumed_qty -= $quantity;
            $row->status = 'IN_STOCK';
            $row->save();
        }
    }
}