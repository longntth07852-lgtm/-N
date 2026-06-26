package com.login.model;

public class User {
    private int maTaiKhoan;
    private String tenDangNhap;
    private String hoTen;
    private String soCCCD;
    private String ngayCap;
    private String noiCap;
    private String ngaySinh;
    private String gioiTinh;
    private String diaChi;
    private int maRole;
    private String tenRole;

    public User() {
    }

    public User(int maTaiKhoan, String tenDangNhap, String hoTen, String soCCCD) {
        this.maTaiKhoan = maTaiKhoan;
        this.tenDangNhap = tenDangNhap;
        this.hoTen = hoTen;
        this.soCCCD = soCCCD;
    }

    public int getMaTaiKhoan() {
        return maTaiKhoan;
    }

    public void setMaTaiKhoan(int maTaiKhoan) {
        this.maTaiKhoan = maTaiKhoan;
    }

    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getSoCCCD() {
        return soCCCD;
    }

    public void setSoCCCD(String soCCCD) {
        this.soCCCD = soCCCD;
    }

    public String getNgayCap() {
        return ngayCap;
    }

    public void setNgayCap(String ngayCap) {
        this.ngayCap = ngayCap;
    }

    public String getNoiCap() {
        return noiCap;
    }

    public void setNoiCap(String noiCap) {
        this.noiCap = noiCap;
    }

    public String getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(String ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(String gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
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

    @Override
    public String toString() {
        return "User{" +
                "maTaiKhoan=" + maTaiKhoan +
                ", tenDangNhap='" + tenDangNhap + '\'' +
                ", hoTen='" + hoTen + '\'' +
                ", soCCCD='" + soCCCD + '\'' +
                ", tenRole='" + tenRole + '\'' +
                '}';
    }
}
