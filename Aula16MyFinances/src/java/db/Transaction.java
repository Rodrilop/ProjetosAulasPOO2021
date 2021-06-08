/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.*;
import java.util.ArrayList;
import web.DbListener;

/**
 *
 * @author RodrigoLopes
 */
public class Transaction {

    private long rowId;
    private String datetime;
    private String description;
    private String category;
    private double value;
    private String origin;

    public static String getCreateStatement() {
        return "CREATE TABLE IF NOT EXISTS transactions("
                + "datetime VARCHAR(25),"
                + "description VARCHAR(200) NOT NULL,"
                + "category VARCHAR(50) NOT NULL,"
                + "value NUMERIC(10,2) NOT NULL,"
                + "origin VARCHAR(200) NOT NULL,"
                + "FOREIGN KEY(category) REFERENCES categories(name)"
                + ")";
    }

    public static ArrayList<Transaction> getList() throws Exception {
        ArrayList<Transaction> list = new ArrayList<>();
        Connection con = DbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT rowid, * FROM transactions ORDER BY datetime");
        while (rs.next()) {
            long rowId = rs.getLong("rowid");
            String datetime = rs.getString("datetime");
            String description = rs.getString("description");
            String category = rs.getString("category");
            double value = rs.getDouble("value");
            String origin = rs.getString("origin");
            list.add(new Transaction(rowId, datetime, description, category, value, origin));
        }
        rs.close();
        stmt.close();
        con.close();
        return list;
    }

    public static Transaction get(long rowId) throws Exception {
        Transaction t = null;
        Connection con = DbListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("SELECT rowid, * FROM transactions WHERE rowid=?");
        stmt.setLong(1, rowId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            String datetime = rs.getString("datetime");
            String description = rs.getString("description");
            String category = rs.getString("category");
            double value = rs.getDouble("value");
            String origin = rs.getString("origin");
            t = new Transaction(rowId, datetime, description, category, value, origin);
        }
        rs.close();
        stmt.close();
        con.close();
        return t;
    }

    public static void insert(String datetime, String description, String category, double value, String origin) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "INSERT INTO transactions(datetime, description, category, value, origin) "
                + "VALUES(?,?,?,?,?)";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, datetime);
        stmt.setString(2, description);
        stmt.setString(3, category);
        stmt.setDouble(4, value);
        stmt.setString(5, origin);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public static void update(long rowId, String datetime, String description, String category, double value, String origin) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "UPDATE transactions "
                + "SET datetime=?, "
                + "description=?, "
                + "category=?, "
                + "value=?, "
                + "origin=? "
                + "WHERE rowid=?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setString(1, datetime);
        stmt.setString(2, description);
        stmt.setString(3, category);
        stmt.setDouble(4, value);
        stmt.setString(5, origin);
        stmt.setLong(6, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public static void delete(long rowId) throws Exception {
        Connection con = DbListener.getConnection();
        String sql = "DELETE FROM transactions WHERE rowid = ?";
        PreparedStatement stmt = con.prepareStatement(sql);
        stmt.setLong(1, rowId);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public Transaction(long rowId, String datetime, String description, String category, double value, String origin) {
        this.rowId = rowId;
        this.datetime = datetime;
        this.description = description;
        this.category = category;
        this.value = value;
        this.origin = origin;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public long getRowId() {
        return rowId;
    }

    public void setRowId(long rowId) {
        this.rowId = rowId;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getValue() {
        return value;
    }

    public void setValue(double value) {
        this.value = value;
    }
}