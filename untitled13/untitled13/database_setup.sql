-- ==========================================
-- TẠO DATABASE
-- ==========================================
CREATE DATABASE HETHONGNHANVIEN;
GO

USE HETHONGNHANVIEN;
GO

-- ==========================================
-- BẢNG ROLE
-- ==========================================
CREATE TABLE ROLE
(
    MaRole INT IDENTITY(1,1) PRIMARY KEY,
    TenRole NVARCHAR(50) NOT NULL
);

INSERT INTO ROLE(TenRole)
VALUES
(N'Quản lý'),
(N'Nhân viên');

-- ==========================================
-- BẢNG TRẠNG THÁI NHÂN VIÊN
-- ==========================================
CREATE TABLE TRANGTHAI_NHANVIEN
(
    MaTrangThai INT IDENTITY(1,1) PRIMARY KEY,
    TenTrangThai NVARCHAR(50) NOT NULL
);

INSERT INTO TRANGTHAI_NHANVIEN(TenTrangThai)
VALUES
(N'Đang hoạt động'),
(N'Nghỉ');

-- ==========================================
-- BẢNG TÀI KHOẢN
-- ==========================================
CREATE TABLE TAIKHOAN
(
    MaTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
    TenDangNhap VARCHAR(50) UNIQUE NOT NULL,
    MatKhau VARCHAR(100) NOT NULL,
    HoTen NVARCHAR(100) NOT NULL,
    SoCCCD CHAR(12) UNIQUE NOT NULL,
    NgayCap DATE NOT NULL,
    NoiCap NVARCHAR(100) NOT NULL,
    NgaySinh DATE NOT NULL,
    GioiTinh NVARCHAR(10) NOT NULL,
    DiaChi NVARCHAR(200) NOT NULL
);

INSERT INTO TAIKHOAN
(TenDangNhap,MatKhau,HoTen,SoCCCD,NgayCap,NoiCap,NgaySinh,GioiTinh,DiaChi)
VALUES
('admin01','123456',N'Nguyễn Văn An','001234567890','2021-03-12',N'Hà Nội','1998-05-20',N'Nam',N'Hà Nội'),
('admin02','123456',N'Trần Thị Bình','001234567891','2020-07-21',N'Hà Nội','1999-08-11',N'Nữ',N'Hà Nam'),
('nv01','123456',N'Lê Quốc Cường','001234567892','2022-05-16',N'Hải Phòng','2002-01-08',N'Nam',N'Hải Phòng'),
('nv02','123456',N'Phạm Minh Đức','001234567893','2021-11-10',N'Nam Định','2001-09-17',N'Nam',N'Nam Định'),
('nv03','123456',N'Hoàng Thu Hà','001234567894','2023-02-14',N'Hà Nội','2003-12-25',N'Nữ',N'Hà Nội');

-- ==========================================
-- BẢNG NHÂN VIÊN
-- ==========================================
CREATE TABLE NHANVIEN
(
    MaNhanVien INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    Tuoi INT NOT NULL,
    MaRole INT NOT NULL,
    MaTrangThai INT NOT NULL,
    FOREIGN KEY (MaRole) REFERENCES ROLE(MaRole),
    FOREIGN KEY (MaTrangThai) REFERENCES TRANGTHAI_NHANVIEN(MaTrangThai)
);

INSERT INTO NHANVIEN
(HoTen,Tuoi,MaRole,MaTrangThai)
VALUES
(N'Nguyễn Văn An',28,1,1),
(N'Trần Thị Bình',27,1,1),
(N'Lê Quốc Cường',23,2,1),
(N'Phạm Minh Đức',24,2,2),
(N'Hoàng Thu Hà',22,2,1);

-- ==========================================
-- XEM DỮ LIỆU
-- ==========================================
SELECT 'ROLE' AS TableName;
SELECT * FROM ROLE;

SELECT 'TRANGTHAI_NHANVIEN' AS TableName;
SELECT * FROM TRANGTHAI_NHANVIEN;

SELECT 'TAIKHOAN' AS TableName;
SELECT * FROM TAIKHOAN;

SELECT 'NHANVIEN' AS TableName;
SELECT * FROM NHANVIEN;
