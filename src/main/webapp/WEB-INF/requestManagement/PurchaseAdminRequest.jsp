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
		<input type="hidden" id="pageNoHidden"
			value="${requestPage.currentPage}" /> 
		<input type="hidden" id="keywordHidden" 
		value="${param.keyword}" />
		
		<form action="requestAdmin.do" method="get" id="searchForm">
			<input type="text" name="keyword" placeholder="요청자 검색"
				style="width: 100%; padding: 5px; margin-bottom: 10px;">
			<button type="submit"
				style="width: 100%; padding: 5px; background-color: #4CAF50; color: white; border: none;">
				검색</button>
			<!-- TODO: 필요한 경우, 여기에 필터 옵션이나 정렬 기능을 넣을 수 있습니다 -->
		</form>
		<%-- <input type="hidden" id="pageNoHidden"
			value="${requestPage.currentPage}" /> 
		<input type="hidden" id="keywordHidden" 
		value="${param.keyword}" /> --%>
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
				<c:when test="${not empty requestPage.getRequestList()}">
					<c:forEach var="request" items="${requestPage.getRequestList()}">
						<tr>
							<td>${request.requestId}</td>
							<td>${request.id}</td>
							<td>${request.userName}</td>
							<td>${request.productId}</td>
							<td>${request.prodoctName}</td>
							<td>${request.requestQuantity}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${request.requestDate}" /></td>
							<td><button class="btn btn-primary"
									onclick="requsetReason('${request.requestReason}')">요청내용보기</button></td>

							<c:if test="${request.requestStatus == '0'}">
								<td>
									<button class="btn btn-success"
										onclick="approval('${request.requestId}')">승인</button>
									<button class="btn btn-success"
										onclick="reject('${request.requestId}')">반려</button>
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

			<c:if test="${requestPage.hasProducts}">
				<tr>
					<td colspan="9"><c:if test="${requestPage.startPage > 5}">
							<a
								href="requestAdmin.do?pageNo=${requestPage.startPage - 5}&keyword=${param.keyword}">[이전]</a>
						</c:if> <c:forEach var="pNo" begin="${requestPage.startPage}"
							end="${requestPage.endPage}">
							<a href="requestAdmin.do?pageNo=${pNo}&keyword=${param.keyword}">[${pNo}]</a>
						</c:forEach> <c:if test="${requestPage.endPage < requestPage.totalPages}">
							<a
								href="requestAdmin.do?pageNo=${requestPage.startPage + 5}&keyword=${param.keyword}">[다음]</a>
						</c:if></td>
				</tr>
			</c:if>

		</table>
	</div>
	<jsp:include page="/WEB-INF/includes/approvalConfirmModal.jsp" />
	<jsp:include page="/WEB-INF/includes/rejectModal.jsp" />
	<jsp:include page="/WEB-INF/includes/requsetReason.jsp" />
	<jsp:include page="/WEB-INF/includes/menuCanvas.jsp" />
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	/* var currentPage = "${param.pageNo != null ? param.pageNo : 1}"; */
	var currentKeyword = "${param.keyword != null ? param.keyword : ''}";

	// 요청내용보기 클릭
	function requsetReason(requestReason) {
		console.log("requsetReason 접근 완료" + requestReason);
		$("#requestReasonText").text(requestReason);
		$("#requsetReason").modal('show');
	}

	// 승인 함수 호출
	// 1) 승인 버튼 클릭 → 모달 띄우고 Hidden input에 값 세팅
	function approval(requestId) {
		var pageNo = document.getElementById("pageNoHidden").value;

		var keyword = document.getElementById("keywordHidden").value;

		$("#approveRequestIdHidden").val(requestId);
		$("#approvePageNoHidden").val(pageNo);

		$("#approveKeywordHidden").val(keyword);

		$("#approvalConfirmModal").modal('show');
	}

	// 2) 모달 “승인” 버튼 클릭 → 모달 닫고, alert 띄우고, 실제 승인 요청으로 이동
	function submitApprove() {
		var requestId = $("#approveRequestIdHidden").val();
		var pageNo = $("#approvePageNoHidden").val();

		var keyword = $("#approveKeywordHidden").val();

		// 모달 닫기
		$("#approvalConfirmModal").modal('hide');

		// 승인 완료 알림
		alert("승인이 완료되었습니다.");

		// 실제 핸들러 호출
		location.href = "approval.do?requestId="
				+ encodeURIComponent(requestId) + "&pageNo="
				+ encodeURIComponent(pageNo) 
				+ "&keyword=" + encodeURIComponent(keyword);
	}

	// 페이지가 로드될 때 클릭 핸들러 연결
	$(function() {
		$("#confirmApproveBtn").on("click", submitApprove);
	});

	// 반려 함수 
	function reject(requestId) {
		console.log("requestId : " + requestId);
		var pageNo = document.getElementById("pageNoHidden").value;

		var keyword = document.getElementById("keywordHidden").value;

		$("#requestIdHidden").val(requestId);
		$("#rejectPageNoHidden").val(pageNo); // 현재 페이지 번호도 저장

		$("#rejectKeywordHidden").val(keyword); 

		$("#rejectModal").modal('show');
	}

	// 반려 사유 제출
	function submitReject() {
		var rejectReason = $("#rejectReason").val();
		var requestIdHidden = $("#requestIdHidden").val();
		var pageNo = $("#rejectPageNoHidden").val(); // 받아오기

		var keyword = $("#rejectKeywordHidden").val();

		console.log("rejectReason : " + rejectReason);
		console.log("requestIdHidden : " + requestIdHidden);

		if (rejectReason.trim() === '') {
			alert('반려 사유를 입력해주세요.');
			return;
		} else {
			$('#rejectModal').modal('hide');
			alert('반려 사유가 제출되었습니다.');
			location.href = "reject.do?requestId="
					+ encodeURIComponent(requestIdHidden) + "&rejectReason="
					+ encodeURIComponent(rejectReason) + "&pageNo="
					+ encodeURIComponent(pageNo) // 페이지 번호도 같이 넘기기
					 + "&keyword=" + encodeURIComponent(keyword);
		}
	}
</script>
</html>