<!DOCTYPE html>
<html>
<head>
    <title>Stock Report</title>
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
</head>
<body>
    <h1>Stock Report</h1>
    <table>
        <thead>
            <tr>
                <th>Total Receives amount</th>
                <th>Total Transfer Amount</th>
                <th>Total Sales</th>
                <th>Total Sales Amount</th>
                <th>Total Paid Amount</th>
                <th>Total Debts</th>
                <th>Total Expenses</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>{{ $stockReportData['ReceiveData'] }}</td>
                <td>{{ $stockReportData['transferData'] }}</td>
                <td>{{ $stockReportData['sales_count'] }}</td>
                <td>{{ $stockReportData['total_sales'] }}</td>
                <td>{{ $stockReportData['total_paid'] }}</td>
                <td>{{ $stockReportData['total_pending'] }}</td>
                <td>{{ $stockReportData['total_expenses']}}</td>
            </tr>
        </tbody>
    </table>
</body>
</html>
