<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品購入リクエスト</title>
</head>
<body>
	<!-- 購入リクエストモーダル -->
<div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="request.do" method="post">
        <div class="modal-header">
          <h5 class="modal-title" id="requestModalLabel">購入リクエスト</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="閉じる"></button>
        </div>

        <div class="modal-body">
          <div class="mb-3">
            <label for="id" class="form-label">数量</label>
            <input type="text" class="form-control" id="quantity" name="quantity" required>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">理由</label>
            <input type="password" class="form-control" id="reason" name="reason" required>
          </div>

          <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger mt-3" role="alert">
              <%= request.getAttribute("error") %>
            </div>
          <% } %>
        </div>

        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">リクエストを送信</button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>