<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use App\Mail\StockReportEmail;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Cache;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class SendScheduledStockReportJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $email;

    /**
     * Create a new job instance.
     *
     * @param  string  $email
     * @return void
     */
    public function __construct(string $email)
    {
        $this->email = $email;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $caches = Cache::many(['ReceiveAndTransferStockData','PosCache']);
        $StockReportData = array_merge($caches['ReceiveAndTransferStockData'], $caches['PosCache']);
        $email = new StockReportEmail($StockReportData);
        Mail::to($this->email)->send($email);
    }
}
