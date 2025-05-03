<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 差戻し理由入力モーダル -->
<div class="modal fade" id="rejectModal" tabindex="-1"
	aria-labelledby="rejectModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<!-- 中央揃え -->
		<div class="modal-content" style="border-radius: 1rem;">
			<div class="modal-header bg-danger text-white">
				<h5 class="modal-title" id="rejectModalLabel">差戻し理由の入力</h5>
				<button type="button" class="btn-close btn-close-white"
					data-bs-dismiss="modal" aria-label="閉じる"
					onclick="resetRejectReason()"></button>
			</div>
			<div class="modal-body">
				<form id="rejectForm">
					<div class="mb-3">
						<label for="rejectReason" class="form-label">差戻し理由を入力してください。</label>
						<textarea id="rejectReason" class="form-control" rows="4" required
							placeholder="例: リクエスト情報が不十分です。"></textarea>
					</div>
					<!-- <input type="hidden" id="requestId" value=""> -->

					<input type="hidden" id="requestIdHidden" value=""> 
					
					<input type="hidden" id="rejectPageNoHidden" value=""> 
					
					<input type="hidden" id="rejectKeywordHidden" value="">

				</form>
			</div>
			<div class="modal-footer justify-content-between">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal" onclick="resetRejectReason()">キャンセル</button>
				<button type="button" class="btn btn-danger"
					onclick="submitReject()">差戻し</button>

			</div>
		</div>
	</div>
</div>