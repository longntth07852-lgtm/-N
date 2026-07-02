package Controller;

import connectService.connectService;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        connectService db = new connectService();

        try (Connection conn = db.myConnection()) {
            String sql = "SELECT t.Role_ID, r.Quyen, t.NhanVienID, nv.HoVaTen FROM TaiKhoan t " +
                    "INNER JOIN Role r ON t.Role_ID = r.Role_ID " +
                    "INNER JOIN NhanVien nv ON t.NhanVienID = nv.ID_NhanVien " +
                    "WHERE t.Username = ? AND t.Password = ? AND t.TrangThaiTK_ID = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("role", rs.getString("Quyen"));
                session.setAttribute("nhanVienID", rs.getInt("NhanVienID"));
                session.setAttribute("tenNV", rs.getString("HoVaTen"));
                session.setAttribute("username", user);

                if ("MANAGER".equals(rs.getString("Quyen"))) {
                    response.sendRedirect("EmployeeManagementServlet");
                } else {
                    response.sendRedirect("EmployeeDetailServlet?id=" + rs.getInt("NhanVienID"));
                }
            } else {

                String errorMsg = "Sai t\u00e0i kho\u00e1n, m\u1eadt kh\u1ea9u ho\u1eb7c TK b\u1ecb kh\u00f3a!";
                request.setAttribute("errorMessage", errorMsg);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}