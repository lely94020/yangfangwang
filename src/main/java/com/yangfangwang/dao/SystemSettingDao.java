package com.yangfangwang.dao;

import com.yangfangwang.model.SystemSetting;
import com.yangfangwang.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SystemSettingDao {

    public List<SystemSetting> findAll() {
        List<SystemSetting> list = new ArrayList<>();
        String sql = "SELECT * FROM system_setting ORDER BY id";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                SystemSetting s = new SystemSetting();
                s.setId(rs.getInt("id"));
                s.setSettingKey(rs.getString("setting_key"));
                s.setSettingValue(rs.getString("setting_value"));
                s.setDescription(rs.getString("description"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return list;
    }

    public SystemSetting findByKey(String key) {
        String sql = "SELECT * FROM system_setting WHERE setting_key=?";
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, key);
            rs = stmt.executeQuery();
            if (rs.next()) {
                SystemSetting s = new SystemSetting();
                s.setId(rs.getInt("id"));
                s.setSettingKey(rs.getString("setting_key"));
                s.setSettingValue(rs.getString("setting_value"));
                s.setDescription(rs.getString("description"));
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, stmt, rs);
        }
        return null;
    }

    public boolean save(SystemSetting setting) {
        if (setting.getId() > 0) {
            String sql = "UPDATE system_setting SET setting_value=?, description=? WHERE id=?";
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                conn = DBUtil.getConnection();
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, setting.getSettingValue());
                stmt.setString(2, setting.getDescription());
                stmt.setInt(3, setting.getId());
                return stmt.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            } finally {
                DBUtil.close(conn, stmt);
            }
        } else {
            String sql = "INSERT INTO system_setting (setting_key, setting_value, description) VALUES (?, ?, ?)";
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                conn = DBUtil.getConnection();
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, setting.getSettingKey());
                stmt.setString(2, setting.getSettingValue());
                stmt.setString(3, setting.getDescription());
                return stmt.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            } finally {
                DBUtil.close(conn, stmt);
            }
        }
    }
}
