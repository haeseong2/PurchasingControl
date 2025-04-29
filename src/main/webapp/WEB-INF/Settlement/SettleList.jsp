<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>정산 완료 리스트</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	padding: 30px;
}

.container {
	max-width: 900px;
	background: white;
	padding: 20px;
	border-radius: 10px;
}

h2 {
	margin-bottom: 20px;
}

table th, table td {
	text-align: center;
}
</style>
</head>
<body>

	<div class="container">
		<h2>정산 완료 요청 리스트</h2>

		<table class="table table-bordered">
			<thead>
				<tr>
					<th>요청자</th>
					<th>제품명</th>
					<th>정산 금액</th>
					<th>정산 일자</th>
					<th>정산 상태</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<%--                 <c:when test="${not empty settlementList}">
                    <c:forEach var="item" items="${settlementList}"> --%>
					<c:when test="${not empty index}">
						<c:forEach var="item" items="${index}">
							<tr>
								<td>${item.userName}</td>
								<td>${item.productName}</td>
								<%-- <td>${item.totalAmount}</td> --%>
								<td>${item.productPrice}</td>
								<td>${item.settlementDate}</td>
								<td>정산 완료</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<!-- <td colspan="6">정산 완료된 요청이 없습니다.</td> -->
							<td colspan="5">정산 완료된 요청이 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>

			<c:if test="${indexPage.hasProducts}">
				<tr>
					<td colspan="5">
						<!-- 이전 블록 --> <c:if test="${indexPage.startPage > 1}">
							<a href="index.do?pageNo=${indexPage.startPage-5}">[이전]</a>
						</c:if> <!-- 페이지 번호 링크 --> <c:forEach var="pNo"
							begin="${indexPage.startPage}" end="${indexPage.endPage}">
							<a href="index.do?pageNo=${pNo}">[${pNo}]</a>
						</c:forEach> <!-- 다음 블록 --> <c:if
							test="${indexPage.endPage < indexPage.totalPages}">
							<a href="index.do?pageNo=${indexPage.startPage+5}">[다음]</a>
						</c:if>

					</td>
				</tr>
			</c:if>

		</table>

		<a href="index.jsp" class="btn btn-secondary">홈으로 돌아가기</a>
	</div>

</body>
</html>