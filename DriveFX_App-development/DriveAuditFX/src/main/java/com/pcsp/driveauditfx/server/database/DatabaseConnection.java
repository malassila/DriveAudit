package com.pcsp.driveauditfx.server.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://192.168.1.235:3306/drive_database?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USERNAME = "pcsp";
    private static final String PASSWORD = "ghXryPCSP2022!";

    private static Connection connection;

    public static Connection getConnection() {
        if (connection == null) {
            try {
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }
}




