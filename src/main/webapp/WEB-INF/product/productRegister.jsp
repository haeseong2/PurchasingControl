<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品登録</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<h2>商品登録</h2>
		<form action="productRegister.do" method="post">
			<div class="mb-3">
				<label for="productName" class="form-label">商品名</label> <input
					type="text" class="form-control" id="productName"
					name="productName" required>
			</div>
			<div class="mb-3">
				<label for="productPrice" class="form-label">価格</label> <input
					type="number" class="form-control" id="productPrice"
					name="productPrice" required>
			</div>
			<div class="mb-3">
				<label for="productQuantity" class="form-label">在庫数</label> <input
					type="text" class="form-control" id="productQuantity"
					name="productQuantity" required>
			</div>
			<div class="mb-3">
				<label for="productDescription" class="form-label">説明</label>
				<textarea class="form-control" id="productDescription"
					name="productDescription" rows="3"></textarea>
			</div>
			<button type="submit" class="btn btn-success" >登録</button>
			<a href="index.jsp" class="btn btn-secondary">キャンセル</a>
		</form>
	</div>

	<div class="modal fade" id="productRegisterSuccessModal" tabindex="-1"
		aria-labelledby="productRegisterSuccessModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="productRegisterSuccessModalLabel">商品登録成功</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">商品が正常に登録されました。</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">確認</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="productRegisterFailModal" tabindex="-1"
	aria-labelledby="productRegisterFailModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="productRegisterFailModalLabel">商品登録失敗</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
			</div>
			<div class="modal-body">商品登録に失敗しました。</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">確認</button>
			</div>
		</div>
	</div>
</div>
	


	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function() {
        console.log("モーダルを表示します。");

        // 登録成功時にモーダル表示
        <% if (request.getAttribute("productRegisterSuccess") != null && (Boolean) request.getAttribute("productRegisterSuccess")) { %>
            $('#productRegisterSuccessModal').modal('show');
            <% request.removeAttribute("productRegisterSuccess"); %>
        <% } %>

        // 登録失敗時にモーダル表示
        <% if (request.getAttribute("errorMessage") != null && (Boolean) request.getAttribute("errorMessage")) { %>
            $('#productRegisterFailModal').modal('show');
            <% request.removeAttribute("errorMessage"); %>
        <% } %>
    });
</script>


</body>
</html>
