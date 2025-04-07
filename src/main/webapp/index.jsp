<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>ERP 로그인</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container text-center mt-5">
  <h1>ERP 시스템</h1>
  <button class="btn btn-primary me-2" onclick="$('#loginModal').modal('show')">로그인</button>
  <button class="btn btn-success" onclick="$('#joinModal').modal('show')">회원가입</button>
    <button class="btn btn-success" onclick="$('#joinModal').modal('show')">정해성</button>  
</div>

<!-- 로그인/회원가입 모달 include -->
<jsp:include page="/WEB-INF/view/login.jsp" />
<jsp:include page="/WEB-INF/view/register.jsp" />

<!-- jQuery + Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
