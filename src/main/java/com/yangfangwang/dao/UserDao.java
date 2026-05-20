package com.yangfangwang.dao;

import com.yangfangwang.model.User;
import com.yangfangwang.util.DBUtil;
import com.yangfangwang.util.PageUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    public User findByUsername(String username) {
        String sql = "SELECT u.*, r.name as role_name FROM user u LEFT JOIN role r ON u.role_id = r.id WHERE u.username = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return null;
    }

    public User findById(int id) {
        String sql = "SELECT u.*, r.name as role_name FROM user u LEFT JOIN role r ON u.role_id = r.id WHERE u.id = ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return null;
    }

    public List<User> findAll(PageUtil page) {
        List<User> list = new ArrayList<>();
        String countSql = "SELECT COUNT(*) FROM user";
        String sql = "SELECT u.*, r.name as role_name FROM user u LEFT JOIN role r ON u.role_id = r.id ORDER BY u.id DESC LIMIT ?, ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(countSql);
            rs = stmt.executeQuery();
            if (rs.next()) page.setTotalRecords(rs.getInt(1));
            DBUtil.close(null, stmt, rs);

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, page.getOffset());
            stmt.setInt(2, page.getPageSize());
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.*, r.name as role_name FROM user u LEFT JOIN role r ON u.role_id = r.id ORDER BY u.id DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public boolean insert(User user) {
        String sql = "INSERT INTO user (username, password, real_name, email, phone, role_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getRealName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setInt(6, user.getRoleId());
            stmt.setInt(7, user.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    public boolean update(User user) {
        StringBuilder sql = new StringBuilder("UPDATE user SET real_name=?, email=?, phone=?, role_id=?, status=?");
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            sql.append(", password=?");
        }
        sql.append(" WHERE id=?");
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql.toString());
            stmt.setString(1, user.getRealName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setInt(4, user.getRoleId());
            stmt.setInt(5, user.getStatus());
            int idx = 6;
            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                stmt.setString(idx++, user.getPassword());
            }
            stmt.setInt(idx, user.getId());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM user WHERE id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setRealName(rs.getString("real_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setRoleId(rs.getInt("role_id"));
        try { user.setRoleName(rs.getString("role_name")); } catch (Exception e) {}
        user.setStatus(rs.getInt("status"));
        user.setCreateTime(rs.getTimestamp("create_time"));
        user.setUpdateTime(rs.getTimestamp("update_time"));
        return user;
    }
}
