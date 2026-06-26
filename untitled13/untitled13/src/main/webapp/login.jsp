<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String role = request.getParameter("role");
    if (role == null || (!"manager".equals(role) && !"employee".equals(role))) {
        response.sendRedirect("index.jsp");
        return;
    }
    String roleTitle = "manager".equals(role) ? "Quản Lý" : "Nhân Viên";
    String roleIcon = "manager".equals(role) ? "👨‍💼" : "👤";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập <%= roleTitle %> - Hệ Thống Quản Lý Nhân Viên</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 450px;
        }
        .role-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
            width: 100%;
        }
        .role-badge.manager {
            background: #d4edda;
            color: #155724;
        }
        .role-badge.employee {
            background: #d1ecf1;
            color: #0c5460;
        }
        .login-container h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
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
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
        }
        button.submit-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
        }
        button.submit-btn:hover {
            transform: translateY(-2px);
        }
        button.submit-btn:active {
            transform: translateY(0);
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            display: none;
        }
        .error-message.show {
            display: block;
        }
        .back-link {
            text-align: center;
            margin-top: 20px;
        }
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="role-badge <%= role %>">
            <%= roleIcon %> Đăng Nhập với tư cách <%= roleTitle %>
        </div>
        
        <h1>🔐 Đăng Nhập</h1>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="error-message show"><%= error %></div>
        <% 
            }
        %>

        <form method="POST" action="${pageContext.request.contextPath}/login">
            <input type="hidden" name="role" value="<%= role %>">
            
            <div class="form-group">
                <label for="tenDangNhap">Tên đăng nhập</label>
                <input type="text" id="tenDangNhap" name="tenDangNhap" placeholder="Nhập tên đăng nhập" required autofocus>
            </div>

            <div class="form-group">
                <label for="matKhau">Mật khẩu</label>
                <input type="password" id="matKhau" name="matKhau" placeholder="Nhập mật khẩu" required>
            </div>

            <button type="submit" class="submit-btn">Đăng Nhập</button>
        </form>

        <div class="back-link">
            <a href="index.jsp">← Quay lại chọn tư cách</a>
        </div>
    </div>
</body>
</html>
