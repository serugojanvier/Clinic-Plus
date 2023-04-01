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
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
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
    </style>
</head>
<body>
    <div class="email-wrapper">
        <table class="email-header">
            <tr>
                <td>
                    <img src="{{ asset('images/logo.png') }}" alt="Logo">
                </td>
                <td>
                    <h1>{{ $title }}</h1>
                </td>
            </tr>
        </table>
        <div class="email-content">
            <p>Hello {{ $name }},</p>

            <p>This is an email from CodeBlock ltd.</p>

            <p>Thank you for Subscription and using our service!</p>
        </div>
        <table class="email-footer">
            <tr>
                <td>
                    <p>&copy; {{ date('Y') }} CODEBLOCK LTD</p>
                </td>
                <td>
                    <a href="#">Unsubscribe</a>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
