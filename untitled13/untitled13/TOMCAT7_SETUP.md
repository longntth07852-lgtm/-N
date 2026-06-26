# Hướng Dẫn Sử Dụng Tomcat7 Maven Plugin

## 📦 Cấu Hình Đã Thêm

Tomcat7 Maven Plugin đã được thêm vào `pom.xml` với cấu hình:
- **Port:** 8080
- **Context Path:** /untitled13
- **Version:** 2.2

---

## 🚀 Các Lệnh Tomcat7

### 1. Chạy Tomcat7 với ứng dụng
```bash
mvn tomcat7:run
```
**Kết quả:** Tomcat7 sẽ khởi động tại `http://localhost:8080/untitled13`

### 2. Deploy ứng dụng lên Tomcat7 đã cài đặt
```bash
mvn tomcat7:deploy
```
**Yêu cầu:** Tomcat7 phải được cài đặt và có cấu hình trong `~/.m2/settings.xml`

### 3. Undeploy ứng dụng
```bash
mvn tomcat7:undeploy
```

### 4. Reload ứng dụng (khởi động lại mà không tắt Tomcat)
```bash
mvn tomcat7:reload
```

---

## 📝 Cấu Hình Manager (Tùy Chọn)

Nếu bạn có Tomcat7 server đã cài đặt, thêm vào `~/.m2/settings.xml`:

```xml
<servers>
  <server>
    <id>tomcat7-server</id>
    <username>admin</username>
    <password>your_password</password>
  </server>
</servers>
```

Rồi cập nhật trong `pom.xml`:

```xml
<plugin>
  <groupId>org.apache.tomcat.maven</groupId>
  <artifactId>tomcat7-maven-plugin</artifactId>
  <version>2.2</version>
  <configuration>
    <url>http://localhost:8080/manager/text</url>
    <server>tomcat7-server</server>
    <path>/untitled13</path>
  </configuration>
</plugin>
```

---

## ✅ Quick Start

```bash
# 1. Build project
mvn clean install

# 2. Chạy Tomcat7 (auto download & start)
mvn tomcat7:run

# 3. Truy cập
# http://localhost:8080/untitled13/

# 4. Dừng (Ctrl + C)
```

---

## 📌 Lưu Ý

- **Port:** Nếu muốn đổi port, sửa trong pom.xml (`<port>8080</port>`)
- **Database:** Đảm bảo SQL Server đang chạy trước khi start Tomcat
- **Java Version:** Tomcat7 cần Java 1.6+ (đã cấu hình 1.8)

---

## 🐛 Troubleshooting

### Lỗi: "Address already in use :8080"
```bash
# Đổi port trong pom.xml hoặc:
mvn tomcat7:run -Dtomcat7.port=8081
```

### Lỗi: "Can't connect to database"
- Kiểm tra SQL Server đang chạy
- Kiểm tra credentials trong `DBConnection.java`

### Tomcat không tắt được
```bash
# Force stop
mvn tomcat7:run -X  # Xem logs
# Hoặc Ctrl + C 2 lần
```

---

**Tomcat7 Plugin Version:** 2.2  
**Java Target:** 1.8
