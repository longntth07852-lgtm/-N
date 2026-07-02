<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
    <div class="login-wrapper">
        <h2 class="login-title">ĐĂNG NHẬP HỆ THỐNG</h2>
        <form action="LoginServlet" method="POST" class="login-form">
            <div class="form-row">
                <label>USERNAME</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-row">
                <label>PASSWORD</label>
                <input type="password" name="password" required>
            </div>

            <div class="error-msg" style="color: red; font-weight: bold; text-align: center; margin-top: 10px; min-height: 20px;">
                ${requestScope.errorMessage}
            </div>

            <div class="login-btn-container">
                <button type="submit" class="btn">ĐĂNG NHẬP</button>
            </div>
        </form>
    </div>
</body>
</html>