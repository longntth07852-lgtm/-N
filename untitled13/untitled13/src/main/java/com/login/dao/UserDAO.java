package com.login.dao;

import com.login.model.User;
import com.login.util.ConnectService;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public User authenticateUser(String tenDangNhap, String matKhau) {
        User user = null;
        String query = "SELECT t.MaTaiKhoan, t.TenDangNhap, t.HoTen, t.SoCCCD, t.NgayCap, t.NoiCap, t.NgaySinh, t.GioiTinh, t.DiaChi, " +
                       "n.MaRole, n.MaTrangThai, r.TenRole " +
                       "FROM TAIKHOAN t " +
                       "LEFT JOIN NHANVIEN n ON t.HoTen = n.HoTen " +
                       "LEFT JOIN ROLE r ON n.MaRole = r.MaRole " +
                       "WHERE t.TenDangNhap = ? AND t.MatKhau = ?";

        try (Connection conn = new ConnectService().myConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, tenDangNhap);
            pstmt.setString(2, matKhau);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setMaTaiKhoan(rs.getInt("MaTaiKhoan"));
                    user.setTenDangNhap(rs.getString("TenDangNhap"));
                    user.setHoTen(rs.getString("HoTen"));
                    user.setSoCCCD(rs.getString("SoCCCD"));
                    user.setNgayCap(rs.getString("NgayCap"));
                    user.setNoiCap(rs.getString("NoiCap"));
                    user.setNgaySinh(rs.getString("NgaySinh"));
                    user.setGioiTinh(rs.getString("GioiTinh"));
                    user.setDiaChi(rs.getString("DiaChi"));
                    user.setMaRole(rs.getInt("MaRole"));
                    user.setTenRole(rs.getString("TenRole"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public User getUserById(int maTaiKhoan) {
        User user = null;
        String query = "SELECT t.MaTaiKhoan, t.TenDangNhap, t.HoTen, t.SoCCCD, t.NgayCap, t.NoiCap, t.NgaySinh, t.GioiTinh, t.DiaChi, " +
                       "n.MaRole, r.TenRole " +
                       "FROM TAIKHOAN t " +
                       "LEFT JOIN NHANVIEN n ON t.HoTen = n.HoTen " +
                       "LEFT JOIN ROLE r ON n.MaRole = r.MaRole " +
                       "WHERE t.MaTaiKhoan = ?";

        try (Connection conn = new ConnectService().myConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, maTaiKhoan);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setMaTaiKhoan(rs.getInt("MaTaiKhoan"));
                    user.setTenDangNhap(rs.getString("TenDangNhap"));
                    user.setHoTen(rs.getString("HoTen"));
                    user.setSoCCCD(rs.getString("SoCCCD"));
                    user.setNgayCap(rs.getString("NgayCap"));
                    user.setNoiCap(rs.getString("NoiCap"));
                    user.setNgaySinh(rs.getString("NgaySinh"));
                    user.setGioiTinh(rs.getString("GioiTinh"));
                    user.setDiaChi(rs.getString("DiaChi"));
                    user.setMaRole(rs.getInt("MaRole"));
                    user.setTenRole(rs.getString("TenRole"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
}

