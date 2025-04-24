<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>구매 요청 내역(관리자용)</title>
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #F4F4F4;
}

.container {
	max-width: 1000px;
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
		<h2>구매 요청 내역(관리자용)</h2>
		<table>
			<tr>
				<th>요청 ID</th>
				<th>요청자 ID</th>
				<th>요청자</th>
				<th>제품 ID</th>
				<th>제품명</th>
				<th>요청 수량</th>
				<th>요청 일자</th>
				<th>요청 내용</th>
				<th>상태</th>
			</tr>
			<c:choose>
				<c:when test="${not empty adminCheck}">
					<c:forEach var="request" items="${adminCheck}">
						<tr>
							<td>${request.requestId}</td>
							<td>${request.id}</td>
							<td>${request.userName}</td>
							<td>${request.productId}</td>
							<td>${request.prodoctName}</td>
							<td>${request.requestQuantity}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${request.requestDate}" /></td>
							<td><button class="btn btn-primary" onclick="requsetReason('${request.requestReason}')">요청내용보기</button></td>
							
							<c:if test="${request.requestStatus == '0'}">
								<td> 
									<button class="btn btn-success" onclick="approval('${request.requestId}')">승인</button>
									<button class="btn btn-success" onclick="reject('${request.requestId}')">반려</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="9" style="text-align: center; color: red;">목록이
							없습니다</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	<jsp:include page="/WEB-INF/includes/rejectModal.jsp" />
	<jsp:include page="/WEB-INF/includes/requsetReason.jsp" />
	<jsp:include page="/WEB-INF/includes/menuCanvas.jsp" />
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	// 요청내용보기 클릭
	function requsetReason(requestReason){
		console.log("requsetReason 접근 완료" + requestReason);
		$("#requestReasonText").text(requestReason);
		$("#requsetReason").modal('show');
	}

	// 승인 함수 호출
	function approval(requestId) {
		console.log("requestId : " + requestId);
		location.href = "approval.do?requestId=" + requestId;
	}
	
	// 반려 함수 
	function reject(requestId) {
		console.log("requestId : " + requestId);
		$("#requestIdHidden").val(requestId);
		$("#rejectModal").modal('show');
	}

    // 반려 사유 제출
    function submitReject() {
		var rejectReason = $("#rejectReason").val();
		var requestIdHidden = $("#requestIdHidden").val();
		
		console.log("rejectReason : " + rejectReason);
		console.log("requestIdHidden : " + requestIdHidden);

        if (rejectReason.trim() === '') {
            alert('반려 사유를 입력해주세요.');
            return;
        }else{
	        $('#rejectModal').modal('hide');
	        alert('반려 사유가 제출되었습니다.');
	        location.href = "reject.do?requestId=" + encodeURIComponent(requestIdHidden) +
            "&rejectReason=" + encodeURIComponent(rejectReason);	
        }
    }
</script>
</html>