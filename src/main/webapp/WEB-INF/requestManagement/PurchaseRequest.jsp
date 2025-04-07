<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구매 요청</title>
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
        button {
            padding: 10px 15px;
            margin-top: 10px;
            border: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .editing {
            border: 2px solid red;
            background-color: #ffe6e6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 id="form-title">구매 요청</h2>
        <label for="product-select">제품 선택:</label>
        <select id="product-select">
            <option value="모니터">모니터</option>
            <option value="프린터">프린터</option>
            <option value="키보드">키보드</option>
            <option value="마우스">마우스</option>
        </select>
        <label for="quantity">수량:</label>
        <input type="number" id="quantity" min="1" value="1">
        <button id="submit-btn" onclick="handleRequest()">요청 제출</button>
        
        <table>
            <thead>
                <tr>
                    <th>요청 ID</th>
                    <th>제품명</th>
                    <th>수량</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody id="request-table-body">
            </tbody>
        </table>
    </div>

    <script>
        let requestId = 203;
        let editingRow = null;

        function handleRequest() {
            const product = document.getElementById('product-select').value;
            const quantity = document.getElementById('quantity').value;
            if (!quantity || quantity < 1) {
                alert('수량은 1 이상이어야 합니다.');
                return;
            }
            
            if (editingRow) {
                // 기존 행 수정
                editingRow.cells[1].innerText = product;
                editingRow.cells[2].innerText = quantity;
                document.getElementById('submit-btn').innerText = '요청 제출';
                document.getElementById('submit-btn').style.backgroundColor = '#007bff';
                document.getElementById('form-title').innerText = '구매 요청';
                document.getElementById('product-select').classList.remove('editing');
                document.getElementById('quantity').classList.remove('editing');
                editingRow = null;
            } else {
                // 새 요청 추가
                const tableBody = document.getElementById('request-table-body');
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>\${requestId}</td>
                    <td>\${product}</td>
                    <td>\${quantity}</td>
                    <td>대기 중</td>
                    <td>
                        <button onclick="editRequest(this)">수정</button>
                        <button onclick="deleteRequest(this)">삭제</button>
                    </td>
                `;
                tableBody.appendChild(row);
                requestId++;
            }
            
            // 입력 필드 초기화
            document.getElementById('product-select').value = '모니터';
            document.getElementById('quantity').value = 1;
        }

        function editRequest(button) {
            editingRow = button.parentElement.parentElement;
            document.getElementById('product-select').value = editingRow.cells[1].innerText;
            document.getElementById('quantity').value = editingRow.cells[2].innerText;
            document.getElementById('submit-btn').innerText = '수정 완료';
            document.getElementById('submit-btn').style.backgroundColor = 'red';
            document.getElementById('form-title').innerText = '구매 요청 수정 중';
            document.getElementById('product-select').classList.add('editing');
            document.getElementById('quantity').classList.add('editing');
        }

        function deleteRequest(button) {
            const row = button.parentElement.parentElement;
            row.remove();
            if (editingRow === row) {
                editingRow = null;
                document.getElementById('submit-btn').innerText = '요청 제출';
                document.getElementById('submit-btn').style.backgroundColor = '#007bff';
                document.getElementById('form-title').innerText = '구매 요청';
                document.getElementById('product-select').classList.remove('editing');
                document.getElementById('quantity').classList.remove('editing');
            }
        }
    </script>
</body>
</html>