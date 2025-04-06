<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!-- register.jsp -->
<div class="modal fade" id="joinModal" tabindex="-1" aria-labelledby="joinModalLabel" aria-hidden="true">
  <form action="register" method="post" onsubmit="return memberCheck()">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="joinModalLabel">회원가입</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label for="joinMid" class="form-label">아이디</label>
            <input type="text" class="form-control" id="joinMid" name="mid" required>
          </div>
          <div class="mb-3">
            <label for="joinMpw" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="joinMpw" name="mpw" required>
          </div>
          <div class="mb-3">
            <label for="joinMpwCheck" class="form-label">비밀번호 확인</label>
            <input type="password" class="form-control" id="joinMpwCheck" required>
          </div>
          <div class="mb-3">
            <label for="joinMname" class="form-label">이름</label>
            <input type="text" class="form-control" id="joinMname" name="mname" required>
          </div>
          <div class="mb-3">
            <label for="joinMtel" class="form-label">전화번호</label>
            <input type="text" class="form-control" id="joinMtel" name="mtel" required>
          </div>
          <div class="mb-3">
            <label for="joinMemail" class="form-label">이메일</label>
            <input type="email" class="form-control" id="joinMemail" name="memail" required>
          </div>
          <div class="mb-3">
            <label for="joinBirth" class="form-label">생년월일</label>
            <input type="date" class="form-control" id="joinBirth" name="mbirth" required>
          </div>
          <div class="mb-3">
            <label for="userStatus" class="form-label">권한 선택</label>
            <select class="form-select" id="userStatus" name="user_status" required>
              <option value="U" selected>일반 사용자</option>
              <option value="A">관리자</option>
            </select>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-success w-100">회원가입</button>
        </div>
      </div>
    </div>
  </form>
</div>

<!-- Bootstrap Icons CDN (for hamburger icon) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<script>
function memberCheck() {
  const pw = document.getElementById("joinMpw").value;
  const pwCheck = document.getElementById("joinMpwCheck").value;
  if (pw !== pwCheck) {
    alert("비밀번호가 일치하지 않습니다.");
    return false;
  }
  return true;
}
</script>