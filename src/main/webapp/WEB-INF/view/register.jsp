<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 会員登録 モーダル -->
<div class="modal fade" id="joinModal" tabindex="-1"
	aria-labelledby="joinModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="register.do" method="post">
				<div class="modal-header">
					<h5 class="modal-title" id="joinModalLabel">会員登録</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<label for="id" class="form-label">ID</label>
						<div class="input-group">
							<input type="text" class="form-control" id="id" name="id"
								value="<c:out value='${enteredId}'/>" required>
							<button type="button" class="btn btn-outline-secondary"
								onclick="checkId()">重複確認</button>
						</div>
					</div>
					<div class="mb-3">
						<label for="password" class="form-label">パスワード</label> <input
							type="password" class="form-control" id="password"
							name="password" required>
					</div>
					<div class="mb-3">
						<label for="name" class="form-label">名前</label> <input type="text"
							class="form-control" id="name" name="name" required>
					</div>
					<div class="mb-3">
						<label for="email" class="form-label">メールアドレス</label> <input
							type="email" class="form-control" id="email" name="email"
							required>
					</div>
					<div class="mb-3">
						<label for="role" class="form-label">権限</label> <select
							class="form-select" id="role" name="role" required>
							<option value="">権限を選択してください</option>
							<option value="0">管理者</option>
							<option value="1">ユーザー</option>
						</select>
					</div>
					<%
					if (request.getAttribute("error") != null) {
					%>
					<div class="alert alert-danger mt-3" role="alert">
						<%=request.getAttribute("error")%>
					</div>
					<%
					}
					%>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">登録する</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 会員登録成功モーダル -->
<div class="modal fade" id="registerSuccessModal" tabindex="-1"
	aria-labelledby="registerSuccessModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="registerSuccessModalLabel">会員登録成功</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="닫기"></button>
			</div>
			<div class="modal-body">
				<p>会員登録が正常に完了しました！</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary"
					data-bs-dismiss="modal">確認</button>
			</div>
		</div>
	</div>
</div>

<script>
	function setHiddenId() {
		document.getElementById("hiddenId").value = document
				.getElementById("id").value;
	}
</script>
<script>
	function checkId() {
		var id = document.getElementById("id").value.trim();
		if (id === "") {
			alert("IDを入力してください。");
			return;
		}
		window.location.href = "checkId.do?id=" + encodeURIComponent(id);
	}
</script>

