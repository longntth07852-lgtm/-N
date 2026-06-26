package com.login.model;

public class Employee {
    private int maNhanVien;
    private String hoTen;
    private int tuoi;
    private int maRole;
    private String tenRole;
    private int maTrangThai;
    private String tenTrangThai;

    public Employee() {
    }

    public Employee(int maNhanVien, String hoTen, int tuoi, String tenRole, String tenTrangThai) {
        this.maNhanVien = maNhanVien;
        this.hoTen = hoTen;
        this.tuoi = tuoi;
        this.tenRole = tenRole;
        this.tenTrangThai = tenTrangThai;
    }

    public int getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(int maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public int getTuoi() {
        return tuoi;
    }

    public void setTuoi(int tuoi) {
        this.tuoi = tuoi;
    }

    public int getMaRole() {
        return maRole;
    }

    public void setMaRole(int maRole) {
        this.maRole = maRole;
    }

    public String getTenRole() {
        return tenRole;
    }

    public void setTenRole(String tenRole) {
        this.tenRole = tenRole;
    }

    public int getMaTrangThai() {
        return maTrangThai;
    }

    public void setMaTrangThai(int maTrangThai) {
        this.maTrangThai = maTrangThai;
    }

    public String getTenTrangThai() {
        return tenTrangThai;
    }

    public void setTenTrangThai(String tenTrangThai) {
        this.tenTrangThai = tenTrangThai;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "maNhanVien=" + maNhanVien +
                ", hoTen='" + hoTen + '\'' +
                ", tuoi=" + tuoi +
                ", tenRole='" + tenRole + '\'' +
                ", tenTrangThai='" + tenTrangThai + '\'' +
                '}';
    }
}
