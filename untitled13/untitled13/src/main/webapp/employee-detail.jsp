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
    <title>Chi Tiết Nhân Viên</title>
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
            max-width: 900px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        .detail-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .detail-container h2 {
            color: #333;
            margin-bottom: 25px;
            font-size: 24px;
        }
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }
        .detail-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
            border-left: 4px solid #667eea;
        }
        .detail-item label {
            display: block;
            font-weight: 600;
            color: #666;
            font-size: 12px;
            margin-bottom: 5px;
        }
        .detail-item span {
            display: block;
            color: #333;
            font-size: 16px;
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
            margin-right: 10px;
            transition: transform 0.2s;
            display: inline-block;
        }
        .btn:hover {
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
            Chi Tiết Nhân Viên
        </div>

        <div class="detail-container">
            <h2>Thông Tin Nhân Viên</h2>

            <c:choose>
                <c:when test="${not empty employee}">
                    <div class="detail-grid">
                        <div class="detail-item">
                            <label>Mã Nhân Viên:</label>
                            <span>${employee.maNhanVien}</span>
                        </div>
                        <div class="detail-item">
                            <label>Tên:</label>
                            <span>${employee.hoTen}</span>
                        </div>
                        <div class="detail-item">
                            <label>Tuổi:</label>
                            <span>${employee.tuoi}</span>
                        </div>
                        <div class="detail-item">
                            <label>Vai Trò:</label>
                            <span>${employee.tenRole}</span>
                        </div>
                        <div class="detail-item">
                            <label>Trạng Thái:</label>
                            <span>${employee.tenTrangThai}</span>
                        </div>
                    </div>

                    <div>
                        <a href="${pageContext.request.contextPath}/employee?action=edit&id=${employee.maNhanVien}" class="btn">Sửa</a>
                        <a href="${pageContext.request.contextPath}/employee?action=delete&id=${employee.maNhanVien}" class="btn btn-secondary" onclick="return confirm('Bạn chắc chắn muốn xóa nhân viên này?');">Xóa</a>
                        <a href="${pageContext.request.contextPath}/employee?action=list" class="btn btn-secondary">Quay Lại</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <p>Không tìm thấy nhân viên. <a href="${pageContext.request.contextPath}/employee?action=list">Quay lại danh sách</a></p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
