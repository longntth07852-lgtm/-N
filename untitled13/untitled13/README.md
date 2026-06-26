# Hệ Thống Quản Lý Nhân Viên - Login & Quản Lý Nhân Viên

## 📋 Tính Năng

1. **Đăng Nhập (Login)**
   - Hỗ trợ 2 loại user: Quản Lý và Nhân Viên
   - Session-based authentication
   - Redirect theo vai trò sau khi login thành công

2. **Quản Lý Nhân Viên (Employee Management)**
   - **Quản Lý (MaRole=1)**: Được phép xem danh sách nhân viên, thêm, sửa, xóa
   - **Nhân Viên (MaRole=2)**: Chỉ xem thông tin bản thân, không có quyền truy cập quản lý

3. **Bảo Mật**
   - Session validation
   - Role-based access control
   - 30-minute session timeout

---

## 🗂️ Cấu Trúc Database SQL Server

### Bảng ROLE
```
MaRole (INT, PK)
TenRole (NVARCHAR(50))
```

### Bảng TRANGTHAI_NHANVIEN
```
MaTrangThai (INT, PK)
TenTrangThai (NVARCHAR(50))
```

### Bảng TAIKHOAN
```
MaTaiKhoan (INT, PK)
TenDangNhap (VARCHAR(50), UNIQUE)
MatKhau (VARCHAR(100))
HoTen (NVARCHAR(100))
SoCCCD (CHAR(12), UNIQUE)
NgayCap (DATE)
NoiCap (NVARCHAR(100))
NgaySinh (DATE)
GioiTinh (NVARCHAR(10))
DiaChi (NVARCHAR(200))
```

### Bảng NHANVIEN
```
MaNhanVien (INT, PK)
HoTen (NVARCHAR(100))
Tuoi (INT)
MaRole (INT, FK -> ROLE)
MaTrangThai (INT, FK -> TRANGTHAI_NHANVIEN)
```

---

## 🗂️ Cấu Trúc Project

```
untitled13/
├── src/main/java/com/login/
│   ├── model/
│   │   ├── Role.java
│   │   ├── User.java
│   │   └── Employee.java
│   ├── dao/
│   │   ├── UserDAO.java
│   │   └── EmployeeDAO.java
│   ├── servlet/
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   └── EmployeeServlet.java
│   └── util/
│       └── DBConnection.java
├── src/main/webapp/
│   ├── WEB-INF/
│   │   └── web.xml
│   ├── login.jsp
│   ├── manager-dashboard.jsp
│   ├── employee-dashboard.jsp
│   ├── employee-list.jsp
│   ├── employee-form.jsp
│   └── employee-detail.jsp
├── pom.xml
└── database_setup.sql
```

---

## 🚀 Hướng Dẫn Cài Đặt

### 1. Cấu Hình Database (SQL Server)

**Yêu cầu:** SQL Server 2012+ (Express, Standard, Enterprise)

- Mở SQL Server Management Studio (SSMS)
- Chạy script: `database_setup.sql`

```sql
-- Copy toàn bộ nội dung database_setup.sql
-- Paste vào SSMS
-- Nhấn Execute
```

**Database được tạo:**
- Database: `HETHONGNHANVIEN`
- 4 bảng: `ROLE`, `TRANGTHAI_NHANVIEN`, `TAIKHOAN`, `NHANVIEN`

### 2. Cấu Hình Kết Nối Database

Mở file: `src/main/java/com/login/util/DBConnection.java`

```java
private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=HETHONGNHANVIEN;encrypt=true;trustServerCertificate=true";
private static final String USER = "sa";
private static final String PASSWORD = "";  // Thay đổi nếu SQL Server có password
```

### 3. Build & Run Project

```bash
# Compile
mvn clean compile

# Package
mvn package

# Hoặc run trực tiếp trên IDE (IntelliJ, Eclipse, v.v.)
```

### 4. Deploy WAR file

- Copy file `.war` vào thư mục `webapps` của Tomcat
- Restart Tomcat
- Truy cập: `http://localhost:8080/untitled13/`

---

## 👤 Demo Credentials

| Vai Trò    | Tên Đăng Nhập | Mật Khẩu | Ghi Chú |
|-----------|---------------|---------|--------|
| Quản Lý   | admin01       | 123456  | Có quyền quản lý nhân viên |
| Quản Lý   | admin02       | 123456  | Có quyền quản lý nhân viên |
| Nhân Viên | nv01          | 123456  | Chỉ xem thông tin cá nhân |
| Nhân Viên | nv02          | 123456  | Chỉ xem thông tin cá nhân |
| Nhân Viên | nv03          | 123456  | Chỉ xem thông tin cá nhân |

---

## 📝 URL Mapping

| URL | Mô Tả | Quyền Truy Cập |
|-----|-------|----------------|
| `/login.jsp` | Trang đăng nhập | Public |
| `/login` | POST xử lý login | Public |
| `/manager-dashboard.jsp` | Dashboard quản lý | Quản Lý only |
| `/employee-dashboard.jsp` | Dashboard nhân viên | Nhân Viên only |
| `/employee` | Danh sách nhân viên | Quản Lý only |
| `/employee?action=edit` | Form thêm/sửa nhân viên | Quản Lý only |
| `/employee?action=view&id=X` | Chi tiết nhân viên | Quản Lý only |
| `/logout` | Đăng xuất | All authenticated users |

---

## 🔒 Phân Quyền

### Quản Lý (MaRole = 1)
✅ Đăng nhập  
✅ Xem thông tin cá nhân  
✅ Xem danh sách nhân viên  
✅ Thêm nhân viên  
✅ Sửa nhân viên  
✅ Xóa nhân viên  

### Nhân Viên (MaRole = 2)
✅ Đăng nhập  
✅ Xem thông tin cá nhân  
❌ Truy cập quản lý nhân viên  

---

## 🛠️ Technologies

- **Backend:** Java Servlet
- **Frontend:** JSP, HTML, CSS
- **Database:** SQL Server (T-SQL)
- **Server:** Tomcat
- **Build Tool:** Maven
- **JDBC Driver:** SQL Server JDBC Driver v12.4.2

---

## ⚠️ Troubleshooting

### 1. Lỗi: "Login failed for user 'sa'"
**Giải pháp:** 
- Kiểm tra SQL Server có đang chạy
- Kiểm tra username/password trong `DBConnection.java`

### 2. Lỗi: "Table 'NHANVIEN' doesn't exist"
**Giải pháp:** Chạy lại `database_setup.sql` để tạo tables

### 3. Lỗi: "No suitable driver found"
**Giải pháp:** Đảm bảo SQL Server JDBC Driver đã được thêm vào pom.xml

---

**Version:** 1.0  
**Database:** SQL Server 2012+
