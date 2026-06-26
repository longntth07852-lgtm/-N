<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Tư Cách Đăng Nhập</title>
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

        .container {
            text-align: center;
        }

        .header {
            color: white;
            margin-bottom: 60px;
        }

        .header h1 {
            font-size: 42px;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .header p {
            font-size: 18px;
            opacity: 0.9;
        }

        .role-selection {
            display: flex;
            gap: 40px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .role-button {
            width: 280px;
            padding: 40px 30px;
            border: none;
            border-radius: 15px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            color: white;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .role-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
        }

        .role-button:active {
            transform: translateY(-2px);
        }

        .role-button.manager {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .role-button.manager:hover {
            background: linear-gradient(135deg, #5568d3 0%, #6a3d8f 100%);
        }

        .role-button.employee {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .role-button.employee:hover {
            background: linear-gradient(135deg, #e080e8 0%, #e24459 100%);
        }

        .icon {
            font-size: 50px;
        }

        .text {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .main-text {
            font-size: 22px;
            font-weight: 700;
        }

        .sub-text {
            font-size: 14px;
            opacity: 0.9;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏢 Hệ Thống Quản Lý Nhân Viên</h1>
            <p>Vui lòng chọn tư cách đăng nhập</p>
        </div>

        <div class="role-selection">
            <!-- Manager Button -->
            <a href="login.jsp?role=manager" class="role-button manager">
                <span class="icon">👨‍💼</span>
                <div class="text">
                    <span class="main-text">Quản Lý</span>
                    <span class="sub-text">Đăng nhập với tư cách Quản lý</span>
                </div>
            </a>

            <!-- Employee Button -->
            <a href="login.jsp?role=employee" class="role-button employee">
                <span class="icon">👤</span>
                <div class="text">
                    <span class="main-text">Nhân Viên</span>
                    <span class="sub-text">Đăng nhập với tư cách Nhân viên</span>
                </div>
            </a>
        </div>
    </div>
</body>
</html>
