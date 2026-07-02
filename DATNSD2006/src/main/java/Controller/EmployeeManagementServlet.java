package Controller;

import connectService.connectService;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/EmployeeManagementServlet")
public class EmployeeManagementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String q = request.getParameter("searchQuery");
        String status = request.getParameter("statusFilter");
        List<Map<String, String>> list = new ArrayList<>();
        connectService db = new connectService();

        try (Connection conn = db.myConnection()) {

            String sql = "SELECT n.ID_NhanVien, n.HoVaTen, n.NgaySinh, tt.TenTrangThai, n.LyDoKhoa FROM NhanVien n " +
                    "INNER JOIN TrangThaiNhanVien tt ON n.TrangThaiNV_ID = tt.TrangThaiNV_ID " +
                    "WHERE n.HoVaTen != N'Admin' ";

            if (q != null && !q.trim().isEmpty()) sql += "AND n.HoVaTen LIKE ? ";
            if (status != null && !status.trim().isEmpty()) sql += "AND n.TrangThaiNV_ID = ? ";

            PreparedStatement ps = conn.prepareStatement(sql);
            int idx = 1;
            if (q != null && !q.trim().isEmpty()) ps.setString(idx++, "%" + q.trim() + "%");
            if (status != null && !status.trim().isEmpty()) ps.setInt(idx++, Integer.parseInt(status));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, String> m = new HashMap<>();
                m.put("id", rs.getString("ID_NhanVien"));
                m.put("ten", rs.getString("HoVaTen"));
                m.put("ngaySinh", rs.getString("NgaySinh") != null ? rs.getString("NgaySinh") : "Ch\u01b0a c\u1eadp nh\u1eadt");
                m.put("trangThai", rs.getString("TenTrangThai"));

                String lyDo = rs.getString("LyDoKhoa");
                m.put("lyDo", (lyDo != null && !lyDo.trim().isEmpty()) ? lyDo : "-");

                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("listNV", list);
        request.getRequestDispatcher("employee-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        doGet(request, response);
    }
}