<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Object maRoleObj = session.getAttribute("maRole");
    if (maRoleObj == null || !maRoleObj.toString().equals("1")) {
        response.sendRedirect(request.getContextPath() + "/employee-dashboard.jsp?error=Từ chối truy cập");
        return;
    }
    String hoTen = (String) session.getAttribute("hoTen");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Nhân Viên</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar h1 {
            font-size: 24px;
        }
        .navbar .right {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        .navbar a, .navbar button {
            color: white;
            text-decoration: none;
            font-size: 14px;
            background: none;
            border: none;
            cursor: pointer;
        }
        .navbar a:hover, .navbar button:hover {
            opacity: 0.8;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .header h2 {
            color: #333;
            font-size: 28px;
        }
        .btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            transition: transform 0.2s;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .message {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        table thead {
            background: #f8f9fa;
        }
        table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #dee2e6;
        }
        table td {
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
        }
        table tbody tr:hover {
            background: #f8f9fa;
        }
        .action-links {
            display: flex;
            gap: 10px;
        }
        .action-links a {
            padding: 6px 12px;
            font-size: 12px;
            border-radius: 3px;
            text-decoration: none;
            color: white;
        }
        .action-links .btn-edit {
            background: #28a745;
        }
        .action-links .btn-view {
            background: #17a2b8;
        }
        .action-links .btn-delete {
            background: #dc3545;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }
        .breadcrumb {
            margin-bottom: 20px;
        }
        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
        }
        .breadcrumb a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Hệ Thống Quản Lý Nhân Viên</h1>
        <div class="right">
            <span>Xin chào, <%= hoTen %></span>
            <a href="${pageContext.request.contextPath}/manager-dashboard.jsp">Bảng Điều Khiển</a>
            <form action="${pageContext.request.contextPath}/logout" method="POST" style="display: inline;">
                <button type="submit">Đăng Xuất</button>
            </form>
        </div>
    </div>

    <div class="container">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/manager-dashboard.jsp">Bảng Điều Khiển</a> / Quản Lý Nhân Viên
        </div>

        <% String success = request.getParameter("success");
           if (success != null && !success.isEmpty()) { %>
        <div class="message"><%= success %></div>
        <% } %>

        <% String error = request.getParameter("error");
           if (error != null && !error.isEmpty()) { %>
        <div class="error-message"><%= error %></div>
        <% } %>

        <div class="header">
            <h2>Danh Sách Nhân Viên</h2>
            <a href="${pageContext.request.contextPath}/employee?action=edit" class="btn">+ Thêm Nhân Viên</a>
        </div>

        <c:choose>
            <c:when test="${not empty employees}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Tuổi</th>
                            <th>Vai Trò</th>
                            <th>Trạng Thái</th>
                            <th>Hành Động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="emp" items="${employees}">
                        <tr>
                            <td>${emp.maNhanVien}</td>
                            <td>${emp.hoTen}</td>
                            <td>${emp.tuoi}</td>
                            <td>${emp.tenRole}</td>
                            <td>${emp.tenTrangThai}</td>
                            <td>
                                <div class="action-links">
                                    <a href="${pageContext.request.contextPath}/employee?action=view&id=${emp.maNhanVien}" class="btn-view">Xem</a>
                                    <a href="${pageContext.request.contextPath}/employee?action=edit&id=${emp.maNhanVien}" class="btn-edit">Sửa</a>
                                    <a href="${pageContext.request.contextPath}/employee?action=delete&id=${emp.maNhanVien}" class="btn-delete" onclick="return confirm('Bạn chắc chắn muốn xóa?');">Xóa</a>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-data">
                    <p>Không có nhân viên nào. <a href="${pageContext.request.contextPath}/employee?action=edit">Thêm ngay bây giờ</a></p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
