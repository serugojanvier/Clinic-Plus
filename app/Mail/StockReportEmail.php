<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Support\Facades\Log;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class StockReportEmail extends Mailable implements ShouldQueue
{
    use Queueable, SerializesModels;

    public $stockReportData;

    /**
     * Create a new message instance.
     *
     * @param  array  $stockReportData
     * @return void
     */
    public function __construct(array $stockReportData)
    {
        $this->stockReportData = $stockReportData;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        // Log::info($this->stockReportData);

        return $this->view('stock_report')
                    ->subject('Stock Report')
                    ->with('stockReportData', $this->stockReportData);
    }
}
