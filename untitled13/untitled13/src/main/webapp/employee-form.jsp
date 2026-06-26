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
    <title>Biểu Mẫu Nhân Viên</title>
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
            max-width: 800px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            color: #333;
            margin-bottom: 25px;
            font-size: 24px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        button {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
            margin-right: 10px;
        }
        button:hover {
            transform: translateY(-2px);
        }
        .btn-secondary {
            background: #6c757d;
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
            <a href="${pageContext.request.contextPath}/manager-dashboard.jsp">Bảng Điều Khiển</a> / 
            <a href="${pageContext.request.contextPath}/employee?action=list">Quản Lý Nhân Viên</a> / 
            <c:choose>
                <c:when test="${not empty employee}">Sửa Nhân Viên</c:when>
                <c:otherwise>Thêm Nhân Viên</c:otherwise>
            </c:choose>
        </div>

        <div class="form-container">
            <h2>
                <c:choose>
                    <c:when test="${not empty employee}">Sửa Thông Tin Nhân Viên</c:when>
                    <c:otherwise>Thêm Nhân Viên Mới</c:otherwise>
                </c:choose>
            </h2>

            <form method="POST" action="${pageContext.request.contextPath}/employee">
                <input type="hidden" name="action" value="<c:choose><c:when test='${not empty employee}'>update</c:when><c:otherwise>add</c:otherwise></c:choose>">
                <c:if test="${not empty employee}">
                    <input type="hidden" name="maNhanVien" value="${employee.maNhanVien}">
                </c:if>

                <div class="form-row">
                    <div class="form-group">
                        <label for="hoTen">Họ Tên *</label>
                        <input type="text" id="hoTen" name="hoTen" value="${not empty employee ? employee.hoTen : ''}" required>
                    </div>
                    <div class="form-group">
                        <label for="tuoi">Tuổi *</label>
                        <input type="number" id="tuoi" name="tuoi" value="${not empty employee ? employee.tuoi : ''}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="maRole">Vai Trò *</label>
                        <select id="maRole" name="maRole" required>
                            <option value="">Chọn vai trò</option>
                            <option value="1" <c:if test="${not empty employee && employee.maRole == 1}">selected</c:if>>Quản Lý</option>
                            <option value="2" <c:if test="${not empty employee && employee.maRole == 2}">selected</c:if>>Nhân Viên</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="maTrangThai">Trạng Thái *</label>
                        <select id="maTrangThai" name="maTrangThai" required>
                            <option value="">Chọn trạng thái</option>
                            <option value="1" <c:if test="${not empty employee && employee.maTrangThai == 1}">selected</c:if>>Đang Hoạt Động</option>
                            <option value="2" <c:if test="${not empty employee && employee.maTrangThai == 2}">selected</c:if>>Nghỉ</option>
                        </select>
                    </div>
                </div>

                <div>
                    <button type="submit">
                        <c:choose>
                            <c:when test="${not empty employee}">Cập Nhật</c:when>
                            <c:otherwise>Thêm</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/employee?action=list" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
