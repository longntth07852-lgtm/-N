<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String hoTen = (String) session.getAttribute("hoTen");
    String tenDangNhap = (String) session.getAttribute("tenDangNhap");
    String soCCCD = (String) session.getAttribute("soCCCD");
    String ngayCap = (String) session.getAttribute("ngayCap");
    String noiCap = (String) session.getAttribute("noiCap");
    String ngaySinh = (String) session.getAttribute("ngaySinh");
    String gioiTinh = (String) session.getAttribute("gioiTinh");
    String diaChi = (String) session.getAttribute("diaChi");
    String tenRole = (String) session.getAttribute("tenRole");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Nhân Viên</title>
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
            transition: opacity 0.3s;
        }
        .navbar a:hover, .navbar button:hover {
            opacity: 0.8;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .profile-section {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .profile-section h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .profile-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        .info-item {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }
        .info-item label {
            display: block;
            font-weight: 600;
            color: #666;
            font-size: 12px;
            margin-bottom: 5px;
        }
        .info-item span {
            display: block;
            color: #333;
            font-size: 16px;
        }
        .message {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Hệ Thống Quản Lý Nhân Viên</h1>
        <div class="right">
            <span>Xin chào, <%= hoTen %> (<%= tenRole %>)</span>
            <form action="${pageContext.request.contextPath}/logout" method="POST" style="display: inline;">
                <button type="submit">Logout</button>
            </form>
        </div>
    </div>

    <div class="container">
        <%
            String error = request.getParameter("error");
            if (error != null && !error.isEmpty()) {
        %>
        <div class="error-message"><%= error %></div>
        <%
            }
        %>

        <div class="profile-section">
            <h2>Thông Tin Cá Nhân</h2>
            <p style="color: #666; margin-bottom: 20px;">Bạn đang đăng nhập như một nhân viên. Bạn chỉ có thể xem thông tin cá nhân của mình.</p>
            
            <div class="profile-info">
                <div class="info-item">
                    <label>Tên đăng nhập:</label>
                    <span><%= tenDangNhap %></span>
                </div>
                <div class="info-item">
                    <label>Họ tên:</label>
                    <span><%= hoTen %></span>
                </div>
                <div class="info-item">
                    <label>Vai trò:</label>
                    <span><%= tenRole %></span>
                </div>
                <div class="info-item">
                    <label>Số CCCD:</label>
                    <span><%= soCCCD %></span>
                </div>
                <div class="info-item">
                    <label>Ngày cấp CCCD:</label>
                    <span><%= ngayCap %></span>
                </div>
                <div class="info-item">
                    <label>Nơi cấp CCCD:</label>
                    <span><%= noiCap %></span>
                </div>
                <div class="info-item">
                    <label>Ngày sinh:</label>
                    <span><%= ngaySinh %></span>
                </div>
                <div class="info-item">
                    <label>Giới tính:</label>
                    <span><%= gioiTinh %></span>
                </div>
                <div class="info-item">
                    <label>Địa chỉ:</label>
                    <span><%= diaChi %></span>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
