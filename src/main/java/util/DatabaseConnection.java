package util;

import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://127.0.0.1:3306/aptcoursework";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root123";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found: " + e.getMessage());
        }
    }

    public static Connection getConnection(){
        try{
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        }catch (SQLException e){
            System.out.println(e.getMessage());
            return null;
        }
    }
}
