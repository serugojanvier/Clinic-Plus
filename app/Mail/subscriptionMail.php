<?php

namespace App\Mail;

use Illuminate\Http\Request;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class subscriptionMail extends Mailable
{
    use Queueable, SerializesModels;
    
    public $request;
    /**
     * Create a new message instance.
     *@param Request $request
     * @return void
     */
    public function __construct(Request $request)
    {
        $this->request = $request;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('subscription_email_template')
                    ->with([
                        'organization' => $this->request->input('organization'),
                        'phone' => $this->request->input('phone'),
                        'email' => $this->request->input('email'),
                        'subject' => 'Welcome to our service!',
                        'title' => 'ITEMeZE App From CODEBLOCK LTD',
                    ]);
    }
}
