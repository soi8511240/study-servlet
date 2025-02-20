package com.study.connection;

import com.study.Constants;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionTest {

    Connection conn;
    Statement stmt;

    public Connection getConnection() throws Exception{

        try {
            //STEP 2: Register JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(Constants.DB_URL, Constants.DB_USER, Constants.DB_PASS);

        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }

        return conn;
    }

    public Statement getStatement() throws Exception{
        try {
            stmt = getConnection().createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stmt;
    }

    public void closeConnection(Statement stmt) throws Exception{
        stmt.close();
    }


}
