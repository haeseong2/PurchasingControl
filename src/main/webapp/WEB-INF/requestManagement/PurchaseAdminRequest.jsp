<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>購入リクエスト履歴（管理者用）</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #F4F4F4;
}

.container {
	max-width: 1000px;
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

/* 페이징 hover 효과 */
.pagination .page-link {
    transition: background-color 0.3s, color 0.3s;
}
.pagination .page-link:hover {
    background-color: #0d6efd; /* 부트스트랩 primary 색상 */
    color: #fff;
}

/* 현재 페이지 active 스타일 */
.pagination .page-item.active .page-link {
    background-color: #0d6efd;
    border-color: #0d6efd;
    color: white;
}
</style>
</head>
<body>
	<div style="position: absolute; top: 20px; right: 20px;">
		<a href="index.jsp" class="btn btn-primary">ホームに戻る</a>
		<button class="btn btn-primary" type="button"
			data-bs-toggle="offcanvas" data-bs-target="#menuCanvas">☰
			カテゴリ</button>
	</div>

	<div class="container">
		<h2>購入リクエスト履歴（管理者用）</h2>
		<input type="hidden" id="pageNoHidden"
			value="${requestPage.currentPage}" /> 
		<input type="hidden" id="keywordHidden" 
		value="${param.keyword}" />
		
		<form action="requestAdmin.do" method="get" id="searchForm">
			<input type="text" name="keyword" placeholder="申請者を検索"
				style="width: 100%; padding: 5px; margin-bottom: 10px;">
			<button type="submit"
				style="width: 100%; padding: 5px; background-color: #4CAF50; color: white; border: none;">
				検索</button>
			<!-- TODO: 필요한 경우, 여기에 필터 옵션이나 정렬 기능을 넣을 수 있습니다 -->
		</form>
		<%-- <input type="hidden" id="pageNoHidden"
			value="${requestPage.currentPage}" /> 
		<input type="hidden" id="keywordHidden" 
		value="${param.keyword}" /> --%>
		<table>
			<tr>
				<th>リクエスト ID</th>
				<th>申請者 ID</th>
				<th>申請者</th>
				<th>製品 ID</th>
				<th>製品名</th>
				<th>リクエスト数量</th>
				<th>リクエスト日</th>
				<th>リクエスト内容</th>
				<th>ステータス</th>
			</tr>
			<c:choose>
				<c:when test="${not empty requestPage.getRequestList()}">
					<c:forEach var="request" items="${requestPage.getRequestList()}">
						<tr>
							<td>${request.requestId}</td>
							<td>${request.id}</td>
							<td>${request.userName}</td>
							<td>${request.productId}</td>
							<td>${request.prodoctName}</td>
							<td>${request.requestQuantity}</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${request.requestDate}" /></td>
							<td><button class="btn btn-primary"
									onclick="requsetReason('${request.requestReason}')">内容を表示</button></td>

							<c:if test="${request.requestStatus == '0'}">
								<td>
									<button class="btn btn-success"
										onclick="approval('${request.requestId}')">承認</button>
									<button class="btn btn-success"
										onclick="reject('${request.requestId}')">差し戻し</button>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="9" style="text-align: center; color: red;">リストがありません</td>
					</tr>
				</c:otherwise>
			</c:choose>

<c:if test="${requestPage.hasProducts}">
    <tr>
        <td colspan="9">
            <div class="d-flex justify-content-center">
                <nav>
                    <ul class="pagination gap-2">
                        <c:if test="${requestPage.startPage > 5}">
                            <li class="page-item">
                                <a class="page-link rounded-pill" href="requestAdmin.do?pageNo=${requestPage.startPage - 5}&keyword=${param.keyword}">前へ</a>
                            </li>
                        </c:if>

                        <c:forEach var="pNo" begin="${requestPage.startPage}" end="${requestPage.endPage}">
                            <li class="page-item ${pNo == requestPage.currentPage ? 'active' : ''}">
                                <a class="page-link rounded-pill" href="requestAdmin.do?pageNo=${pNo}&keyword=${param.keyword}">${pNo}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${requestPage.endPage < requestPage.totalPages}">
                            <li class="page-item">
                                <a class="page-link rounded-pill" href="requestAdmin.do?pageNo=${requestPage.startPage + 5}&keyword=${param.keyword}">次へ</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </td>
    </tr>
</c:if>

		</table>
	</div>
	<jsp:include page="/WEB-INF/includes/approvalConfirmModal.jsp" />
	<jsp:include page="/WEB-INF/includes/rejectModal.jsp" />
	<jsp:include page="/WEB-INF/includes/requsetReason.jsp" />
	<jsp:include page="/WEB-INF/includes/menuCanvas.jsp" />
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	/* var currentPage = "${param.pageNo != null ? param.pageNo : 1}"; */
	var currentKeyword = "${param.keyword != null ? param.keyword : ''}";

	// リクエスト内容を見る」クリック時の処理
	function requsetReason(requestReason) {
		console.log("requsetReason アクセス完了" + requestReason);
		$("#requestReasonText").text(requestReason);
		$("#requsetReason").modal('show');
	}

	// 承認処理の呼び出し
	// 1) 承認ボタンをクリック → モーダルを表示し、Hidden input に値を設定
	function approval(requestId) {
		var pageNo = document.getElementById("pageNoHidden").value;

		var keyword = document.getElementById("keywordHidden").value;

		$("#approveRequestIdHidden").val(requestId);
		$("#approvePageNoHidden").val(pageNo);

		$("#approveKeywordHidden").val(keyword);

		$("#approvalConfirmModal").modal('show');
	}

	// 2) モーダル内の「承認」ボタンをクリック → モーダルを閉じ、アラート表示、承認処理へ遷移
	function submitApprove() {
		var requestId = $("#approveRequestIdHidden").val();
		var pageNo = $("#approvePageNoHidden").val();

		var keyword = $("#approveKeywordHidden").val();

		// モーダルを閉じる
		$("#approvalConfirmModal").modal('hide');

		// 承認完了の通知
		alert("承認が完了しました。");

		// 承認処理呼び出し
		location.href = "approval.do?requestId="
				+ encodeURIComponent(requestId) + "&pageNo="
				+ encodeURIComponent(pageNo) 
				+ "&keyword=" + encodeURIComponent(keyword);
	}

	// ページ読み込み時にクリックイベントを設定
	$(function() {
		$("#confirmApproveBtn").on("click", submitApprove);
	});

	// 差し戻し処理の呼び出し 
	function reject(requestId) {
		console.log("requestId : " + requestId);
		var pageNo = document.getElementById("pageNoHidden").value;

		var keyword = document.getElementById("keywordHidden").value;

		$("#requestIdHidden").val(requestId);
		$("#rejectPageNoHidden").val(pageNo); // 現在のページ番号を保存

		$("#rejectKeywordHidden").val(keyword); 

		$("#rejectModal").modal('show');
	}

	//差し戻し理由を送信
	function submitReject() {
		var rejectReason = $("#rejectReason").val();
		var requestIdHidden = $("#requestIdHidden").val();
		var pageNo = $("#rejectPageNoHidden").val(); // ページ番号を取得

		var keyword = $("#rejectKeywordHidden").val();

		console.log("rejectReason : " + rejectReason);
		console.log("requestIdHidden : " + requestIdHidden);

		if (rejectReason.trim() === '') {
			alert('差し戻し理由を入力してください。');
			return;
		} else {
			$('#rejectModal').modal('hide');
			alert('差し戻し理由が送信されました。');
			location.href = "reject.do?requestId="
					+ encodeURIComponent(requestIdHidden) + "&rejectReason="
					+ encodeURIComponent(rejectReason) + "&pageNo="
					+ encodeURIComponent(pageNo) // ページ番号も一緒に渡す
					 + "&keyword=" + encodeURIComponent(keyword);
		}
	}
</script>
</html>