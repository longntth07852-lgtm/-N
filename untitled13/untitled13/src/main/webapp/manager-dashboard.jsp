<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String hoTen = (String) session.getAttribute("hoTen");
    String username = (String) session.getAttribute("tenDangNhap");
    String soCCCD = (String) session.getAttribute("soCCCD");
    String ngayCap = (String) session.getAttribute("ngayCap");
    String noiCap = (String) session.getAttribute("noiCap");
    String ngaySinh = (String) session.getAttribute("ngaySinh");
    String gioiTinh = (String) session.getAttribute("gioiTinh");
    String diaChi = (String) session.getAttribute("diaChi");
    String roleName = (String) session.getAttribute("tenRole");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager Bảng Điều Khiển - Employee Management</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px 20px;
        }
        .Bảng Điều Khiển-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        .card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .card h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
        }
        .card p {
            color: #666;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .card a {
            display: inline-block;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: transform 0.2s;
        }
        .card a:hover {
            transform: translateY(-2px);
        }
        .profile-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        .profile-section h2 {
            color: #333;
            margin-bottom: 15px;
        }
        .profile-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        .info-item {
            padding: 10px;
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
    </style>
</head>
<body>
    <div class="navbar">
        <h1>Hệ Thống Quản Lý Nhân Viên</h1>
        <div class="right">
            <span>Xin chào, <%= hoTen %> (<%= roleName %>)</span>
            <form action="${pageContext.request.contextPath}/logout" method="POST" style="display: inline;">
                <button type="submit">Logout</button>
            </form>
        </div>
    </div>

    <div class="container">
        <div class="profile-section">
            <h2>Thông Tin Cá Nhân</h2>
            <div class="profile-info">

                <div class="info-item">
                    <label>Họ tên:</label>
                    <span><%= hoTen %></span>
                </div>

                <div class="info-item">
                    <label>Tên đăng nhập:</label>
                    <span><%= username %></span>
                </div>

                <div class="info-item">
                    <label>Số CCCD:</label>
                    <span><%= soCCCD %></span>
                </div>

                <div class="info-item">
                    <label>Ngày cấp:</label>
                    <span><%= ngayCap %></span>
                </div>

                <div class="info-item">
                    <label>Nơi cấp:</label>
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

                <div class="info-item">
                    <label>Vai trò:</label>
                    <span><%= roleName %></span>
                </div>

            </div>
        </div>

        <h2 style="color: #333; margin-bottom: 20px;">Bảng Điều Khiển</h2>
        <div class="Bảng Điều Khiển-grid">
            <div class="card">
                <h2>👥 Quản Lý Nhân Viên</h2>
                <p>Xem, thêm, sửa và xóa thông tin nhân viên</p>
                <a href="${pageContext.request.contextPath}/employee?action=list">Đi tới quản lý</a>
            </div>
        </div>
    </div>
</body>
</html>
