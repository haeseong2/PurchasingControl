<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ✅ 반려 사유 입력 모달 -->
<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered"> <!-- 중앙 정렬 -->
        <div class="modal-content" style="border-radius: 1rem;">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="rejectModalLabel">반려 사유 입력</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="닫기" onclick="resetRejectReason()"></button>
            </div>
            <div class="modal-body">
                <form id="rejectForm">
                    <div class="mb-3">
                        <label for="rejectReason" class="form-label">반려 사유를 입력해주세요</label>
                        <textarea id="rejectReason" class="form-control" rows="4" required placeholder="예: 요청 정보가 불충분합니다."></textarea>
                    </div>
                    <input type="hidden" id="requestId" value="">
                </form>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="resetRejectReason()">취소</button>
                <button type="button" class="btn btn-danger" onclick="submitReject()">반려</button>
                <input hidden="" id="requestIdHidden">
            </div>
        </div>
    </div>
</div>