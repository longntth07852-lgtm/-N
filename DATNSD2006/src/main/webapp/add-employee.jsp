<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm nhân viên</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
    <div class="navbar">
        <a href="EmployeeManagementServlet" style="color: #2196F3;">Quay lại danh sách</a>
        <span>Xin chào ${sessionScope.tenNV}! | <a href="LogoutServlet">Đăng xuất</a></span>
    </div>

    <div class="container" style="margin-top: 20px;">
        <h2 class="page-title">Thêm Nhân Viên Mới</h2>

        <div style="color: ${requestScope.message != null && requestScope.message.contains('LỖI') ? 'red' : 'green'}; font-weight: bold; margin-bottom: 15px; text-align: center; font-size: 16px;">
            ${requestScope.message}
        </div>

        <form action="AddEmployeeServlet" method="POST">
            <div class="detail-layout">
                <div class="form-section">
                    <h3 style="color: #2196F3; border-bottom: 2px solid #eee; padding-bottom: 8px; margin-bottom: 15px;">1. Thông tin đăng nhập</h3>

                    <div class="input-group full-width"><label>Username (Tên đăng nhập) <span style="color:red">*</span></label>
                        <input type="text" name="username" required>
                    </div>

                    <div class="input-group full-width"><label>Password (Mật khẩu) <span style="color:red">*</span></label>
                        <input type="password" name="password" required>
                    </div>

                    <div class="input-group full-width">
                        <label>Quyền hạn trên hệ thống <span style="color:red">*</span></label>
                        <select name="roleID" style="padding: 10px; width: 100%; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="2">EMPLOYEE (Nhân viên thường)</option>
                            <option value="1">MANAGER (Quản lý)</option>
                        </select>
                    </div>
                </div>

                <div class="form-section">
                    <h3 style="color: #2196F3; border-bottom: 2px solid #eee; padding-bottom: 8px; margin-bottom: 15px;">2. Thông tin cá nhân</h3>

                    <div class="input-group full-width"><label>Họ và tên <span style="color:red">*</span></label>
                        <input type="text" name="hoVaTen" required>
                    </div>

                    <div class="input-group"><label>Mã số CCCD <span style="color:red">*</span></label>
                        <input type="text" name="cccd" required>
                    </div>

                    <div class="input-group">
                        <label>Giới tính <span style="color:red">*</span></label>
                        <select name="gioiTinh" style="padding: 10px; width: 100%; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="1">Nam</option>
                            <option value="0">Nữ</option>
                        </select>
                    </div>

                    <div class="input-group"><label>Ngày sinh</label>
                        <input type="date" name="ngaySinh">
                    </div>

                    <div class="input-group"><label>Số điện thoại</label>
                        <input type="text" name="soDienThoai">
                    </div>

                    <div class="input-group full-width"><label>Email</label>
                        <input type="email" name="email">
                    </div>

                    <div class="input-group"><label>Quê quán</label>
                        <input type="text" name="queQuan">
                    </div>

                    <div class="input-group full-width"><label>Nơi thường trú</label>
                        <input type="text" name="noiThuongTru">
                    </div>
                </div>
            </div>

            <div style="text-align: center; margin-top: 25px; margin-bottom: 20px;">
                <button type="submit" class="btn" style="width: 350px; padding: 12px; font-size: 16px; font-weight: bold;">TẠO TÀI KHOẢN VÀ LƯU THÔNG TIN</button>
            </div>
        </form>
    </div>
</body>
</html>