<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 再リクエストモーダル -->
<div class="modal fade" id="resendRequestModal" tabindex="-1"
	aria-labelledby="joinModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form action="resend.do" method="post">
				<div class="modal-header">
					<h5 class="modal-title" id="joinModalLabel">再リクエスト</h5>
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
				<input type="hidden" id="pageNoHidden" name="pageNo"> <input
					type="hidden" id="keywordHidden" name="keyword">

				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">リクエストする</button>
				</div>
				<input type="hidden" id="requestIdHidden" name="requestIdHidden">
			</form>
		</div>
	</div>
</div>

<!-- リクエスト成功モーダル -->
<div class="modal fade" id="resendRequestSuccessModal" tabindex="-1"
    aria-labelledby="resendRequestSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="resendRequestSuccessModalLabel">リクエスト成功</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <div class="modal-body">リクエストが確認されました。</div>
            <div class="modal-footer">
                <!-- <a href="requestcheck.do" class="btn btn-primary">私の購入リクエストリスト</a> -->
                <a href="requestcheck.do?pageNo=${param.pageNo != null ? param.pageNo : 1}
                    <c:if test="${not empty param.keyword}">
                        &amp;keyword=${param.keyword}
                    </c:if>"
                    class="btn btn-primary">私の購入リクエストリスト</a>
                <button type="button" class="btn btn-secondary"
                    data-bs-dismiss="modal">閉じる</button>
            </div>
        </div>
    </div>
</div>

<!-- リクエスト失敗モーダル -->
<div class="modal fade" id="resendRequestFailModal" tabindex="-1"
	aria-labelledby="resendRequestFailModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="resendRequestFailModalLabel">リクエスト失敗</h5>
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