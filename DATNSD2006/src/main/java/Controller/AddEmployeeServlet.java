package Controller;

import connectService.connectService;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String cccd = request.getParameter("cccd");
        String sdt = request.getParameter("soDienThoai");
        String email = request.getParameter("email");

        connectService db = new connectService();
        try (Connection conn = db.myConnection()) {


            PreparedStatement psCheckUser = conn.prepareStatement("SELECT TaiKhoanID FROM TaiKhoan WHERE Username = ?");
            psCheckUser.setString(1, username);
            if (psCheckUser.executeQuery().next()) {
                request.setAttribute("message", "L\u1ed2I: Username '" + username + "' \u0111\u00e3 c\u00f3 ng\u01b0\u1eddi s\u1eed d\u1ee5ng!");
                request.getRequestDispatcher("add-employee.jsp").forward(request, response);
                return;
            }


            PreparedStatement psCheckCCCD = conn.prepareStatement("SELECT ID_NhanVien FROM NhanVien WHERE MaSoCCCD = ?");
            psCheckCCCD.setString(1, cccd);
            if (psCheckCCCD.executeQuery().next()) {
                request.setAttribute("message", "L\u1ed2I: M\u00e3 s\u1ed1 CCCD '" + cccd + "' \u0111\u00e3 t\u1ed3n t\u1ea1i trong h\u1ec7 th\u1ed1ng!");
                request.getRequestDispatcher("add-employee.jsp").forward(request, response);
                return;
            }


            String sqlCheckContact = "SELECT ID_NhanVien FROM NhanVien WHERE (SoDienThoai = ? AND LEN(SoDienThoai) > 0) OR (Email = ? AND LEN(Email) > 0)";
            PreparedStatement psCheckContact = conn.prepareStatement(sqlCheckContact);
            psCheckContact.setString(1, sdt != null ? sdt : "");
            psCheckContact.setString(2, email != null ? email : "");
            if (psCheckContact.executeQuery().next()) {
                request.setAttribute("message", "L\u1ed2I: S\u1ed1 \u0111i\u1ec7n tho\u1ea1i ho\u1eb7c Email \u0111\u00e3 \u0111\u01b0\u1ee3c s\u1eed d\u1ee5ng b\u1edfi ng\u01b0\u1eddi kh\u00e1c!");
                request.getRequestDispatcher("add-employee.jsp").forward(request, response);
                return;
            }

            conn.setAutoCommit(false);


            String sqlNV = "INSERT INTO NhanVien (HoVaTen, MaSoCCCD, TrangThaiNV_ID, GioiTinh, NgaySinh, SoDienThoai, Email, QueQuan, NoiThuongTru) VALUES (?, ?, 1, ?, ?, ?, ?, ?, ?)";
            PreparedStatement psNV = conn.prepareStatement(sqlNV, Statement.RETURN_GENERATED_KEYS);
            psNV.setString(1, request.getParameter("hoVaTen"));
            psNV.setString(2, cccd);
            psNV.setInt(3, Integer.parseInt(request.getParameter("gioiTinh")));

            String ns = request.getParameter("ngaySinh");
            if (ns == null || ns.trim().isEmpty()) {
                psNV.setNull(4, java.sql.Types.DATE);
            } else {
                psNV.setString(4, ns);
            }

            psNV.setString(5, sdt);
            psNV.setString(6, email);
            psNV.setString(7, request.getParameter("queQuan"));
            psNV.setString(8, request.getParameter("noiThuongTru"));

            psNV.executeUpdate();

            ResultSet rs = psNV.getGeneratedKeys();
            int idNhanVien = 0;
            if (rs.next()) idNhanVien = rs.getInt(1);


            String sqlTK = "INSERT INTO TaiKhoan (Username, Password, Role_ID, TrangThaiTK_ID, NhanVienID) VALUES (?, ?, ?, 1, ?)";
            PreparedStatement psTK = conn.prepareStatement(sqlTK, Statement.RETURN_GENERATED_KEYS);
            psTK.setString(1, username);
            psTK.setString(2, request.getParameter("password"));
            psTK.setString(3, request.getParameter("roleID"));
            psTK.setInt(4, idNhanVien);
            psTK.executeUpdate();

            ResultSet rsTK = psTK.getGeneratedKeys();
            int idTaiKhoan = 0;
            if (rsTK.next()) idTaiKhoan = rsTK.getInt(1);


            String sqlUpd = "UPDATE NhanVien SET TaiKhoanID = ? WHERE ID_NhanVien = ?";
            PreparedStatement psUpd = conn.prepareStatement(sqlUpd);
            psUpd.setInt(1, idTaiKhoan);
            psUpd.setInt(2, idNhanVien);
            psUpd.executeUpdate();

            conn.commit();
            request.setAttribute("message", "Th\u00eam nh\u00e2n vi\u00ean m\u1edbi th\u00e0nh c\u00f4ng v\u1edbi \u0111\u1ea7y \u0111\u1ee7 th\u00f4ng tin!");
        } catch (Exception e) {
            request.setAttribute("message", "L\u1ed7i h\u1ec7 th\u1ed1ng: " + e.getMessage());
        }
        request.getRequestDispatcher("add-employee.jsp").forward(request, response);
    }
}