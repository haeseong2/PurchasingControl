<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공급업체 관리</title>
</head>
<body>
    <h2>🏢 공급업체 관리</h2>

    <!-- 📋 공급업체 목록 -->
    <h3>📋 공급업체 목록</h3>
    <table border="1">
        <tr>
            <th>공급업체 ID</th>
            <th>이름</th>
            <th>연락처</th>
            <th>주소</th>
            <th>관리</th>
        </tr>
        <c:forEach var="supplier" items="${supplierList}">
            <tr>
                <td>${supplier.id}</td>
                <td>${supplier.name}</td>
                <td>${supplier.contact}</td>
                <td>${supplier.address}</td>
                <td>
                    <!-- 삭제 버튼 -->
                    <form action="supplier/delete" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${supplier.id}">
                        <button type="submit">삭제</button>
                    </form>

                    <!-- 수정 버튼 -->
                    <form action="updateForm" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="${supplier.id}">
                        <button type="submit">수정</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- ✅ 공급업체 등록 폼 -->
    <h3>✅ 새로운 공급업체 등록</h3>
    <form action="supplier/insert" method="post">
        <label>이름: <input type="text" name="name" required></label>
        <label>연락처: <input type="text" name="contact" required></label>
        <label>주소: <input type="text" name="address" required></label>
        <button type="submit">등록</button>
    </form>
</body>
</html>