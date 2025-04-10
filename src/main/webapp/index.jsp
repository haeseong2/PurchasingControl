<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>구매관리 시스템</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container text-center mt-5">
  <h1>구매관리 시스템</h1>

  <% 
    String username = (String) session.getAttribute("user");
    if (username == null) {
  %>
    <button class="btn btn-primary me-2" onclick="$('#loginModal').modal('show')">로그인</button>
    <button class="btn btn-success" onclick="$('#joinModal').modal('show')">회원가입</button>
  <%
    } else {
  %>
    <p><strong><%= username %></strong> 님 환영합니다.</p>
    <a href="logout.do" class="btn btn-danger">로그아웃</a>
  <%
    }
  %>
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
        <h5 class="modal-title" id="registerSuccessModalLabel">회원가입 성공  </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        회원가입이 완료되었습니다.
      </div>
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
      <div class="modal-body">
        아이디 또는 비밀번호가 일치하지 않습니다.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // 회원가입 성공 시 모달 띄우기
  <% if (request.getAttribute("registerSuccess") != null && (boolean) request.getAttribute("registerSuccess")) { %>
    $(document).ready(function() {
        $('#registerSuccessModal').modal('show'); // 회원가입 성공 모달
    });
  <% } %>

  // 로그인 실패 시 모달 띄우기
  <% if (request.getAttribute("loginFail") != null && (boolean) request.getAttribute("loginFail")) { %>
    $(document).ready(function() {
        $('#loginFailModal').modal('show'); // 로그인 실패 모달
    });
  <% } %>
</script>

</body>
</html>
