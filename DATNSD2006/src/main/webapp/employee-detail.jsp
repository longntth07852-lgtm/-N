<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết nhân viên</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
    <div class="navbar">
        <% if("MANAGER".equals(session.getAttribute("role"))) { %>
            <a href="EmployeeManagementServlet" style="color: #2196F3;">Quay lại danh sách</a>
        <% } else { %>
            <span style="color: #2196F3; font-weight: bold;">Thông tin cá nhân</span>
        <% } %>
        <span>Xin chào ${sessionScope.tenNV}! | <a href="LogoutServlet">Đăng xuất</a></span>
    </div>

    <div class="container">
        <h2 class="page-title">Thông tin: ${nv.hoVaTen}</h2>

        <div style="color: ${requestScope.message != null && requestScope.message.contains('LỖI') ? 'red' : 'green'}; font-weight: bold; margin-bottom: 15px; text-align: center; font-size: 16px;">
            ${requestScope.message}
        </div>

        <div class="detail-layout">

            <div class="avatar-section">
                <div class="avatar-box"><span style="font-size: 80px; color: #2196F3;">👤</span></div>
                <div class="status-label">Trạng thái</div>
                <div class="status-box" style="${nv.trangThai == 'Hoạt động' ? 'color: green;' : 'color: red;'} font-weight: bold;">${nv.trangThai}</div>
            </div>

            <form action="UpdateEmployeeServlet" method="POST" class="form-section">
                <input type="hidden" name="idNhanVien" value="${nv.id}">
                <div class="input-group full-width"><label>Họ và tên</label>
                    <input type="text" name="hoVaTen" value="${nv.hoVaTen}" ${sessionScope.role == 'MANAGER' ? '' : 'readonly'} required>
                </div>
                <div class="input-group"><label>Mã nhân viên</label><input type="text" value="NV-${nv.id}" readonly></div>
                <div class="input-group"><label>Mã số CCCD</label><input type="text" value="${nv.cccd}" readonly></div>
                <div class="input-group"><label>Ngày sinh</label>
                    <input type="date" name="ngaySinh" value="${nv.ngaySinh}" ${sessionScope.role == 'MANAGER' ? '' : 'readonly'}>
                </div>
                <div class="input-group"><label>Số điện thoại</label>
                    <input type="text" name="soDienThoai" value="${nv.soDienThoai}" ${sessionScope.role == 'MANAGER' ? '' : 'readonly'}>
                </div>
                <div class="input-group full-width"><label>Email</label>
                    <input type="email" name="email" value="${nv.email}" ${sessionScope.role == 'MANAGER' ? '' : 'readonly'}>
                </div>
                <div class="input-group"><label>Quê quán</label>
                    <input type="text" name="queQuan" value="${nv.queQuan}" ${sessionScope.role == 'MANAGER' ? '' : 'readonly'}>
                </div>
                <div class="input-group full-width"><label>Nơi thường trú</label>
                    <input type="text" name="noiThuongTru" value="${nv.noiThuongTru}" ${sessionScope.role == 'MANAGER' ? '' : 'readonly'}>
                </div>

                <% if("MANAGER".equals(session.getAttribute("role"))) { %>
                    <div class="input-group full-width">
                        <label style="color: red; font-weight: bold;">* Lý do cập nhật thông tin cá nhân (Bắt buộc):</label>
                        <input type="text" name="lyDoThayDoi" placeholder="Nhập lý do chỉnh sửa..." required>
                    </div>
                    <div class="input-group full-width">
                        <button type="submit" class="btn">Lưu cập nhật thông tin</button>
                    </div>
                <% } %>
            </form>

            <div class="right-section">
                 <div class="info-card">
                    <div class="info-row"><span>Tài khoản:</span><span style="font-weight: bold;">${nv.username}</span></div>
                    <div class="info-row"><span>Ngày tạo:</span><span>${nv.ngayTao}</span></div>
                 </div>

                 <% if("MANAGER".equals(session.getAttribute("role"))) { %>
                     <form action="ToggleEmployeeStatusServlet" method="POST" style="margin-top: 20px; background: #fff3f3; padding: 15px; border-radius: 8px; border: 1px solid #ffcdd2;">
                         <input type="hidden" name="idNhanVien" value="${nv.id}">
                         <input type="hidden" name="currentStatus" value="${nv.trangThai == 'Hoạt động' ? '1' : '2'}">

                         <div style="margin-bottom: 10px;">
                             <label style="color: ${nv.trangThai == 'Hoạt động' ? 'red' : 'green'}; font-weight: bold; display: block; margin-bottom: 5px;">
                                 * Nhập lý do thay đổi trạng thái:
                             </label>
                             <input type="text" name="lyDoThayDoi" placeholder="${nv.trangThai == 'Hoạt động' ? 'Bắt buộc nhập lý do khóa...' : 'Bấm nút dưới để mở khóa...'}" style="width: 100%; padding: 8px; box-sizing: border-box;">
                         </div>

                         <button type="submit" class="btn" style="width: 100%; font-weight: bold; background-color: ${nv.trangThai == 'Hoạt động' ? '#f44336' : '#4CAF50'};"
                                 onclick="return confirm('Xác nhận thay đổi trạng thái tài khoản này?');">
                             ${nv.trangThai == 'Hoạt động' ? '🔒 KHÓA TÀI KHOẢN' : '🔓 MỞ KHÓA TÀI KHOẢN'}
                         </button>
                     </form>
                 <% } %>
            </div>
        </div>
    </div>
</body>
</html>