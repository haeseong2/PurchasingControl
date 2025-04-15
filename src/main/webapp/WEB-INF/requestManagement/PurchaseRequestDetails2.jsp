<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 구매 요청 내역</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f1f1f1;
        }
        .status-pending { color: orange; }
        .status-approved { color: green; }
        .status-rejected { color: red; }
    </style>
</head>
<body>
    <div class="container">
        <h2>내 구매 요청 내역</h2>
        <table>
            <thead>
                <tr>
                    <th>요청 ID</th>
                    <th>제품명</th>
                    <th>수량</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody id="request-table-body">
                <tr>
                    <td>201</td>
                    <td>모니터</td>
                    <td>2</td>
                    <td class="status-pending">대기 중</td>
                </tr>
                <tr>
                    <td>202</td>
                    <td>프린터</td>
                    <td>1</td>
                    <td class="status-approved">승인됨</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
    