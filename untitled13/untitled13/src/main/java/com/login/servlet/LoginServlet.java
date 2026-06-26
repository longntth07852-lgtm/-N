package com.login.servlet;

import com.login.dao.UserDAO;
import com.login.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");
        String role = request.getParameter("role");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.authenticateUser(tenDangNhap, matKhau);

        if (user != null && user.getTenRole() != null) {
            // Kiểm tra role phù hợp
            boolean roleMatches = false;
            if ("manager".equalsIgnoreCase(role) && "Quản lý".equalsIgnoreCase(user.getTenRole())) {
                roleMatches = true;
            } else if ("employee".equalsIgnoreCase(role) && "Nhân viên".equalsIgnoreCase(user.getTenRole())) {
                roleMatches = true;
            }

            if (roleMatches) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("maTaiKhoan", user.getMaTaiKhoan());
                session.setAttribute("tenDangNhap", user.getTenDangNhap());
                session.setAttribute("hoTen", user.getHoTen());
                session.setAttribute("soCCCD", user.getSoCCCD());
                session.setAttribute("ngayCap", user.getNgayCap());
                session.setAttribute("noiCap", user.getNoiCap());
                session.setAttribute("ngaySinh", user.getNgaySinh());
                session.setAttribute("gioiTinh", user.getGioiTinh());
                session.setAttribute("diaChi", user.getDiaChi());
                session.setAttribute("maRole", user.getMaRole());
                session.setAttribute("tenRole", user.getTenRole());

                if ("Quản lý".equalsIgnoreCase(user.getTenRole())) {
                    response.sendRedirect(request.getContextPath() + "/manager-dashboard.jsp");
                } else if ("Nhân viên".equalsIgnoreCase(user.getTenRole())) {
                    response.sendRedirect(request.getContextPath() + "/employee-dashboard.jsp");
                }
            } else {
                request.setAttribute("error", "Tài khoản này không phù hợp với tư cách đăng nhập đã chọn!");
                request.setAttribute("role", role);
                request.getRequestDispatcher("/login.jsp?role=" + role).forward(request, response);
            }
        } else {
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            request.setAttribute("role", role);
            request.getRequestDispatcher("/login.jsp?role=" + role).forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}

