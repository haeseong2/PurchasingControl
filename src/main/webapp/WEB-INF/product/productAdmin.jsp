<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>製品管理（管理者用）</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
	background-color: #f4f4f4;
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
	background: #f8f8f8;
}

.actions {
	margin-top: 10px;
	display: flex;
	justify-content: space-between;
}

.actions button {
	padding: 8px 12px;
	cursor: pointer;
	border: none;
	border-radius: 5px;
}

.actions button:hover {
	opacity: 0.8;
}

.save {
	background: #4CAF50;
	color: white;
}

.delete {
	background: #f44336;
	color: white;
}

.increase {
	background: #2196F3;
	color: white;
}

.decrease {
	background: #FF9800;
	color: white;
}

.form-group {
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="card">
			<h2>製品詳細および編集（管理者専用）</h2>
			<div class="form-group">
				<label>製品名:</label> <input type="text" id="productName" value="상품 A"
					style="width: 100%; padding: 5px;">
			</div>
			<div class="form-group">
				<label>説明:</label>
				<textarea id="productDesc" style="width: 100%; padding: 5px;">この製品は...</textarea>
			</div>
			<div class="form-group">
				<label>価格:</label> <input type="number" id="productPrice"
					value="10000" style="width: 100%; padding: 5px;">
			</div>
			<div class="form-group">
				<label>在庫:</label> <input type="number" id="productStock" value="10"
					style="width: 100%; padding: 5px;">
			</div>
			<div class="actions">
				<button class="save" id="saveBtn">保存</button>
				<button class="delete" id="deleteBtn">削除</button>
				<button class="increase" id="increaseStock">在庫 +</button>
				<button class="decrease" id="decreaseStock">在庫 -</button>
			</div>
		</div>
	</div>
	
	<script>
		document.getElementById("saveBtn").onclick = function() {
			alert("保存されました!");
			window.location.href = '<c:url value="/product/list.do"/>';
		};

		document.getElementById("deleteBtn").onclick = function() {
			if (confirm("本当に削除しますか?")) {
				alert("削除されました!");
				window.location.href = '<c:url value="/product/list.do"/>';
			}
		};

		document.getElementById("increaseStock").onclick = function() {
			let stockInput = document.getElementById("productStock");
			stockInput.value = parseInt(stockInput.value) + 1;
		};

		document.getElementById("decreaseStock").onclick = function() {
			let stockInput = document.getElementById("productStock");
			if (parseInt(stockInput.value) > 0) {
				stockInput.value = parseInt(stockInput.value) - 1;
			} else {
				alert("在庫がありません!");
			}
		};
	</script>
</body>
</html>