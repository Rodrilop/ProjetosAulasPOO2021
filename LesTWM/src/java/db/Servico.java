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
public class Servico {
    private long rowId;
    private String nm_servico;
    private String nm_prestador;
    private String nm_cliente;
    private String dt_servico;
    
    public static String getCreateStatement(){
        //return "DROP TABLE servicos ";
        return "CREATE TABLE IF NOT EXISTS servicos("
                + "nm_servico VARCHAR(100) NOT NULL,"
                + "nm_prestador VARCHAR(50) NOT NULL,"
                + "nm_cliente VARCHAR(50) NOT NULL,"
                + "dt_servico DATETIME NOT NULL"
                + ")";
    }
    
    public static ArrayList<Servico> getList() throws Exception{
        ArrayList<Servico> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rowid, * FROM servicos ORDER BY rowid");
        while(rs.next()){
            long rowId = rs.getLong("rowid");
            String nm_servico = rs.getString("nm_servico");
            String nm_prestador = rs.getString("nm_prestador");
            String nm_cliente = rs.getString("nm_cliente");
            String dt_servico = rs.getString("dt_servico");
            list.add(new Servico(rowId, nm_servico, nm_prestador, nm_cliente, dt_servico));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
        public static Servico get(long rowId) throws Exception{
        Servico d = null;
        Connection con = DbListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("SELECT rowid, * FROM servicos WHERE rowid = ?");
        stmt.setLong(1, rowId);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            String nm_servico = rs.getString("nm_servico");
            String nm_prestador = rs.getString("nm_prestador");
            String nm_cliente = rs.getString("nm_cliente");
            String dt_servico = rs.getString("dt_servico");
            d = new Servico(rowId, nm_servico, nm_prestador, nm_cliente, dt_servico);
        }
        rs.close();
        stmt.close();
        con.close();
        return d;
    }
 
    public static void insert(String nm_servico, String nm_prestador, String nm_cliente, String dt_servico) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "INSERT INTO servicos(nm_servico, nm_prestador, nm_cliente, dt_servico)"
                + "VALUES(?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, nm_servico);
        stmt.setString(2, nm_prestador);
        stmt.setString(3, nm_cliente);
        stmt.setString(4, dt_servico);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void update(long rowId, String dt_servico) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "UPDATE servicos SET dt_servico = ? WHERE rowid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, dt_servico);
        stmt.setLong(2, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void delete(long rowId) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "DELETE FROM servicos WHERE rowid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setLong(1, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }    
  
    public Servico(long rowId, String nm_servico, String nm_cliente, String nm_prestador, String dt_servico) {
        this.rowId = rowId;
        this.nm_servico = nm_servico;
        this.nm_prestador = nm_prestador;
        this.nm_cliente = nm_cliente;
        this.dt_servico = dt_servico;
    }
    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }

    public String getNm_servico() {
        return nm_servico;
    }

    public void setNm_servico(String nm_servico) {
        this.nm_servico = nm_servico;
    }

    public String getNm_prestador() {
        return nm_prestador;
    }

    public void setNm_prestador(String nm_prestador) {
        this.nm_prestador = nm_prestador;
    }

    public String getNm_cliente() {
        return nm_cliente;
    }

    public void setNm_cliente(String nm_cliente) {
        this.nm_cliente = nm_cliente;
    }

    public String getDt_servico() {
        return dt_servico;
    }

    public void setDt_servico(String dt_servico) {
        this.dt_servico = dt_servico;
    }
}
