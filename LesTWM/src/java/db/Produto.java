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
public class Produto {
    private long rowId;
    private String nm_produto;
    private double peso;
    private double volume;
    
    public static String getCreateStatement(){
        //return "DROP TABLE produtos ";
        return "CREATE TABLE IF NOT EXISTS produtos("
                + "nm_produto VARCHAR(40),"
                + "peso NUMERIC(10,2) NOT NULL,"
                + "volume NUMERIC(10,2) NOT NULL"
                + ")";
    }
    
    public static ArrayList<Produto> getList() throws Exception{
        ArrayList<Produto> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rowid, * FROM produtos ORDER BY rowid");
        while(rs.next()){
            long rowId = rs.getLong("rowid");
            String nm_produto = rs.getString("nm_produto");
            double peso = rs.getDouble("peso");
            double volume = rs.getDouble("volume");
            list.add(new Produto(rowId, nm_produto, peso, volume));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }
    
        public static Produto get(long rowId) throws Exception{
        Produto d = null;
        Connection con = DbListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("SELECT rowid, * FROM produtos WHERE rowid = ?");
        stmt.setLong(1, rowId);
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            String nm_produto = rs.getString("nm_produto");
            double peso = rs.getDouble("peso");
            double volume = rs.getDouble("volume");
            d = new Produto(rowId, nm_produto, peso, volume);
        }
        rs.close();
        stmt.close();
        con.close();
        return d;
    }
 
    public static void insert(String nm_produto, double peso, double volume) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "INSERT INTO produtos(nm_produto, peso, volume)"
                + "VALUES(?,?,?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, nm_produto);
        stmt.setDouble(2, peso);
        stmt.setDouble(3, volume);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void update(long rowId, double peso, double volume) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "UPDATE produtos SET peso = ?, volume = ? WHERE rowid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setDouble(1, peso);
        stmt.setDouble(2, volume);
        stmt.setLong(3, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }
    
    public static void delete(long rowId) throws Exception{
        Connection con = DbListener.getConnection();
        String sql = "DELETE FROM produtos WHERE rowid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setLong(1, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }    
  
    public Produto(long rowId, String nm_produto, double peso, double volume) {
        this.rowId = rowId;
        this.nm_produto = nm_produto;
        this.peso = peso;
        this.volume = volume;
    }
    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }

    public String getNm_produto() {
        return nm_produto;
    }

    public void setNm_produto(String nm_produto) {
        this.nm_produto = nm_produto;
    }


    public Double getPeso() {
        return peso;
    }

    public void setPeso(Double peso) {
        this.peso = peso;
    }

    public Double getVolume() {
        return volume;
    }

    public void setVolume(Double volume) {
        this.volume = volume;
    }
 
}
