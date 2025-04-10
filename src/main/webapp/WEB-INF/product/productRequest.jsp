<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품구매요청</title>
</head>
<body>
	<!-- 구매요청 모달 -->
<div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="request.do" method="post">
        <div class="modal-header">
          <h5 class="modal-title" id="requestModalLabel">구매요청</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body">
          <div class="mb-3">
            <label for="id" class="form-label">수량</label>
            <input type="text" class="form-control" id="quantity" name="quantity" required>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">사유</label>
            <input type="password" class="form-control" id="reason" name="reason" required>
          </div>

          <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger mt-3" role="alert">
              <%= request.getAttribute("error") %>
            </div>
          <% } %>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">요청하기</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>