<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

.status-pending {
	color: orange;
}

.status-approved {
	color: green;
}

.status-rejected {
	color: red;
}
</style>
</head>
<body>
	<div class="container">
		<h2>내 구매 요청 내역</h2>
		<table>
			<tr>
				<th>요청 ID</th>
				<th>사용자 ID</th>
				<th>제품 ID</th>
				<th>수량</th>
				<th>요청 일자</th>
				<th>상태</th>
			</tr>
			<c:choose>
				<c:when test="${not empty checkResult}">
					<c:forEach var="request" items="${checkResult}">
						<tr>
							<td>${request.requestId}</td>
							<td>${request.id}</td>
							<td>${request.productId}</td>
							<td>${request.requestQuantity}</td>
							<td>${request.requestDate}</td>							
							<td>${request.requestStatus}</td>
							<td>${request.requestReason}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6" style="text-align: center; color: red;">목록이
							없습니다</td>
					</tr>
				</c:otherwise>

			</c:choose>
		</table>
	</div>
</body>
</html>
