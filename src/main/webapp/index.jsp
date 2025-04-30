<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	session="true"%>
<%@ page language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>購入管理システム</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- </head> -->
<style>
.offcanvas-end {
	width: 260px;
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
/* 조건부 모달 공통 디자인 */
.modal-dialog.custom-modal {
	max-width: 500px;
	margin-top: 10vh; /* 중앙보다 살짝 위 */
}

/* 중복일 때 - 붉은색 강조 */
.modal-header.duplicate {
	background-color: #f8d7da;
	color: #721c24;
}

.modal-body.duplicate {
	font-weight: bold;
	color: #721c24;
}

/* 사용 가능할 때 - 초록색 강조 */
.modal-header.available {
	background-color: #d4edda;
	color: #155724;
}

.modal-body.available {
	font-weight: bold;
	color: #155724;
}

.modal-dialog.top-centered {
	position: fixed;
	top: 10%; /* 화면 상단에서 10% 내려온 위치 */
	left: 50%;
	transform: translateX(-50%);
	margin: 0 auto;
	z-index: 1055; /* 다른 모달 위로 오도록 보장 */
}
</style>
</head>
<body>
	<div class="container text-center mt-5">
		<h1>購入管理システム</h1>
		<%
		String username = (String) session.getAttribute("user");
		String userRole = (String) session.getAttribute("userRole"); // "0" = 관리자, "1" = 사용자
		System.out.println(userRole);
		if (username == null) {
		%>
		<button class="btn btn-primary me-2"
			onclick="$('#loginModal').modal('show')">ログイン</button>
		<button class="btn btn-success"
			onclick="$('#joinModal').modal('show')">会員登録</button>
		<%
		} else {
		%>
		<p>
			<strong><%=username%></strong> さん、ようこそ。
		</p>
		<a href="logout.do" class="btn btn-danger">Logout</a>
		<button class="btn btn-primary" type="button"
			data-bs-toggle="offcanvas" data-bs-target="#menuCanvas">☰
			カテゴリー</button>
		<%
		}
		%>
	</div>
	<!-- Login モーダル -->
	<jsp:include page="/WEB-INF/view/login.jsp" />
	<!-- 会員登録 モーダル -->
	<jsp:include page="/WEB-INF/view/register.jsp" />
	<!-- 会員登録成功 モーダル -->
	<div class="modal fade" id="duplicateModal" tabindex="-1"
		aria-labelledby="duplicateModalLabel" aria-hidden="true">
		<div class="modal-dialog top-centered">
			<div class="modal-content">
				<div class="modal-header duplicate">
					<h5 class="modal-title" id="duplicateModalLabel">重複確認結果</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="閉じる"></button>
				</div>
				<div class="modal-body duplicate">このIDは既に使用されています。</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal" onclick="$('#joinModal').modal('show')">戻る</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="availableModal" tabindex="-1"
		aria-labelledby="availableModalLabel" aria-hidden="true">
		<div class="modal-dialog top-centered">
			<div class="modal-content">
				<div class="modal-header available">
					<h5 class="modal-title" id="availableModalLabel">重複確認結果</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="閉じる"></button>
				</div>
				<div class="modal-body available">このIDは使用可能です！</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" onclick="$('#joinModal').modal('show')">登録を続ける</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="duplicateModal" tabindex="-1"
		aria-labelledby="duplicateModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="margin-top: 80px;">
			<div class="modal-content bg-light border border-danger shadow">
				<div class="modal-header">
					<h5 class="modal-title" id="registerSuccessModalLabel">会員登録成功</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">会員登録が完了しました。</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">閉じる</button>
					<a href="login.jsp" class="btn btn-primary">Login</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Login 失敗モーダル -->
	<div class="modal fade" id="loginFailModal" tabindex="-1"
		aria-labelledby="loginFailModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginFailModalLabel">ログイン 失敗</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">IDまたはパスワードが一致しません。</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">閉じる</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 表のヘッダー -->
	<div class="container mt-4">
		<table class="table table-bordered table-striped text-center mx-auto"
			style="width: 80%;">
			<thead class="table-dark">
				<tr>
					<th>申請者</th>
					<th>製品名</th>
					<th>精算完了日</th>
					<th>製品価格</th>
				</tr>
			</thead>
			<tbody>
				<%--   <c:forEach var="item" items="${requestResult}"> --%>
				<c:forEach var="item" items="${index}">
					<tr>
						<td>${item.userName}</td>
						<td>${item.productName}</td>
						<td>${item.settlementDate}</td>
						<td>${item.productPrice}</td>
					</tr>
				</c:forEach>


				<c:if test="${indexPage.hasProducts}">
					<tr>
						<td colspan="4">
							<div class="d-flex justify-content-center">
								<nav>
									<ul class="pagination gap-2">
										<c:if test="${indexPage.startPage > 5}">
											<li class="page-item"><a class="page-link rounded-pill"
												href="index.do?pageNo=${indexPage.startPage - 5}">前へ</a></li>
										</c:if>

										<c:forEach var="pNo" begin="${indexPage.startPage}"
											end="${indexPage.endPage}">
											<li
												class="page-item ${pNo == indexPage.currentPage ? 'active' : ''}">
												<a class="page-link rounded-pill"
												href="index.do?pageNo=${pNo}">${pNo}</a>
											</li>
										</c:forEach>

										<c:if test="${indexPage.endPage < indexPage.totalPages}">
											<li class="page-item"><a class="page-link rounded-pill"
												href="index.do?pageNo=${indexPage.startPage + 5}">次へ</a></li>
										</c:if>
									</ul>
								</nav>
							</div>
						</td>
					</tr>
				</c:if>

			</tbody>
		</table>
	</div>
	<!-- ページネーション -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		
	<%if (request.getAttribute("registerSuccess") != null && (boolean) request.getAttribute("registerSuccess")) {%>
		$(document).ready(function() {
			$('#registerSuccessModal').modal('show');
		});
	<%}%>
		
	<%if (request.getAttribute("loginFail") != null && (boolean) request.getAttribute("loginFail")) {%>
		$(document).ready(function() {
			$('#loginFailModal').modal('show');
		});
	<%}%>
		
	</script>
	<jsp:include page="/WEB-INF/view/register.jsp" />
	<jsp:include page="/WEB-INF/includes/menuCanvas.jsp" />
	<script>
		
	<%if ("duplicate".equals(request.getAttribute("idCheckResult"))) {%>
		$(document).ready(function() {
			$('#duplicateModal').modal('show');
			$('#joinModal').modal('show'); // 회원가입 모달도 다시 띄움
		});
	<%} else if ("available".equals(request.getAttribute("idCheckResult"))) {%>
		$(document).ready(function() {
			$('#availableModal').modal('show');
			$('#joinModal').modal('show'); // 회원가입 모달도 다시 띄움
		});
	<%}%>
		
	</script>
</body>

<script type="text/javascript">
	$(document).ready(function() {
		setInterval(function() {
			location.href = "index.do";
		}, 30000); // ex) 300,000ms = 300초 = 5분
	});
</script>
</html>