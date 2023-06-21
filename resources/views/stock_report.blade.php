<!DOCTYPE html>
<html>
<head>
    <title>Stock Report</title>
    <style>
        #customers {
            font-family: nunito;
            border-collapse: collapse;
            width: 100%;
        }

        #customers td, #customers th {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #customers tr:nth-child(even){background-color: #f2f2f2;}

        #customers tr:hover {background-color: #ddd;}

        #customers th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #3c3c3c;
            color: white;
        }
    </style>
</head>
<body>
    <h1>Stock Report</h1>
    <table id="customers">
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
                <td><h3>{{ number_format($stockReportData['ReceiveData'], 2) }}</h3></td>
                <td><h3>{{ number_format($stockReportData['transferData'], 2) }}</h3></td>
                <td><h3>{{ number_format($stockReportData['sales_count'], 2)}}</h3></td>
                <td><h3>{{ number_format($stockReportData['total_sales'], 2) }}</h3></td>
                <td><h3>{{ number_format($stockReportData['total_paid'], 2) }}</h3></td>
                <td><h3>{{ number_format($stockReportData['total_pending'], 2) }}</h3></td>
                <td><h3>{{ number_format($stockReportData['total_expenses'], 2) }}</h3></td>
            </tr>
        </tbody>
    </table>
</body>
</html>
