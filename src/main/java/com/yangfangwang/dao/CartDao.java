package com.yangfangwang.dao;

import com.yangfangwang.model.Cart;
import com.yangfangwang.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDao {

    public List<Cart> findByMemberId(int memberId) {
        List<Cart> list = new ArrayList<>();
        String sql = "SELECT c.*, p.name as product_name, p.price, p.image_url, p.specification, p.manufacturer " +
                     "FROM cart c LEFT JOIN product p ON c.product_id = p.id WHERE c.member_id=? ORDER BY c.id DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapCart(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public Cart findByMemberAndProduct(int memberId, int productId) {
        String sql = "SELECT c.*, p.name as product_name, p.price, p.image_url, p.specification, p.manufacturer " +
                     "FROM cart c LEFT JOIN product p ON c.product_id = p.id WHERE c.member_id=? AND c.product_id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            stmt.setInt(2, productId);
            rs = stmt.executeQuery();
            if (rs.next()) return mapCart(rs);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return null;
    }

    public boolean addOrUpdate(int memberId, int productId, int quantity) {
        Cart existing = findByMemberAndProduct(memberId, productId);
        if (existing != null) {
            return updateQuantity(existing.getId(), existing.getQuantity() + quantity);
        } else {
            return insert(memberId, productId, quantity);
        }
    }

    private boolean insert(int memberId, int productId, int quantity) {
        String sql = "INSERT INTO cart (member_id, product_id, quantity) VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    public boolean updateQuantity(int id, int quantity) {
        String sql = "UPDATE cart SET quantity=? WHERE id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, quantity);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM cart WHERE id=?";
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

    public boolean deleteByMemberId(int memberId) {
        String sql = "DELETE FROM cart WHERE member_id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt);
        }
        return true;
    }

    public int countByMemberId(int memberId) {
        String sql = "SELECT COUNT(*) FROM cart WHERE member_id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return 0;
    }

    private Cart mapCart(ResultSet rs) throws SQLException {
        Cart c = new Cart();
        c.setId(rs.getInt("id"));
        c.setMemberId(rs.getInt("member_id"));
        c.setProductId(rs.getInt("product_id"));
        c.setQuantity(rs.getInt("quantity"));
        c.setCreateTime(rs.getTimestamp("create_time"));
        c.setUpdateTime(rs.getTimestamp("update_time"));
        try { c.setProductName(rs.getString("product_name")); } catch (Exception e) {}
        try { c.setPrice(rs.getDouble("price")); } catch (Exception e) {}
        try { c.setImageUrl(rs.getString("image_url")); } catch (Exception e) {}
        try { c.setSpecification(rs.getString("specification")); } catch (Exception e) {}
        try { c.setManufacturer(rs.getString("manufacturer")); } catch (Exception e) {}
        return c;
    }
}
