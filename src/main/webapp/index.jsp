<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>구매관리 시스템</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .offcanvas-end {
      width: 260px;
    }
  </style>
</head>
<body>

<div class="container text-center mt-5">
  <h1>구매관리 시스템</h1>

  <%
    String username = (String) session.getAttribute("user");
    String userRole = (String) session.getAttribute("userRole"); // "0" = 관리자, "1" = 사용자
    System.out.println(userRole);
    if (username == null) {
  %>
    <button class="btn btn-primary me-2" onclick="$('#loginModal').modal('show')">로그인</button>
    <button class="btn btn-success" onclick="$('#joinModal').modal('show')">회원가입</button>
  <%
    } else {
  %>
    <p><strong><%= username %></strong> 님 환영합니다.</p>
    <a href="logout.do" class="btn btn-danger">로그아웃</a>
    <button class="btn btn-outline-secondary ms-2" data-bs-toggle="offcanvas" data-bs-target="#menuCanvas">
      ☰ 카테고리
    </button>
  <%
    }
  %>
</div>

<!-- 사이드 메뉴 -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="menuCanvas" aria-labelledby="menuCanvasLabel">
  <div class="offcanvas-header">
    <h5 id="menuCanvasLabel">카테고리</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
<ul class="list-group">
  <% if ("0".equals(userRole)) { %>
    <!-- 관리자 전용 메뉴 -->
    <li class="list-group-item"><a href="approval.do">승인관리</a></li>
    <li class="list-group-item"><a href="order.do">발주</a></li>
    <li class="list-group-item"><a href="refund.do">환불</a></li>
  <% } else { %>
    <!-- 일반 사용자 메뉴 -->
    <li class="list-group-item"><a href="list.do">제품</a></li>
    <li class="list-group-item"><a href="request.do">요청</a></li>
  <% } %>
</ul>
  </div>
</div>

<!-- 로그인 모달 -->
<jsp:include page="/WEB-INF/view/login.jsp" />

<!-- 회원가입 모달 -->
<jsp:include page="/WEB-INF/view/register.jsp" />

<!-- 회원가입 성공 모달 -->
<div class="modal fade" id="registerSuccessModal" tabindex="-1" aria-labelledby="registerSuccessModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="registerSuccessModalLabel">회원가입 성공</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">회원가입이 완료되었습니다.</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <a href="login.jsp" class="btn btn-primary">로그인</a>
      </div>
    </div>
  </div>
</div>

<!-- 로그인 실패 모달 -->
<div class="modal fade" id="loginFailModal" tabindex="-1" aria-labelledby="loginFailModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginFailModalLabel">로그인 실패</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">아이디 또는 비밀번호가 일치하지 않습니다.</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<!-- 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  <% if (request.getAttribute("registerSuccess") != null && (boolean) request.getAttribute("registerSuccess")) { %>
    $(document).ready(function () {
      $('#registerSuccessModal').modal('show');
    });
  <% } %>

  <% if (request.getAttribute("loginFail") != null && (boolean) request.getAttribute("loginFail")) { %>
    $(document).ready(function () {
      $('#loginFailModal').modal('show');
    });
  <% } %>
</script>

</body>
</html>

