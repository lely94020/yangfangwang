package com.yangfangwang.dao;

import com.yangfangwang.model.Order;
import com.yangfangwang.model.OrderItem;
import com.yangfangwang.util.DBUtil;
import com.yangfangwang.util.PageUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {

    public List<Order> findAll(PageUtil page) {
        List<Order> list = new ArrayList<>();
        String countSql = "SELECT COUNT(*) FROM orders";
        String sql = "SELECT o.*, m.username as member_name FROM orders o LEFT JOIN member m ON o.member_id = m.id ORDER BY o.id DESC LIMIT ?, ?";
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
                list.add(mapOrder(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public List<Order> findAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, m.username as member_name FROM orders o LEFT JOIN member m ON o.member_id = m.id ORDER BY o.id DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapOrder(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public List<Order> findByMemberId(int memberId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, m.username as member_name FROM orders o LEFT JOIN member m ON o.member_id = m.id WHERE o.member_id=? ORDER BY o.id DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, memberId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapOrder(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public Order findById(int id) {
        String sql = "SELECT o.*, m.username as member_name FROM orders o LEFT JOIN member m ON o.member_id = m.id WHERE o.id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) {
                Order order = mapOrder(rs);
                order.setItems(findItemsByOrderId(id));
                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return null;
    }

    public List<OrderItem> findItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT * FROM order_item WHERE order_id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSubtotal(rs.getDouble("subtotal"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public int insert(Order order) {
        String sql = "INSERT INTO orders (order_no, member_id, total_amount, status, consignee, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, order.getOrderNo());
            stmt.setInt(2, order.getMemberId());
            stmt.setDouble(3, order.getTotalAmount());
            stmt.setInt(4, order.getStatus());
            stmt.setString(5, order.getConsignee());
            stmt.setString(6, order.getPhone());
            stmt.setString(7, order.getAddress());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return 0;
    }

    public boolean insertItem(OrderItem item) {
        String sql = "INSERT INTO order_item (order_id, product_id, product_name, price, quantity, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, item.getOrderId());
            stmt.setInt(2, item.getProductId());
            stmt.setString(3, item.getProductName());
            stmt.setDouble(4, item.getPrice());
            stmt.setInt(5, item.getQuantity());
            stmt.setDouble(6, item.getSubtotal());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    public boolean updateStatus(int id, int status) {
        String sql = "UPDATE orders SET status=? WHERE id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, status);
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
        String sql = "DELETE FROM orders WHERE id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt);
        }
        return true;
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setOrderNo(rs.getString("order_no"));
        o.setMemberId(rs.getInt("member_id"));
        try { o.setMemberName(rs.getString("member_name")); } catch (Exception e) {}
        o.setTotalAmount(rs.getDouble("total_amount"));
        o.setStatus(rs.getInt("status"));
        o.setConsignee(rs.getString("consignee"));
        o.setPhone(rs.getString("phone"));
        o.setAddress(rs.getString("address"));
        o.setCreateTime(rs.getTimestamp("create_time"));
        o.setUpdateTime(rs.getTimestamp("update_time"));
        return o;
    }
}
