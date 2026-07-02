<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý nhân sự</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
    <div class="navbar">
        <a href="#">Quản lý sản phẩm</a>
        <a href="EmployeeManagementServlet" style="color: #2196F3;">Quản lý nhân sự</a>
        <span>Xin chào ${sessionScope.tenNV}! | <a href="LogoutServlet">Đăng xuất</a></span>
    </div>

    <div class="container">
        <div class="management-header">
            <div>
                <h2 class="page-title">Danh sách nhân viên</h2>
                <form action="EmployeeManagementServlet" method="POST" style="display:inline-block;">
                    <input type="text" name="searchQuery" class="search-box" placeholder="Tìm tên NV..." value="${param.searchQuery}">
                    <select name="statusFilter" class="search-box" style="width: 150px;">
                        <option value="">-- Tất cả trạng thái --</option>
                        <option value="1" ${param.statusFilter == '1' ? 'selected' : ''}>Hoạt động</option>
                        <option value="2" ${param.statusFilter == '2' ? 'selected' : ''}>Bị khóa / Nghỉ việc</option>
                    </select>
                    <button type="submit" class="btn" style="padding: 9px 15px;">Lọc</button>
                </form>
            </div>
            <div class="action-buttons">
                <% if("MANAGER".equals(session.getAttribute("role"))) { %>
                    <a href="EmployeeManagementServlet?statusFilter=2" class="btn" style="background-color: #ff9800; text-decoration:none; margin-right: 10px;">🔒 Danh sách bị khóa</a>
                    <a href="add-employee.jsp" class="btn" style="text-decoration:none;">Thêm nhân viên</a>
                <% } %>
            </div>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Mã NV</th>
                    <th>Tên NV</th>
                    <th>Ngày Sinh</th>
                    <th>Trạng thái</th>
                    <th>Lý do khóa tài khoản</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listNV}" var="nv">
                    <tr>
                        <td>NV-${nv.id}</td>
                        <td>${nv.ten}</td>
                        <td>${nv.ngaySinh}</td>
                        <td style="color: ${nv.trangThai == 'Hoạt động' ? 'green' : 'red'}; font-weight: bold;">${nv.trangThai}</td>

                        <td style="color: #c62828; font-style: italic; font-weight: 500;">${nv.lyDo}</td>

                        <td class="icon-action">
                            <a href="EmployeeDetailServlet?id=${nv.id}" title="Xem chi tiết" style="text-decoration:none; font-size: 20px;">
                                👁️ ✏️
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>