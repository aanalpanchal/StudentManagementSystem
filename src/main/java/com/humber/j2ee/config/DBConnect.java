package com.humber.j2ee.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
	public static Connection initializeDB() throws SQLException {
		try {
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        String dbURL = "jdbc:mysql://localhost:3306/student?autoReconnect=true&useSSL=false";
	        String username = "root";
	        String password = "root";
	        Connection connection = DriverManager.getConnection(dbURL, username, password);
	        return connection;
	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	        return null;
	    }
	}
}
