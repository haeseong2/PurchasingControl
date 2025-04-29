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
		<form action="requestcheck.do" method="get" id="searchForm">
			<input type="text" name="keyword" placeholder="요청자 검색" value="${param.keyword}"
			 style="width: 100%; padding: 5px; margin-bottom: 10px;">
			<button type="submit"
				style="width: 100%; padding: 5px; background-color: #4CAF50; color: white; border: none;">
				검색</button>
			<!-- TODO: 필요한 경우, 여기에 필터 옵션이나 정렬 기능을 넣을 수 있습니다 -->
		</form>
		<table>
			<tr>
				<th>요청자</th>
				<th>제품 ID</th>
				<th>제품명</th>
				<th>요청 수량</th>
				<th>요청 일자</th>
				<c:choose>
					<c:when
						test="${not empty checkResult and checkResult[0].requestStatus == '2'}">
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
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${request.requestDate}" /></td>

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
								<td><button class="btn btn-primary"
										onclick="settle('${request.requestId}','${request.requestQuantity}')">정산요청</button></td>
							</c:if>

							<c:if test="${request.requestStatus == '2'}">
								<td><button class="btn btn-primary"
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

			<c:if test="${requestPage.hasProducts}">
				<tr>
					<td colspan="7"><c:if test="${requestPage.startPage > 5}">
							<a
								href="requestcheck.do?pageNo=${requestPage.startPage - 5}&keyword=${param.keyword}">[이전]</a>
						</c:if> <c:forEach var="pNo" begin="${requestPage.startPage}"
							end="${requestPage.endPage}">
							<a href="requestcheck.do?pageNo=${pNo}&keyword=${param.keyword}">[${pNo}]</a>
						</c:forEach> <c:if test="${requestPage.endPage < requestPage.totalPages}">
							<a
								href="requestcheck.do?pageNo=${requestPage.startPage + 5}&keyword=${param.keyword}">[다음]</a>
						</c:if></td>
				</tr>
			</c:if>

		</table>
	</div>

	<jsp:include page="/WEB-INF/includes/resendRequstModal.jsp" />
	<jsp:include page="/WEB-INF/includes/settleModal.jsp" />
	<jsp:include page="/WEB-INF/includes/menuCanvas.jsp" />

</body>
<script>
    var currentPage = ${param.pageNo != null ? param.pageNo : 1};
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">

	var currentPage = ${param.pageNo != null ? param.pageNo : 1};
	var keyword = $('input[name="keyword"]').val().trim();
	$('#keywordHidden').val(keyword || '');

	function resendRequestModal(requestId, quantity) {
		console.log("requestId : " + requestId);

		$('#requestIdHidden').val(requestId);
		$('#quantity').val(quantity).attr('readonly', true);
		$('#pageNoHidden').val(currentPage);
		
		$('#keywordHidden').val($('input[name="keyword"]').val().trim());
		
		$('#resendRequestModal').modal('show');
	}
	
	$('#resendSubmit').on('click', function() {
        $('#resendForm').submit();
    });

	function settle(requestId, requestQuantity) {
		console.log("requestId : " + requestId);
		
		var pageNo = $('#pageNoHidden').val() || currentPage;
        var kw     = $('input[name=keyword]').val() || '';
		
		/* location.href = "settle.do?requestId=" + requestId
				+ "&requestQuantity=" + requestQuantity
		 + "&pageNo=" + currentPage; */
		
        location.href = 'settle.do'
            + '?requestId='      + encodeURIComponent(requestId)
            + '&requestQuantity='+ encodeURIComponent(requestQuantity)
            + '&pageNo='         + encodeURIComponent(pageNo)
            + '&keyword='        + encodeURIComponent(kw);
	}

	function resendRequest(requestId) {
        console.log("requestId : " + requestId);
        
        var keyword = document.querySelector("input[name='keyword']").value;  // 검색어 값 가져오기
        var pageNo = document.getElementById("pageNoHidden").value;  // 페이지 번호 가져오기

        location.href = "resend.do?requestId=" + encodeURIComponent(requestId)
        + "&pageNo=" + encodeURIComponent(pageNo)
        + "&keyword=" + encodeURIComponent(keyword);
 
       /*  var pageNo = currentPage;  // 상단에서 선언해둔 변수
        location.href = "resend.do?requestId=" 
            + encodeURIComponent(requestId)
            + "&pageNo=" + encodeURIComponent(pageNo); */
    }

/* 	function resendRequestModal(requestId) {
		console.log("requestId : " + requestId);

		$('#requestIdHidden').val(requestId);
		$('#pageNoHidden').val(currentPage);
		$('#resendRequestModal').modal('show');
	} */
	
	  document.getElementById("closeButton").onclick = function() {
	    // 페이지 번호와 검색어를 URL에 포함시켜 리다이렉트
	    var pageNo = ${param.pageNo != null ? param.pageNo : 1};
	    var keyword = '${param.keyword != null ? param.keyword : ""}';  // JSP에서 처리된 값 전달
	    
	    // URL 구성
	    var url = "requestcheck.do?pageNo=" + pageNo;
	    if (keyword && keyword.trim() !== "") {
	      url += "&keyword=" + encodeURIComponent(keyword);
	    }

	    // 리다이렉트
	    window.location.href = url;
	  };
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
	
<%-- <%if (request.getAttribute("resendRequestSuccess") != null) {%>
	$(document).ready(function() {
		$('#RequestSuccessModal').modal('show');
	});
<%}%> --%>

<c:if test="${sessionScope.resendRequestSuccess}">

	$(function() {
    	$('#RequestSuccessModal').modal('show');
	});
	<c:remove var="resendRequestSuccess" scope="session" />

</c:if>

<!-- 요청 실패 시 모달 띄우기 -->

<%-- <%if (request.getAttribute("resendRequestSuccess") == null) {%>
	$(document).ready(function() {
		$('#RequestFailModal').modal('show');
	});
<%}%> --%>

<c:if test="${sessionScope.resendRequestFail}">
$(function() {
    $('#RequestFailModal').modal('show');
});
<c:remove var="resendRequestFail" scope="session" />
</c:if>

</script>
</html>
