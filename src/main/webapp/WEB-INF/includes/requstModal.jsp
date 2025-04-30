<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 購入リクエストモーダル -->
<div class="modal fade" id="requestModal" tabindex="-1"
	aria-labelledby="joinModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- <form id="reqForm" action="request.do" method="post"> -->
			<%-- <form id="reqForm" action="${reqUrl}" method="post"> --%>
				<form id="reqForm" action="${pageContext.request.contextPath}/request.do" method="post">
				<div class="modal-header">
					<h5 class="modal-title" id="joinModalLabel">購入リクエスト</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<label for="quantity" class="form-label">数量</label> <input
							type="number" class="form-control" id="quantity" name="quantity"
							required>
					</div>
					<div class="mb-3">
						<label for="reason" class="form-label">リクエスト理由</label>
						<textarea class="form-control" id="reason" name="reason" rows="3"
							required></textarea>
					</div>
				</div>
				<input type="hidden" id="productId" name="productId"> <input
					type="hidden" id="requestStatus" name="requestStatus" value="0">
				<input type="hidden" name="pageNo" id="pageNoHidden"
					value="${currentPage}"> <input type="hidden"
					id="originalUrlHidden" name="originalUrl" value="${fullUrl}" />

				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">リクエストする</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- リクエスト成功モーダル -->
<div class="modal fade" id="RequestSuccessModal" tabindex="-1"
	aria-labelledby="RequestSuccessModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="requestSuccessModalLabel">リクエスト成功</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">リクエストが確認されました。</div>
			<div class="modal-footer">
				<a href="requestcheck.do" class="btn btn-primary">私の購入リクエストリスト</a>
				<button type="button" class="btn btn-secondary" id="requestSuccessCloseBtn">閉じる</button>
			</div>
		</div>
	</div>
</div>

<!-- リクエスト失敗モーダル -->
<div class="modal fade" id="RequestFailModal" tabindex="-1"
	aria-labelledby="RequestFailModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="requestFailModalLabel">リクエスト失敗</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">リクエストが失敗しました。再度確認してください。</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">閉じる</button>
			</div>
		</div>
	</div>
</div>