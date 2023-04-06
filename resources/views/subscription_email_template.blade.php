<!DOCTYPE html>
<html>
<head>
    <title>{{ $subject }}</title>
    <style>
        /* Your email styles here */
        body {
            background-color: #f5f5f5;
            font-family: sans-serif;
            font-size: 14px;
            line-height: 1.4;
            color: #444;
        }

        .email-wrapper {
            max-width: 1000px;
            margin: 0 auto;
            background-color: #ddd;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }

        .email-header {
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .email-header img {
            max-width: 150px;
            height: auto;
        }

        .email-content {
            margin-bottom: 20px;
        }

        .email-footer {
            border-top: 1px solid #ddd;
            padding-top: 20px;
            font-size: 12px;
            color: #777;
        }

        .email-footer p {
            margin: 0;
        }

        .email-footer a {
            color: #777;
            text-decoration: none;
        }

        .email-footer a:hover {
            text-decoration: underline;
        }

        .alert-success{
            color: #3c763d;
            background-color: #dff0d8;
            border-color: #d6e9c6;
            font-weight:bold;
        }
        h1,.alert{
            font-family:comfortaa;
        }

        .alert{
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }

        .btn-danger{
            color: white;
            background-color: #d9534f;
            border-color: #d43f3a;
        }

        .btn-info{
            color: #fff;
            background-color: #337ab7;
            border-color: #2e6da4;
        }

        .btn{
            display: inline-block;
            margin-bottom: 0;
            font-weight: 400;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            -ms-touch-action: manipulation;
            touch-action: manipulation;
            cursor: pointer;
            background-image: none;
            border: 1px solid transparent;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            border-radius: 4px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        .capitalize{
            text-transform:uppercase;
        }
    </style>
</head>
<body>
    <div class="email-wrapper">
        <table class="email-header">
            <tr>
                <td>
                    <h1>{{ $title }}</h1>
                </td>
            </tr>
        </table>
        <div class="email-content">
            <p class="alert alert-success">Congratulations <b>{{ $organization }}</b> !</p>
            
            <p>Hello <b class="capitalize">{{ $organization }}</b> <i>[ {{ $phone }} ]</i>,</p>
            <p><i>Thank you for Subscription and using our service! We will call you for further Procedure about contract and others.</i></p>
            <p><i>For More information call <a href="call:+250781418920">+250781418920</a></i></p>
        </div>
        <table class="email-footer">
            <tr>
                <td>
                    <p>&copy; {{ date('Y') }} CODEBLOCK LTD</p>
                </td>
                <td>
                    <button class="btn btn-danger">Unsubscribe</button>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
