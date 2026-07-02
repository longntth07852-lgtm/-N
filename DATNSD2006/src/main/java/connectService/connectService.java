package connectService;

import java.sql.*;
public class connectService {
    private final String URL = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyBanHang;encrypt=true;trustServerCertificate=true";

    private final String USER = "sa";

    private final String PASSWORD = "123";

    public connectService() {
    }

    public Connection myConnection() {
        Connection conn = null;

        try {

            // Load Driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Create Connection
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("Connect successful!");

        } catch (ClassNotFoundException e) {

            System.out.println("Driver not found!");
            e.printStackTrace();

        } catch (SQLException e) {

            System.out.println("Connect failed!");
            e.printStackTrace();
        }

        return conn;
    }
}