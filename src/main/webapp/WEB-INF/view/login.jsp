<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String userStatus = (String) session.getAttribute("user_status");
  if (userStatus == null) userStatus = "U"; // 기본은 일반 사용자
%>

<!-- 상단 네비게이션 버튼 -->
<nav class="navbar navbar-light bg-light">
  <div class="container-fluid justify-content-end">
    <button class="btn btn-outline-secondary" type="button" data-bs-toggle="modal" data-bs-target="#menuModal">
      <i class="bi bi-list"></i>
    </button>
  </div>
</nav>

<!-- 메뉴 모달 -->
<div class="modal fade" id="menuModal" tabindex="-1" aria-labelledby="menuModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="menuModalLabel">메뉴</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <ul class="list-group">
          <li class="list-group-item"><a href="#">제품</a></li>
          <li class="list-group-item"><a href="#">요청</a></li>
          <% if ("A".equals(userStatus)) { %>
          <li class="list-group-item"><a href="#">요청승인</a></li>
          <li class="list-group-item"><a href="#">발주</a></li>
          <% } %>
        </ul>
      </div>
    </div>
  </div>
</div>

<!-- login.jsp -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
  <form action="login" method="post">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="loginModalLabel">로그인</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="loginMid" class="form-label">아이디</label>
            <input type="text" class="form-control" id="loginMid" name="mid" required>
          </div>
          <div class="mb-3">
            <label for="loginMpw" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="loginMpw" name="mpw" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary w-100">로그인</button>
        </div>
      </div>
    </div>
  </form>
</div>