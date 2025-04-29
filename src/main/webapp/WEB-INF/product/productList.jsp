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
<title>제품 목록 및 관리</title>
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
	width: 100%;
	max-width: 800px; /* 최대 너비 설정 */
	display: flex;
	flex-direction: column;
	gap: 20px;
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
</style>
</head>
<body>

	<c:choose>
		<c:when test="${empty param.pageNo}">
			<c:set var="realCurrentPage" value="1" />
		</c:when>
		<c:otherwise>
			<c:set var="realCurrentPage" value="${param.pageNo}" />
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${not empty param.keyword}">
			<!-- 검색 결과 화면인 경우 -->
			<c:set var="fullUrl"
				value="${pageContext.request.contextPath}/productsearch.do?keyword=${param.keyword}" />
		</c:when>
		<c:otherwise>
			<!-- 일반 제품 목록 화면인 경우 -->
			<c:set var="fullUrl"
				value="${pageContext.request.contextPath}/list.do?pageNo=${realCurrentPage}" />
		</c:otherwise>
	</c:choose>

	<c:set var="keywordParam" value="${param.keyword}" />

	<div style="position: absolute; top: 20px; right: 20px;">
		<a href="index.jsp" class="btn btn-primary">시작 페이지로</a>
		<button class="btn btn-primary" type="button"
			data-bs-toggle="offcanvas" data-bs-target="#menuCanvas">☰
			카테고리</button>
	</div>


	<div class="container">
		<div class="card">
			<h2>제품 리스트 조회</h2>
			<form action="productsearch.do" method="get" id="searchForm">
				<input type="text" name="keyword" placeholder="제품명 검색"
					style="width: 100%; padding: 5px; margin-bottom: 10px;">
				<button type="submit"
					style="width: 100%; padding: 5px; background-color: #4CAF50; color: white; border: none;">
					검색</button>
				<!-- TODO: 필요한 경우, 여기에 필터 옵션이나 정렬 기능을 넣을 수 있습니다 -->
			</form>
			<table>
				<tr>
					<th>품번</th>
					<th>제품 명</th>
					<th>제품 설명</th>
					<th>제품 가격</th>
					<th>재고</th>
					<th>구매요청</th>
				</tr>
				<c:choose>

					<c:when test="${not empty searchResult}">
						<c:forEach var="product" items="${searchResult}">
							<tr>
								<td>${product.productId}</td>
								<td>${product.productName}</td>
								<td>${product.productDescription}</td>
								<td>${product.productPrice}</td>
								<td>${product.productQuantity}</td>
								<td>
									<button type="button" class="btn btn-success"
										onclick="requestModal('${product.productId}', '${product.productQuantity}','${realCurrentPage}')">구매요청</button>
								</td>
							</tr>
						</c:forEach>
					</c:when>


					<c:when test="${not empty keyword and empty searchResult}">
						<tr>
							<td colspan="6" style="text-align: center; color: red;">검색
								결과가 없습니다</td>
						</tr>
					</c:when>


					<c:otherwise>
						<c:choose>
							<c:when test="${not empty product}">
								<c:forEach var="product" items="${product}">
									<tr>
										<td>${product.productId}</td>
										<td>${product.productName}</td>
										<td>${product.productDescription}</td>
										<td>${product.productPrice}</td>
										<td>${product.productQuantity}</td>
										<td>
											<button type="button" class="btn btn-success"
												onclick="requestModal('${product.productId}', '${product.productQuantity}','${realCurrentPage}')">구매요청</button>
										</td>
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
					</c:otherwise>
				</c:choose>

				<c:if test="${productPage.hasProducts}">
					<tr>
						<td colspan="6"><c:if test="${productPage.startPage > 5}">
								<a href="list.do?pageNo=${productPage.startPage - 5}">[이전]</a>
							</c:if> <c:forEach var="pNo" begin="${productPage.startPage}"
								end="${productPage.endPage}">
								<a href="list.do?pageNo=${pNo}">[${pNo}]</a>
							</c:forEach> <c:if test="${productPage.endPage < productPage.totalPages}">
								<a href="list.do?pageNo=${productPage.startPage + 5}">[다음]</a>
							</c:if></td>
					</tr>
				</c:if>

			</table>
		</div>
	</div>

	<jsp:include page="/WEB-INF/includes/requstModal.jsp" />
	<jsp:include page="/WEB-INF/includes/menuCanvas.jsp" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


	<script>
		// 요청 성공 시 모달 띄우기
	<%if (session.getAttribute("requestSuccess") != null && (boolean) session.getAttribute("requestSuccess")) {%>
		$(document).ready(function() {
			$('#RequestSuccessModal').modal('show');
		});
	<%session.removeAttribute("requestSuccess");%>
		
	<%}%>
		// 요청 실패 시 모달 띄우기
	<%if (session.getAttribute("requestFail") != null && (boolean) session.getAttribute("requestFail")) {%>
		$(document).ready(function() {
			$('#RequestFailModal').modal('show');
		});
	<%session.removeAttribute("requestFail");%>
		
	<%}%>
		var currentPage = parseInt('${realCurrentPage}', 10) || 1;

		function requestModal(productId, productQuantity, pageNo) {
			console.log("productId : " + productId);
			console.log("productQuantity : " + productQuantity);
			console.log("pageNo : " + pageNo)

			var fixedPageNo = pageNo || currentPage;

			$('#quantity').attr({
				min : 1,
				max : parseInt(productQuantity),
				value : 1
			});
			$('#productId').val(productId);

			$('#pageNoHidden').val(fixedPageNo);
			var keyword = '${empty keywordParam ? "" : keywordParam}';
			var contextPath = '${pageContext.request.contextPath}';
			if (keyword) {
				$('#originalUrlHidden').val(
						contextPath + '/productsearch.do?keyword='
								+ encodeURIComponent(keyword));
			} else {
				$('#originalUrlHidden').val(
						contextPath + '/list.do?pageNo=' + fixedPageNo);
			}

			$('#requestModal').modal('show');

		}
		$(document).ready(function() {
		    $('#requestSuccessCloseBtn').on('click', function() {
		        var keyword = '${empty keywordParam ? "" : keywordParam}';
		        var currentPage = parseInt('${realCurrentPage}', 10) || 1;
		        if (keyword) {
		            window.location.href = 'productsearch.do?keyword=' + encodeURIComponent(keyword);
		        } else {
		            window.location.href = 'list.do?pageNo=' + currentPage;
		        }
		    });
		});
	</script>

</body>
</html>