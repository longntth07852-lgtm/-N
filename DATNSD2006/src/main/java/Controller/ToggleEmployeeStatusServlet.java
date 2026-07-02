package Controller;

import connectService.connectService;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ToggleEmployeeStatusServlet")
public class ToggleEmployeeStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("idNhanVien");
        String currentStatus = request.getParameter("currentStatus");
        String lyDo = request.getParameter("lyDoThayDoi");

        int newStatus = 1;

        if ("1".equals(currentStatus)) {
            newStatus = 2; // Hành động: KHÓA
            if (lyDo == null || lyDo.trim().isEmpty()) {
                request.setAttribute("message", "L\u1ed2I: B\u1eaft bu\u1ed9c ph\u1ea3i nh\u1eadp L\u00fd do khi kh\u00f3a t\u00e0i kho\u1ea3n!");
                request.getRequestDispatcher("EmployeeDetailServlet?id=" + id).forward(request, response);
                return;
            }
        } else {
            newStatus = 1; // Hành động: MỞ KHÓA
            lyDo = ""; // Mở khóa thì xóa trắng lý do cũ
        }

        connectService db = new connectService();
        try (Connection conn = db.myConnection()) {
            conn.setAutoCommit(false);


            String sqlNV = "UPDATE NhanVien SET TrangThaiNV_ID = ?, NgayCapNhat = GETDATE(), LyDoKhoa = ? WHERE ID_NhanVien = ?";
            PreparedStatement psNV = conn.prepareStatement(sqlNV);
            psNV.setInt(1, newStatus);
            psNV.setString(2, lyDo);
            psNV.setString(3, id);
            psNV.executeUpdate();


            String sqlTK = "UPDATE TaiKhoan SET TrangThaiTK_ID = ? WHERE NhanVienID = ?";
            PreparedStatement psTK = conn.prepareStatement(sqlTK);
            psTK.setInt(1, newStatus);
            psTK.setInt(2, Integer.parseInt(id));
            psTK.executeUpdate();

            conn.commit();
            request.setAttribute("message", newStatus == 2 ? " \u0110\u00e3 kh\u00f3a t\u00e0i kho\u1ea3n nh\u00e2n vi\u00ean!" : "M\u1edf kh\u00f3a t\u00e0i kho\u1ea3n th\u00e0nh c\u00f4ng!");
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("EmployeeDetailServlet?id=" + id).forward(request, response);
    }
}