/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.util.ArrayList;
import web.DbListener;
import java.sql.*;

/**
 *
 * @author RodrigoLopes
 */
public class Disciplina {
    private long rowId;
    private String nome;
    private String dia_semana;
    private String horario;
    private double qtde_aulas;
    private double nota_p1;
    private double nota_p2;
    
    public static String getCreateStatement(){
        //return "DROP TABLE  disciplinas ";
        return "CREATE TABLE IF NOT EXISTS disciplinas("
                + "nome VARCHAR(40),"
                + "dia_semana VARCHAR(20) NOT NULL,"
                + "horario VARCHAR(20) NOT NULL,"
                + "qtde_aulas NUMERIC(10,2) NOT NULL,"
                + "nota_p1 NUMERIC(10,2) NOT NULL,"
                + "nota_p2 NUMERIC(10,2) NOT NULL"
                + ")";
    }
    
    public static ArrayList<Disciplina> getList() throws Exception{
        ArrayList<Disciplina> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rowid, * FROM disciplinas ORDER BY rowid");
        while(rs.next()){
            long rowId = rs.getLong("rowid");
            String nome = rs.getString("nome");
            String dia_semana = rs.getString("dia_semana");
            String horario = rs.getString("horario");
            double qtde_aulas = rs.getDouble("qtde_aulas");
            double nota_p1 = rs.getDouble("nota_p1");
            double nota_p2 = rs.getDouble("nota_p2");
            list.add(new Disciplina(rowId, nome, dia_semana, horario, qtde_aulas, nota_p1, nota_p2));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
        public static Disciplina get(long rowId) throws Exception{
        Disciplina d = null;
        Connection con = DbListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("SELECT rowid, * FROM disciplinas WHERE rowid = ?");
        stmt.setLong(1, rowId);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            String nome = rs.getString("nome");
            String dia_semana = rs.getString("dia_semana");
            String horario = rs.getString("horario");
            double qtde_aulas = rs.getDouble("qtde_aulas");
            double nota_p1 = rs.getDouble("nota_p1");
            double nota_p2 = rs.getDouble("nota_p2");
            d = new Disciplina(rowId, nome, dia_semana, horario, qtde_aulas, nota_p1, nota_p2);
        }
        rs.close();
        stmt.close();
        con.close();
        return d;
    }
 
    public static void insert(String nome, String dia_semana, String horario, double qtde_aulas, double nota_p1, double nota_p2) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "INSERT INTO disciplinas(nome, dia_semana, horario, qtde_aulas, nota_p1, nota_p2)"
                + "VALUES(?,?,?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, nome);
        stmt.setString(2, dia_semana);
        stmt.setString(3, horario);
        stmt.setDouble(4, qtde_aulas);
        stmt.setDouble(5, nota_p1);
        stmt.setDouble(6, nota_p2);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void update(long rowId, double nota_p1, double nota_p2) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "UPDATE disciplinas SET nota_p1 = ?, nota_p2 = ? WHERE rowid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setDouble(1, nota_p1);
        stmt.setDouble(2, nota_p2);
        stmt.setLong(3, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void delete(long rowId) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "DELETE FROM disciplinas WHERE rowid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setLong(1, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }    
  
    public Disciplina(long rowId, String nome, String dia_semana, String horario, double qtde_aulas, double nota_p1, double nota_p2) {
        this.rowId = rowId;
        this.nome = nome;
        this.dia_semana = dia_semana;
        this.horario = horario;
        this.qtde_aulas = qtde_aulas;
        this.nota_p1 = nota_p1;
        this.nota_p2 = nota_p2;
    }
    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDia_semana() {
        return dia_semana;
    }

    public void setDia_semana(String dia_semana) {
        this.dia_semana = dia_semana;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public Double getQtde_aulas() {
        return qtde_aulas;
    }

    public void setQtde_aulas(Double qtde_aulas) {
        this.qtde_aulas = qtde_aulas;
    }

    public Double getNota_p1() {
        return nota_p1;
    }

    public void setNota_p1(Double nota_p1) {
        this.nota_p1 = nota_p1;
    }

    public Double getNota_p2() {
        return nota_p2;
    }

    public void setNota_p2(Double nota_p2) {
        this.nota_p2 = nota_p2;
    }    
}
