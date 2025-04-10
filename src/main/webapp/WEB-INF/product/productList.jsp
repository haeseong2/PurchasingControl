<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>제품 목록 및 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
	background-color: #F4F4F4;
	display: flex;
	justify-content: center;
}
.container {
	width: 600px;
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
	<div class="container">
		<h1>제품 목록 및 관리</h1>
		<div class="card">
			<h2>제품 리스트 조회</h2>
			<input type="text" placeholder="제품명 검색"
				style="width: 100%; padding: 5px; margin-bottom: 10px;">
			<table>
				<tr>
					<th>품번</th>
					<th>이름</th>
					<th>설명</th>
					<th>가격</th>
					<th>재고</th>
					<th>구매요청</th>
				</tr>
				<c:forEach var="product" items="${product}">
					<tr>
						<td>${product.productId}</td>
						<td>${product.productName}</td>
						<td>${product.productDescription}</td>
						<td>${product.productPrice}</td>
						<td>${product.productQuantity}</td>
						<td>
						<button class="btn btn-success" onclick="requestModal('${product.productId}', '${product.productQuantity}')">구매요청</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>

<!-- 구매요청 모달 -->
<div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="joinModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="purchaseRequest.do" method="post">
        <div class="modal-header">
          <h5 class="modal-title" id="joinModalLabel">구매 요청</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body">
          <div class="mb-3">
            <label for="quantity" class="form-label">수량</label>
            <input type="number" class="form-control" id="quantity" name="quantity" required>
          </div>

          <div class="mb-3">
            <label for="reason" class="form-label">요청 사유</label>
            <textarea class="form-control" id="reason" name="reason" rows="3" required></textarea>
          </div>
        </div>
		<input type="hidden" id="productId" name="productId" >
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">요청하기</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>

<script type="text/javascript">
    function requestModal(productId,productQuantity) {
    	console.log("productId : " + productId);
    	console.log("productQuantity : " + productQuantity);
    	
    	var productQuantity = productQuantity;
    	$('#quantity').attr({
    	    min: 1,
    	    max: parseInt(productQuantity),
    	    value: 1
    	});
    	// 모달을 표시하는 코드
        $('#productId').val(productId);
        $('#requestModal').modal('show');
    }
</script>
</html>