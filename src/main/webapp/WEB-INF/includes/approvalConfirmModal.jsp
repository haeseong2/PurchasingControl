<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 승인 확인 모달 -->
<div class="modal fade" id="approvalConfirmModal" tabindex="-1"
     aria-labelledby="approvalConfirmLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" style="border-radius: 1rem;">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="approvalConfirmLabel">승인 확인</h5>
        <button type="button" class="btn-close btn-close-white"
                data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">이 요청을 승인하시겠습니까?</div>
      <div class="modal-footer">
        <input type="hidden" id="approveRequestIdHidden" />
        <input type="hidden" id="approvePageNoHidden" />
        
        <input type="hidden" id="approveKeywordHidden" />
        
        <button type="button" class="btn btn-primary" id="confirmApproveBtn">승인</button>
        <button type="button" class="btn btn-secondary"
                data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
