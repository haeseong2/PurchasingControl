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
	background-color: #f8f9fa;
	padding: 20px;
	margin: 0;
}

.container {
	width: 100%;
	max-width: 800px; /* 넓은 화면을 위해 최대 너비 확장 */
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin: 0 auto;
}

.card {
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card h2 {
	margin-bottom: 15px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background: #F8F8F8;
}

.purchase-button {
	background: #009688;
	color: white;
	padding: 6px 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.purchase-button:hover {
	background-color: #00796B;
}
</style>
</head>
<body>
	<div style="position: absolute; top: 20px; right: 20px;">
		<a href="index.jsp" class="btn btn-primary">시작 페이지로</a>
		<button class="btn btn-primary" type="button"
			data-bs-toggle="offcanvas" data-bs-target="#menuCanvas">☰
			카테고리</button>
	</div>

	<div class="container">
		<h2>내 구매 요청 내역</h2>
		<table>
			<tr>
				<th>요청자</th>
				<th>제품 ID</th>
				<th>제품명</th>
				<th>요청 수량</th>
				<th>요청 일자</th>	
				<c:choose>
				  <c:when test="${not empty checkResult and checkResult[0].requestStatus == '2'}">
				    <th>반려 내용</th>
				  </c:when>
				  <c:otherwise>
				    <th>요청 내용</th>
				  </c:otherwise>
				</c:choose>	
				<th>상태</th>
			</tr>
			<c:choose>
				<c:when test="${not empty checkResult}">
					<c:forEach var="request" items="${checkResult}">
						<tr>
							<td>${request.userName}</td>
							<td>${request.productId}</td>
							<td>${request.prodoctName}</td>
							<td>${request.requestQuantity}</td>
						    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${request.requestDate}" /></td>
						    
						    <c:if test="${request.requestStatus != '2'}">
								<td>${request.requestReason}</td>
							</c:if>
							<c:if test="${request.requestStatus == '2'}">
								<td>${request.rejectReason}</td>
							</c:if>
						    
							<c:if test="${request.requestStatus == '0'}">
								<td>요청중</td>
							</c:if>

							<c:if test="${request.requestStatus == '1'}">
								<td><button class="btn btn-primary" onclick="settle('${request.requestId}','${request.requestQuantity}')">정산요청</button></td>
							</c:if>

							<c:if test="${request.requestStatus == '2'}">
								<td><button  class="btn btn-primary"
										onclick="resendRequestModal('${request.requestId}', '${request.requestQuantity}')">재요청</button></td>
							</c:if>

							<c:if test="${request.requestStatus == '3'}">
								<td>정산 완료</td>
							</c:if>

						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="7" style="text-align: center; color: red;">목록이
							없습니다</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>

	<jsp:include page="/WEB-INF/includes/resendRequstModal.jsp" />
	<jsp:include page="/WEB-INF/includes/settleModal.jsp" />
	<jsp:include page="/WEB-INF/includes/menuCanvas.jsp" />

</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	function resendRequestModal(requestId,quantity) {
		console.log("requestId : " + requestId);

		$('#requestIdHidden').val(requestId);
		$('#quantity').val(quantity).attr('readonly', true);
		$('#resendRequestModal').modal('show');
	}

	function settle(requestId,requestQuantity) {
		console.log("requestId : " + requestId);
		location.href = "settle.do?requestId=" + requestId + "&requestQuantity=" + requestQuantity;
	}

	function resendRequest(requestId) {
		console.log("requestId : " + requestId);
		location.href = "resend.do?requestId=" + requestId;
	}

<!-- 요청 성공 시 모달 띄우기 -->
<% if (request.getAttribute("resendRequestSuccess") != null) { %>
	$(document).ready(function() {
		$('#RequestSuccessModal').modal('show');
    });
<% } %>

<!-- 요청 실패 시 모달 띄우기 -->
<% if (request.getAttribute("resendRequestSuccess") == null) { %>
	$(document).ready(function() {
		$('#RequestFailModal').modal('show');
    });
<% } %>
</script>
</html>
