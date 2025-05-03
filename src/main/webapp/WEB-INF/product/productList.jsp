<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
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
<title>製品リストと管理</title>
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
	max-width: 800px; /* 最大幅設定 */
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

/* ページネーションのホバー効果 */
.pagination .page-link {
    transition: background-color 0.3s, color 0.3s;
}
.pagination .page-link:hover {
    background-color: #0d6efd; /* Bootstrapのprimary色 */
    color: #fff;
}

/* 現在ページのactiveスタイル */
.pagination .page-item.active .page-link {
    background-color: #0d6efd;
    border-color: #0d6efd;
    color: white;
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
			<!-- 検索結果画面の場合 -->
			<c:set var="fullUrl"
				value="${pageContext.request.contextPath}/productsearch.do?keyword=${param.keyword}" />
		</c:when>
		<c:otherwise>
			<!-- 通常の製品リスト画面の場合 -->
			<c:set var="fullUrl"
				value="${pageContext.request.contextPath}/list.do?pageNo=${realCurrentPage}" />
		</c:otherwise>
	</c:choose>

	<c:set var="keywordParam" value="${param.keyword}" />

	<div style="position: absolute; top: 20px; right: 20px;">
		<a href="index.jsp" class="btn btn-primary">ホームページへ</a>
		<button class="btn btn-primary" type="button"
			data-bs-toggle="offcanvas" data-bs-target="#menuCanvas">☰
			カテゴリ</button>
	</div>


	<div class="container">
		<div class="card">
			<h2>製品リストの照会</h2>
			<form action="productsearch.do" method="get" id="searchForm">
				<input type="text" name="keyword" placeholder="製品名検索"
					style="width: 100%; padding: 5px; margin-bottom: 10px;">
				<button type="submit"
					style="width: 100%; padding: 5px; background-color: #4CAF50; color: white; border: none;">
					検索</button>
			</form>
			<table>
				<tr>
					<th>品番</th>
					<th>製品名</th>
					<th>製品説明</th>
					<th>製品価格</th>
					<th>在庫数</th>
					<th>購入リクエスト</th>
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
										onclick="requestModal('${product.productId}', '${product.productQuantity}','${realCurrentPage}')">購入リクエスト</button>
								</td>
							</tr>
						</c:forEach>
					</c:when>


					<c:when test="${not empty keyword and empty searchResult}">
						<tr>
							<td colspan="6" style="text-align: center; color: red;">検索結果がありません</td>
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
												onclick="requestModal('${product.productId}', '${product.productQuantity}','${realCurrentPage}')">購入リクエスト</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" style="text-align: center; color: red;">リストがありません</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>

<c:if test="${productPage.hasProducts}">
    <tr>
        <td colspan="6">
            <div class="d-flex justify-content-center">
                <nav>
                    <ul class="pagination gap-2">
                        <c:if test="${productPage.startPage > 5}">
                            <li class="page-item">
                                <a class="page-link rounded-pill" href="list.do?pageNo=${productPage.startPage - 5}">前へ</a>
                            </li>
                        </c:if>

                        <c:forEach var="pNo" begin="${productPage.startPage}" end="${productPage.endPage}">
                            <li class="page-item ${pNo == productPage.currentPage ? 'active' : ''}">
                                <a class="page-link rounded-pill" href="list.do?pageNo=${pNo}">${pNo}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${productPage.endPage < productPage.totalPages}">
                            <li class="page-item">
                                <a class="page-link rounded-pill" href="list.do?pageNo=${productPage.startPage + 5}">次へ</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </td>
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
		// リクエスト成功時にモーダルを表示
	<%if (session.getAttribute("requestSuccess") != null && (boolean) session.getAttribute("requestSuccess")) {%>
		$(document).ready(function() {
			$('#RequestSuccessModal').modal('show');
		});
	<%session.removeAttribute("requestSuccess");%>
		
	<%}%>
		// リクエスト失敗時にモーダルを表示
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