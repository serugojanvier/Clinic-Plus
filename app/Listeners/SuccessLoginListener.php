<?php
 
namespace App\Listeners;

use App\Events\SuccessLoginEvent;
use Illuminate\Support\Facades\DB;

class SuccessLoginListener {
    /**
     * Create the event listener.
     *
     * @return void
    */
    public function __construct()
    {
        //
    }
 
    /**
     * Handle the event.
     *
     * @param  \App\Events\SuccessLoginEvent  $event
     * @return void
     */
    public function handle(SuccessLoginEvent $event)
    {
        $user = $event->user;
        $user->last_login = \Carbon\Carbon::now();
        $user->save();
    }
}