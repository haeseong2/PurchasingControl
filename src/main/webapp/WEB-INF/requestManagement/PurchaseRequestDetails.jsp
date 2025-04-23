<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 구매 요청 내역</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
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

#settleSuccessModal {
	display: none;
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
							<td><fmt:formatDate pattern="yyyy/MM/dd"
									value="${request.requestDate}" /></td>
							<c:if test="${request.requestStatus == '0'}">
								<td>요청중</td>
							</c:if>

							<c:if test="${request.requestStatus == '1'}">
								<td><button onclick="settle('${request.requestId}')">정산요청</button></td>
							</c:if>

							<c:if test="${request.requestStatus == '2'}">
								<td><button
										onclick="resendRequestModal('${request.requestId}')">재요청</button></td>
							</c:if>

							<c:if test="${request.requestStatus == '3'}">
								<td><button>정산 완료</button></td>
							</c:if>

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

	<jsp:include page="/WEB-INF/includes/resendRequstModal.jsp" />
	<jsp:include page="/WEB-INF/includes/settleModal.jsp" />


</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	function settle(requestId) {
		console.log("requestId : " + requestId);
		location.href = "settle.do?requestId=" + requestId;
	}

	function resendRequest(requestId) {
		console.log("requestId : " + requestId);
		location.href = "resend.do?requestId=" + requestId;
	}

	function resendRequestModal(requestId) {
		console.log("requestId : " + requestId);

		$('#requestIdHidden').val(requestId);
		$('#resendRequestModal').modal('show');
	}
</script>


<!--  "정산 완료" 모달 띄우기 -->
<c:if test="${sessionScope.settleSuccess}">
	<script>
		$(function() {
			$('#settleSuccessModal').modal('show');
		});
	</script>
	<c:remove var="settleSuccess" scope="session" />
</c:if>


<script>
<!-- 요청 성공 시 모달 띄우기 -->
<% if (request.getAttribute("resendRequestSuccess") != null) { %>
	$(document).ready(function() {
		$('#RequestSuccessModal').modal('show');
    });
<% } %>

<!-- 요청 실패 시 모달 띄우기 -->
<% if (request.getAttribute("resendRequestFail") != null) { %>
	$(document).ready(function() {
		$('#RequestFailModal').modal('show');
    });
<% } %>
</script>
</html>
