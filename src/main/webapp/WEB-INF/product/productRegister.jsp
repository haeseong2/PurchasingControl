<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 등록</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<h2>제품 등록</h2>
		<form action="productRegister.do" method="post">
			<div class="mb-3">
				<label for="productName" class="form-label">제품명</label> <input
					type="text" class="form-control" id="productName"
					name="productName" required>
			</div>
			<div class="mb-3">
				<label for="productPrice" class="form-label">가격</label> <input
					type="number" class="form-control" id="productPrice"
					name="productPrice" required>
			</div>
			<div class="mb-3">
				<label for="productQuantity" class="form-label">재고</label> <input
					type="text" class="form-control" id="productQuantity"
					name="productQuantity" required>
			</div>
			<div class="mb-3">
				<label for="productDescription" class="form-label">설명</label>
				<textarea class="form-control" id="productDescription"
					name="productDescription" rows="3"></textarea>
			</div>
			<button type="submit" class="btn btn-success" >등록</button>
			<a href="main.jsp" class="btn btn-secondary">취소</a>
		</form>
	</div>

	<div class="modal fade" id="productRegisterSuccessModal" tabindex="-1"
		aria-labelledby="productRegisterSuccessModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="productRegisterSuccessModalLabel">제품
						등록 성공</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">제품이 성공적으로 등록되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="productRegisterFailModal" tabindex="-1"
	aria-labelledby="productRegisterFailModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="productRegisterFailModalLabel">제품 등록 실패</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
			</div>
			<div class="modal-body">제품 등록에 실패하였습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>
	


	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script>
	$(document).ready(function() {
		console.log("모달을 띄웁니다.");

		// 요청 성공 시 모달 띄우기
		<% if (session.getAttribute("productRegisterSuccess") != null && (Boolean) session.getAttribute("productRegisterSuccess")) { %>
			$('#productRegisterSuccessModal').modal('show');
			<% session.removeAttribute("productRegisterSuccess"); %>
		<% } %>

		// 요청 실패 시 모달 띄우기
		<% if (session.getAttribute("errorMessage") != null && (Boolean) session.getAttribute("errorMessage")) { %>
			$('#productRegisterFailModal').modal('show');
			<% session.removeAttribute("errorMessage"); %>
		<% } %>
	});
	</script>


</body>
</html>
