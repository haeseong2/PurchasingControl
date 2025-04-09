<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 구매 요청 승인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .container {
            max-width: 700px;
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
        button {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .approve-btn { background-color: #28a745; color: white; }
        .reject-btn { background-color: #dc3545; color: white; }
        .approve-btn:hover { background-color: #218838; }
        .reject-btn:hover { background-color: #c82333; }
        .details {
            display: none;
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: #f1f1f1;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>관리자 구매 요청 승인</h2>
        <table>
            <thead>
                <tr>
                    <th>요청 ID</th>
                    <th>요청자</th>
                    <th>제품명</th>
                    <th>수량</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>301</td>
                    <td>홍길동</td>
                    <td>노트북</td>
                    <td>1</td>
                    <td>
                        <button onclick="toggleDetails(301)">상세 보기</button>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div id="details-301" class="details">
            <h3>요청 상세</h3>
            <p><strong>요청자:</strong> 홍길동</p>
            <p><strong>제품명:</strong> 노트북</p>
            <p><strong>수량:</strong> 1</p>
            <p><strong>사유:</strong> 신규 직원 지급용</p>
            <label for="comment">관리자 코멘트:</label>
            <input type="text" id="comment" placeholder="승인/거절 이유 입력">
            <button class="approve-btn" onclick="approveRequest(301)">승인</button>
            <button class="reject-btn" onclick="rejectRequest(301)">거절</button>
        </div>
    </div>

    <script>
        function toggleDetails(requestId) {
            const details = document.getElementById(`details-\${requestId}`);
            details.style.display = details.style.display === 'block' ? 'none' : 'block';
        }
        
        function approveRequest(requestId) {
            alert(`요청 ID \${requestId}가 승인되었습니다.`);
            document.getElementById(`details-\${requestId}`).style.display = 'none';
        }
        
        function rejectRequest(requestId) {
            alert(`요청 ID \${requestId}가 거절되었습니다.`);
            document.getElementById(`details-\${requestId}`).style.display = 'none';
        }
    </script>
</body>
</html>
    