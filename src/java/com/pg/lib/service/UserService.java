/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pg.lib.service;

import com.pg.lib.model.UserModel;
import com.pg.lib.utility.ConnectDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Gus
 */
public class UserService {

    private static Connection conn;
    private static PreparedStatement ps;
    private static ResultSet rs;

    public static int getTotalRecords() throws ClassNotFoundException, SQLException, NamingException {
        int totalRecords = 0;
        try {
            String sql = "SELECT COUNT(*) as total FROM tb_user ";
            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                totalRecords = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            ps.close();
            rs.close();
        }
        return totalRecords;
    }

    public static int getFilteredRecords(String searchValue) throws ClassNotFoundException, SQLException, NamingException {
        int filteredRecords = 0;
        try {
            String sql = "SELECT COUNT(*) as total FROM tb_user WHERE (user_id like ? OR user_user like ? OR user_pass like ? OR user_name like ?)";


            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");
            ps.setString(2, "%" + searchValue + "%");
            ps.setString(3, "%" + searchValue + "%");
            ps.setString(4, "%" + searchValue + "%");

            rs = ps.executeQuery();

            while (rs.next()) {
                filteredRecords = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            rs.close();
            ps.close();
        }
        return filteredRecords;
    }

    public static List<UserModel> getDataFromDatabase(int start, int length, String searchValue, String orderColumn, String orderDir) throws ClassNotFoundException, SQLException, NamingException {
        List<UserModel> listuser = new ArrayList<UserModel>();
        try {
            String sql = "SELECT * FROM tb_user WHERE (user_id like ? OR user_user like ? OR user_pass like ? OR user_name like ?) ";
            String[] columns = {"user_id", "user_user", "user_pass", "user_name"};
            if (orderColumn != null && !orderColumn.isEmpty()) {
                sql += " ORDER BY " + columns[Integer.parseInt(orderColumn)] + " " + orderDir;
            }
            sql += " LIMIT ?,?";

            System.out.println(sql);

            conn = ConnectDB.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchValue + "%");
            ps.setString(2, "%" + searchValue + "%");
            ps.setString(3, "%" + searchValue + "%");
            ps.setString(4, "%" + searchValue + "%");
            ps.setInt(5, start);
            ps.setInt(6, length + start);

            rs = ps.executeQuery();

            while (rs.next()) {
                UserModel user = new UserModel();
                user.setUser_id(rs.getString("user_id"));
                user.setUser_user(rs.getString("user_user"));
                user.setUser_pass(rs.getString("user_pass"));
                user.setUser_name(rs.getString("user_name"));

                listuser.add(user);

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectDB.closeConnection(conn);
            rs.close();
            ps.close();
        }
        return listuser;
    }
}
