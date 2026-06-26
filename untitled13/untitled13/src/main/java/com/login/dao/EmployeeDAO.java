package com.login.dao;

import com.login.model.Employee;
import com.login.util.ConnectService;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        String query = "SELECT n.MaNhanVien, n.HoTen, n.Tuoi, n.MaRole, n.MaTrangThai, r.TenRole, t.TenTrangThai " +
                       "FROM NHANVIEN n " +
                       "JOIN ROLE r ON n.MaRole = r.MaRole " +
                       "JOIN TRANGTHAI_NHANVIEN t ON n.MaTrangThai = t.MaTrangThai " +
                       "ORDER BY n.MaNhanVien DESC";

        try (Connection conn = new ConnectService().myConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Employee emp = new Employee();
                emp.setMaNhanVien(rs.getInt("MaNhanVien"));
                emp.setHoTen(rs.getString("HoTen"));
                emp.setTuoi(rs.getInt("Tuoi"));
                emp.setMaRole(rs.getInt("MaRole"));
                emp.setTenRole(rs.getString("TenRole"));
                emp.setMaTrangThai(rs.getInt("MaTrangThai"));
                emp.setTenTrangThai(rs.getString("TenTrangThai"));
                employees.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employees;
    }

    public Employee getEmployeeById(int maNhanVien) {
        Employee emp = null;
        String query = "SELECT n.MaNhanVien, n.HoTen, n.Tuoi, n.MaRole, n.MaTrangThai, r.TenRole, t.TenTrangThai " +
                       "FROM NHANVIEN n " +
                       "JOIN ROLE r ON n.MaRole = r.MaRole " +
                       "JOIN TRANGTHAI_NHANVIEN t ON n.MaTrangThai = t.MaTrangThai " +
                       "WHERE n.MaNhanVien = ?";

        try (Connection conn = new ConnectService().myConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, maNhanVien);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    emp = new Employee();
                    emp.setMaNhanVien(rs.getInt("MaNhanVien"));
                    emp.setHoTen(rs.getString("HoTen"));
                    emp.setTuoi(rs.getInt("Tuoi"));
                    emp.setMaRole(rs.getInt("MaRole"));
                    emp.setTenRole(rs.getString("TenRole"));
                    emp.setMaTrangThai(rs.getInt("MaTrangThai"));
                    emp.setTenTrangThai(rs.getString("TenTrangThai"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return emp;
    }

    public boolean addEmployee(Employee emp) {
        String query = "INSERT INTO NHANVIEN (HoTen, Tuoi, MaRole, MaTrangThai) VALUES (?, ?, ?, ?)";

        try (Connection conn = new ConnectService().myConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, emp.getHoTen());
            pstmt.setInt(2, emp.getTuoi());
            pstmt.setInt(3, emp.getMaRole());
            pstmt.setInt(4, emp.getMaTrangThai());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateEmployee(Employee emp) {
        String query = "UPDATE NHANVIEN SET HoTen = ?, Tuoi = ?, MaRole = ?, MaTrangThai = ? WHERE MaNhanVien = ?";

        try (Connection conn = new ConnectService().myConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, emp.getHoTen());
            pstmt.setInt(2, emp.getTuoi());
            pstmt.setInt(3, emp.getMaRole());
            pstmt.setInt(4, emp.getMaTrangThai());
            pstmt.setInt(5, emp.getMaNhanVien());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEmployee(int maNhanVien) {
        String query = "DELETE FROM NHANVIEN WHERE MaNhanVien = ?";

        try (Connection conn = new ConnectService().myConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, maNhanVien);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Employee> getEmployeesByRole(int maRole) {
        List<Employee> employees = new ArrayList<>();
        String query = "SELECT n.MaNhanVien, n.HoTen, n.Tuoi, n.MaRole, n.MaTrangThai, r.TenRole, t.TenTrangThai " +
                       "FROM NHANVIEN n " +
                       "JOIN ROLE r ON n.MaRole = r.MaRole " +
                       "JOIN TRANGTHAI_NHANVIEN t ON n.MaTrangThai = t.MaTrangThai " +
                       "WHERE n.MaRole = ? " +
                       "ORDER BY n.MaNhanVien DESC";

        try (Connection conn = new ConnectService().myConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, maRole);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Employee emp = new Employee();
                    emp.setMaNhanVien(rs.getInt("MaNhanVien"));
                    emp.setHoTen(rs.getString("HoTen"));
                    emp.setTuoi(rs.getInt("Tuoi"));
                    emp.setMaRole(rs.getInt("MaRole"));
                    emp.setTenRole(rs.getString("TenRole"));
                    emp.setMaTrangThai(rs.getInt("MaTrangThai"));
                    emp.setTenTrangThai(rs.getString("TenTrangThai"));
                    employees.add(emp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employees;
    }
}

