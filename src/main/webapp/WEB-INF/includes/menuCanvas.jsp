<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  String userRole = (String) session.getAttribute("userRole");
%>
<div class="offcanvas offcanvas-end" tabindex="-1" id="menuCanvas" aria-labelledby="menuCanvasLabel">
  <div class="offcanvas-header">
    <h5 id="menuCanvasLabel">カテゴリー</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
<ul class="list-group">
  <% if ("0".equals(userRole)) { %>
    <!-- 管理者専用メニュー -->
    <li class="list-group-item"><a href="requestAdmin.do">購入リクエスト管理</a></li>
    <li class="list-group-item"><a href="addProduct.do">商品登録</a></li>
  <% } else { %>
    <!-- 一般ユーザーメニュー -->
    <li class="list-group-item"><a href="list.do">商品</a></li>
    <li class="list-group-item"><a href="requestcheck.do">購入リクエスト一覧</a></li>
  <% } %>
</ul>
  </div>
</div>