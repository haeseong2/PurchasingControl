<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  String userRole = (String) session.getAttribute("userRole");
%>
<div class="offcanvas offcanvas-end" tabindex="-1" id="menuCanvas" aria-labelledby="menuCanvasLabel">
  <div class="offcanvas-header">
    <h5 id="menuCanvasLabel">카테고리</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body">
<ul class="list-group">
  <% if ("0".equals(userRole)) { %>
    <!-- 관리자 전용 메뉴 -->
    <li class="list-group-item"><a href="requestAdmin.do">구매요청관리</a></li>
    <li class="list-group-item"><a href="#">제품등록</a></li>
    <li class="list-group-item"><a href="#">발주</a></li>
  <% } else { %>
    <!-- 일반 사용자 메뉴 -->
    <li class="list-group-item"><a href="list.do">제품</a></li>
    <li class="list-group-item"><a href="requestcheck.do">구매요청목록</a></li>
  <% } %>
</ul>
  </div>
</div>