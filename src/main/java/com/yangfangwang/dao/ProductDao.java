package com.yangfangwang.dao;

import com.yangfangwang.model.Product;
import com.yangfangwang.util.DBUtil;
import com.yangfangwang.util.PageUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {

    public List<Product> findAll(PageUtil page) {
        List<Product> list = new ArrayList<>();
        String countSql = "SELECT COUNT(*) FROM product";
        String sql = "SELECT p.*, c.name as category_name FROM product p LEFT JOIN category c ON p.category_id = c.id ORDER BY p.id DESC LIMIT ?, ?";
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
                list.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public List<Product> findAll() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM product p LEFT JOIN category c ON p.category_id = c.id ORDER BY p.id DESC";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public List<Product> findOnline(PageUtil page) {
        List<Product> list = new ArrayList<>();
        String countSql = "SELECT COUNT(*) FROM product WHERE status=1";
        String sql = "SELECT p.*, c.name as category_name FROM product p LEFT JOIN category c ON p.category_id = c.id WHERE p.status=1 ORDER BY p.id DESC LIMIT ?, ?";
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
                list.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public List<Product> findOnlineByCategories(String categoryIds, int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM product p LEFT JOIN category c ON p.category_id = c.id WHERE p.status=1 AND p.category_id IN (" + categoryIds + ") ORDER BY p.id DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public List<Product> findByCategory(int categoryId, PageUtil page) {
        List<Product> list = new ArrayList<>();
        String countSql = "SELECT COUNT(*) FROM product WHERE category_id=? AND status=1";
        String sql = "SELECT p.*, c.name as category_name FROM product p LEFT JOIN category c ON p.category_id = c.id WHERE p.category_id=? AND p.status=1 ORDER BY p.id DESC LIMIT ?, ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(countSql);
            stmt.setInt(1, categoryId);
            rs = stmt.executeQuery();
            if (rs.next()) page.setTotalRecords(rs.getInt(1));
            DBUtil.close(null, stmt, rs);

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            stmt.setInt(2, page.getOffset());
            stmt.setInt(3, page.getPageSize());
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public List<Product> search(String keyword, PageUtil page) {
        List<Product> list = new ArrayList<>();
        String countSql = "SELECT COUNT(*) FROM product WHERE (name LIKE ? OR generic_name LIKE ? OR manufacturer LIKE ?) AND status=1";
        String sql = "SELECT p.*, c.name as category_name FROM product p LEFT JOIN category c ON p.category_id = c.id WHERE (p.name LIKE ? OR p.generic_name LIKE ? OR p.manufacturer LIKE ?) AND p.status=1 ORDER BY p.id DESC LIMIT ?, ?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String like = "%" + keyword + "%";
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(countSql);
            stmt.setString(1, like); stmt.setString(2, like); stmt.setString(3, like);
            rs = stmt.executeQuery();
            if (rs.next()) page.setTotalRecords(rs.getInt(1));
            DBUtil.close(null, stmt, rs);

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, like); stmt.setString(2, like); stmt.setString(3, like);
            stmt.setInt(4, page.getOffset());
            stmt.setInt(5, page.getPageSize());
            rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public Product findById(int id) {
        String sql = "SELECT p.*, c.name as category_name FROM product p LEFT JOIN category c ON p.category_id = c.id WHERE p.id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            if (rs.next()) return mapProduct(rs);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return null;
    }

    public boolean insert(Product product) {
        String sql = "INSERT INTO product (name, generic_name, approval_number, manufacturer, specification, dosage_form, description, category_id, price, stock, status, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getGenericName());
            stmt.setString(3, product.getApprovalNumber());
            stmt.setString(4, product.getManufacturer());
            stmt.setString(5, product.getSpecification());
            stmt.setString(6, product.getDosageForm());
            stmt.setString(7, product.getDescription());
            stmt.setInt(8, product.getCategoryId());
            stmt.setDouble(9, product.getPrice());
            stmt.setInt(10, product.getStock());
            stmt.setInt(11, product.getStatus());
            stmt.setString(12, product.getImageUrl());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    public boolean update(Product product) {
        String sql = "UPDATE product SET name=?, generic_name=?, approval_number=?, manufacturer=?, specification=?, dosage_form=?, description=?, category_id=?, price=?, stock=?, status=?, image_url=? WHERE id=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getGenericName());
            stmt.setString(3, product.getApprovalNumber());
            stmt.setString(4, product.getManufacturer());
            stmt.setString(5, product.getSpecification());
            stmt.setString(6, product.getDosageForm());
            stmt.setString(7, product.getDescription());
            stmt.setInt(8, product.getCategoryId());
            stmt.setDouble(9, product.getPrice());
            stmt.setInt(10, product.getStock());
            stmt.setInt(11, product.getStatus());
            stmt.setString(12, product.getImageUrl());
            stmt.setInt(13, product.getId());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, stmt);
        }
    }

    public boolean updateStatus(int id, int status) {
        String sql = "UPDATE product SET status=?, publish_time=NOW() WHERE id=?";
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
        String sql = "DELETE FROM product WHERE id=?";
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

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setName(rs.getString("name"));
        p.setGenericName(rs.getString("generic_name"));
        p.setApprovalNumber(rs.getString("approval_number"));
        p.setManufacturer(rs.getString("manufacturer"));
        p.setSpecification(rs.getString("specification"));
        p.setDosageForm(rs.getString("dosage_form"));
        p.setDescription(rs.getString("description"));
        p.setCategoryId(rs.getInt("category_id"));
        try { p.setCategoryName(rs.getString("category_name")); } catch (Exception e) {}
        p.setPrice(rs.getDouble("price"));
        p.setStock(rs.getInt("stock"));
        p.setStatus(rs.getInt("status"));
        p.setImageUrl(rs.getString("image_url"));
        p.setCreateTime(rs.getTimestamp("create_time"));
        p.setUpdateTime(rs.getTimestamp("update_time"));
        p.setPublishTime(rs.getTimestamp("publish_time"));
        return p;
    }
}
