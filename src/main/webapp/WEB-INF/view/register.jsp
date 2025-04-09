<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 회원가입 모달 -->
<div class="modal fade" id="joinModal" tabindex="-1" aria-labelledby="joinModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="register.do" method="post">
        <div class="modal-header">
          <h5 class="modal-title" id="joinModalLabel">회원가입</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body">
          <div class="mb-3">
            <label for="id" class="form-label">아이디</label>
            <input type="text" class="form-control" id="id" name="id" required>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" required>
          </div>
          <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" class="form-control" id="name" name="name" required>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <input type="email" class="form-control" id="email" name="email" required>
          </div>
          <div class="mb-3">
            <label for="role" class="form-label">권한 (예: 사용자, 관리자)</label>
            <input type="text" class="form-control" id="role" name="role" required>
          </div>
          <div class="mb-3">
            <label for="department" class="form-label">부서명</label>
            <input type="text" class="form-control" id="department" name="department">
          </div>

          <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger mt-3" role="alert">
              <%= request.getAttribute("error") %>
            </div>
          <% } %>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">가입하기</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- 회원가입 성공 모달 -->
<div class="modal fade" id="registerSuccessModal" tabindex="-1" aria-labelledby="registerSuccessModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="registerSuccessModalLabel">회원가입 성공</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <p>회원가입이 성공적으로 완료되었습니다!</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
