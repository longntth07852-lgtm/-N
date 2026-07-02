package Controller;

import connectService.connectService;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateEmployeeServlet")
public class UpdateEmployeeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("idNhanVien");
        String lyDo = request.getParameter("lyDoThayDoi");
        String sdt = request.getParameter("soDienThoai");
        String email = request.getParameter("email");

        if (lyDo == null || lyDo.trim().isEmpty()) {
            request.setAttribute("message", "LỖI: Bắt buộc phải nhập Lý do thay đổi thông tin!");
            request.getRequestDispatcher("EmployeeDetailServlet?id=" + id).forward(request, response);
            return;
        }

        connectService db = new connectService();
        try (Connection conn = db.myConnection()) {


            String sqlCheck = "SELECT ID_NhanVien FROM NhanVien WHERE ID_NhanVien != ? AND ( (SoDienThoai = ? AND LEN(SoDienThoai) > 0) OR (Email = ? AND LEN(Email) > 0) )";
            PreparedStatement psCheck = conn.prepareStatement(sqlCheck);
            psCheck.setString(1, id);
            psCheck.setString(2, sdt != null ? sdt : "");
            psCheck.setString(3, email != null ? email : "");

            if (psCheck.executeQuery().next()) {
                request.setAttribute("message", "LỖI:so dien thoai hoac email da thuoc ve nguoi khac!");
                request.getRequestDispatcher("EmployeeDetailServlet?id=" + id).forward(request, response);
                return;
            }


            String sql = "UPDATE NhanVien SET HoVaTen=?, NgaySinh=?, SoDienThoai=?, Email=?, QueQuan=?, NoiThuongTru=?, NgayCapNhat=GETDATE() WHERE ID_NhanVien=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, request.getParameter("hoVaTen"));

            String ns = request.getParameter("ngaySinh");
            if (ns == null || ns.trim().isEmpty()) ps.setNull(2, java.sql.Types.DATE);
            else ps.setString(2, ns);

            ps.setString(3, sdt);
            ps.setString(4, email);
            ps.setString(5, request.getParameter("queQuan"));
            ps.setString(6, request.getParameter("noiThuongTru"));
            ps.setString(7, id);
            ps.executeUpdate();


            request.setAttribute("message", "C\u1eadp nh\u1eadt th\u00e0nh c\u00f4ng! (Ghi nh\u1eadn l\u00fd do: " + lyDo + ")");
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("EmployeeDetailServlet?id=" + id).forward(request, response);
    }
}