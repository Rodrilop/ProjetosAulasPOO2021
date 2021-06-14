/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import java.sql.*;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author RodrigoLopes
 */
public class DbListener implements ServletContextListener {

    public static final String CLASS_NAME = "org.sqlite.JDBC";
    public static final String URL = "jdbc:sqlite:AvaliacaoPooP2.db";
    public static Exception exception = null;
    
    public static Connection getConnection() throws Exception{
        return DriverManager.getConnection(URL);
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            Class.forName(CLASS_NAME);
            Connection con = getConnection();
            Statement stmt = con.createStatement();
            stmt.execute(User.getCreateStatement());
            if (User.getUsers().isEmpty()) {
                User.insertUser("rodrigo", "Rodrigo Carlos de Souza Lopes", "ADMIN", "1234");
                User.insertUser("fulano", "Fulano da Silva", "USER", "1234");
            }
            stmt.close();
            con.close();
        } catch (Exception ex) {
            exception = ex;
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}