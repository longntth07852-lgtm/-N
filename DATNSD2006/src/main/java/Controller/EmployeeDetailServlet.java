package Controller;

import connectService.connectService;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EmployeeDetailServlet")
public class EmployeeDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Map<String, String> nv = new HashMap<>();
        connectService db = new connectService();

        try (Connection conn = db.myConnection()) {
            String sql = "SELECT n.*, t.Username, tt.TenTrangThai FROM NhanVien n " +
                    "INNER JOIN TaiKhoan t ON n.TaiKhoanID = t.TaiKhoanID " +
                    "INNER JOIN TrangThaiNhanVien tt ON n.TrangThaiNV_ID = tt.TrangThaiNV_ID WHERE n.ID_NhanVien = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                nv.put("id", id);
                nv.put("hoVaTen", rs.getString("HoVaTen"));
                nv.put("cccd", rs.getString("MaSoCCCD"));
                nv.put("ngaySinh", rs.getString("NgaySinh"));
                nv.put("email", rs.getString("Email"));
                nv.put("soDienThoai", rs.getString("SoDienThoai"));
                nv.put("queQuan", rs.getString("QueQuan"));
                nv.put("noiThuongTru", rs.getString("NoiThuongTru"));
                nv.put("trangThai", rs.getString("TenTrangThai"));
                nv.put("username", rs.getString("Username"));
                nv.put("ngayTao", rs.getString("NgayTao"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("nv", nv);
        request.getRequestDispatcher("employee-detail.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        doGet(request, response);
    }
}