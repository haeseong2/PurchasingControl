<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>구매 요청 내역(관리자용)</title>
<!-- ✅ jQuery & Bootstrap 스크립트 먼저 로드 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
  .modal-dialog {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh; /* 화면 높이에 맞게 중앙 정렬 */
  }
  
body {
	font-family: Arial, sans-serif;
	text-align: center;
	background-color: #f8f9fa;
	padding: 20px;
}

.container {
	max-width: 600px;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: left;
}

th {
	background-color: #f1f1f1;
}

.status-pending {
	color: orange;
}

.status-approved {
	color: green;
}

.status-rejected {
	color: red;
}

/* ✅ 모달 기본적으로 숨김 처리 */
#ApproveSuccessModal {
	display: none;
}
#rejectModal {
	display: none;
}
</style>
</head>
<body>
	<div class="container">
		<h2>구매 요청 내역(관리자용)</h2>
		<table>
			<tr>
				<th>요청 ID</th>
				<th>사용자 ID</th>
				<th>제품 ID</th>
				<th>수량</th>
				<th>요청 일자</th>
				<th>상태</th>
			</tr>
			<c:choose>
				<c:when test="${not empty adminCheck}">
					<c:forEach var="request" items="${adminCheck}">
						<tr>
							<td>${request.requestId}</td>
							<td>${request.id}</td>
							<td>${request.productId}</td>
							<td>${request.requestQuantity}</td>
							<td><fmt:formatDate pattern="yyyy/MM/dd"
									value="${request.requestDate}" /></td>
							<c:if test="${request.requestStatus == '0'}">
								<td> 
									<button onclick="approval('${request.requestId}')">승인</button>
									<button onclick="reject('${request.requestId}')">반려</button>
								</td>
							</c:if>
							<td>${request.requestReason}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="7" style="text-align: center; color: red;">목록이
							없습니다</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>

	<!-- ✅ 승인 완료 모달 -->
	<div class="modal fade" id="ApproveSuccessModal" tabindex="-1"
		aria-labelledby="ApproveSuccessModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ApproveSuccessModalLabel">승인 완료</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="닫기"></button>
				</div>
				<div class="modal-body">
					<p>요청이 성공적으로 승인되었습니다.</p>

					<c:if test="${not empty approvedRequest}">
					  <div id="approveModal">
						<ul style="text-align: left;">
							<li><strong>요청 ID:</strong> ${approvedRequest.requestId}</li>
							<li><strong>사용자 ID:</strong> ${approvedRequest.id}</li>
							<li><strong>제품 ID:</strong> ${approvedRequest.productId}</li>
							<li><strong>수량:</strong> ${approvedRequest.requestQuantity}</li>
							<li><strong>요청일:</strong> <fmt:formatDate
									value="${approvedRequest.requestDate}" pattern="yyyy/MM/dd" /></li>
							<li><strong>상태:</strong> <c:choose>
									<c:when test="${approvedRequest.requestStatus == '1'}">승인</c:when>
									<c:otherwise>기타</c:otherwise>
								</c:choose></li>
						</ul>
					  </div>	
					</c:if>

					<c:if test="${empty approvedRequest}">
						<p style="color: red;">❌ 승인된 요청 데이터를 불러오지 못했습니다.</p>
					</c:if>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ✅ 승인 성공 시 모달 띄우기 -->
	<c:if test="${approveSuccess == true}">
		<script>
			$(document).ready(
					function() {
						// 모달이 보이도록 설정 (처음에는 숨겨져 있음)
						const modalElement = document
								.getElementById('ApproveSuccessModal');
						const myModal = new bootstrap.Modal(modalElement);
						myModal.show();
					});
		</script>
	</c:if>

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

</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	// 승인 함수 호출
	function approval(requestId) {
		console.log("requestId : " + requestId);
		location.href = "approval.do?requestId=" + requestId;
	}
	
	// 반려 함수 
	function reject(requestId) {
		console.log("requestId : " + requestId);
		$("#requestIdHidden").val(requestId);
		$("#rejectModal").modal('show');
	}

    // 반려 사유 제출
    function submitReject() {
		var rejectReason = $("#rejectReason").val();
		var requestIdHidden = $("#requestIdHidden").val();
		
		console.log("rejectReason : " + rejectReason);
		console.log("requestIdHidden : " + requestIdHidden);

        if (rejectReason.trim() === '') {
            alert('반려 사유를 입력해주세요.');
            return;
        }else{
	        $('#rejectModal').modal('hide');
	        alert('반려 사유가 제출되었습니다.');
	        location.href = "reject.do?requestId=" + encodeURIComponent(requestIdHidden) +
            "&rejectReason=" + encodeURIComponent(rejectReason);	
        }
    }

    // 모달 내용 초기화
    function resetRejectReason() {
        document.getElementById('rejectReason').value = '';
    }
</script>

<c:if test="${sessionScope.reject}">
    <script>
        $(function() {
            $('#rejectModal').modal('show'); // 서버에서 reject가 true일 때 모달 띄우기
        });
    </script>
    <c:remove var="reject" scope="session" /> <!-- 세션에서 reject 변수 제거 -->
</c:if>
</html>