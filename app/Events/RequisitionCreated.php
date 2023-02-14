<?php
 
namespace App\Events;
 
use Modules\Api\Models\Requisition;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Notification;

class RequisitionCreated 
{
    use SerializesModels;
 
    /**
     * The requisition instance.
     *
     * @var \Modules\Api\Models\Requisition
     */
    public $requisition;
 
    /**
     * Create a new event instance.
     *
     * @param  \Modules\Api\Models\Requisition  $requisition
     * @return void
     */
    public function __construct(Requisition $requisition)
    {
        $this->requisition = $requisition;
    }

    /**
     * Execute the job.
     * @return void
     */
    public function handle()
    {

    }
}