<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- リクエスト内容表示モーダル -->
<div class="modal fade" id="requsetReason" tabindex="-1" aria-labelledby="requestReasonLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered"> <!-- 中央揃え -->
        <div class="modal-content" style="border-radius: 1rem;">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="requestReasonLabel">リクエスト内容</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="닫기"></button>
            </div>
            <div class="modal-body">
                <p id="requestReasonText" class="form-control" style="height: auto; min-height: 100px; white-space: pre-wrap;"></p>
            </div>
            <div class="modal-footer justify-content-end">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">確認</button>
            </div>
        </div>
    </div>
</div>