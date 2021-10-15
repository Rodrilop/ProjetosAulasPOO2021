/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package web;

import db.Disciplina;
import db.Produto;
import db.Servico;
import db.User;
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
    public static final String URL = "jdbc:sqlite:talkwithme.db";
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
            stmt.execute(Disciplina.getCreateStatement());
            if(Disciplina.getList().isEmpty()){
                Disciplina.insert("Programação Orientada a Objetos", "Segunda-feira", "19h00-22h30", 4, 10, 10);
                Disciplina.insert("Engenharia de Software III", "Terça-feira", "19h00-22h30", 4, 10, 10);
                Disciplina.insert("Sistemas Operacionais II", "Quarta-feira", "19h00-22h30", 4, 10, 10);
                Disciplina.insert("Linguagem de Programação IV - INTERNET", "Quinta-feira", "19h00-22h30", 4, 10, 10);
                Disciplina.insert("Sistemas Operacionais II", "Sexta-feira", "20h30-22h30", 2, 10, 10);
                Disciplina.insert("Programação para Dispositivos Móveis", "Sábado", "8h00-11h30", 4, 10, 10);
            }
            stmt.execute(Produto.getCreateStatement());
            if(Disciplina.getList().isEmpty()){
                Produto.insert("Computador", 3.00, 3.00);
                Produto.insert("Smartphone", 0.80, 0.80);
            }
            stmt.execute(Servico.getCreateStatement());
            if(Disciplina.getList().isEmpty()){
                Servico.insert("Leitura Água", "Sabesp", "Ronaldo Nazário", "01/01/2021");
                Servico.insert("Leitura Luz", "Enel", "Ronaldo Nazário", "01/01/2021");
            }
            stmt.close();
            con.close();
        }catch(Exception ex){
            exception = ex;
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}