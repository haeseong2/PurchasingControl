<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 承認確認モーダル -->
<div class="modal fade" id="approvalConfirmModal" tabindex="-1"
     aria-labelledby="approvalConfirmLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius: 1rem;">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="approvalConfirmLabel">承認確認</h5>
        <button type="button" class="btn-close btn-close-white"
                data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">このリクエストを承認しますか？</div>
      <div class="modal-footer">
        <input type="hidden" id="approveRequestIdHidden" />
        <input type="hidden" id="approvePageNoHidden" />
        
        <input type="hidden" id="approveKeywordHidden" />
        
        <button type="button" class="btn btn-primary" id="confirmApproveBtn">承認</button>
        <button type="button" class="btn btn-secondary"
                data-bs-dismiss="modal">キャンセル</button>
      </div>
    </div>
  </div>
</div>
