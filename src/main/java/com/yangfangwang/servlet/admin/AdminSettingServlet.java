package com.yangfangwang.servlet.admin;

import com.yangfangwang.dao.SystemSettingDao;
import com.yangfangwang.model.SystemSetting;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/setting")
public class AdminSettingServlet extends HttpServlet {

    private SystemSettingDao settingDao = new SystemSettingDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("settings", settingDao.findAll());
        req.getRequestDispatcher("/admin/setting/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String[] keys = req.getParameterValues("key");
        String[] values = req.getParameterValues("value");

        if (keys != null && values != null && keys.length == values.length) {
            for (int i = 0; i < keys.length; i++) {
                SystemSetting s = settingDao.findByKey(keys[i]);
                if (s == null) {
                    s = new SystemSetting();
                    s.setSettingKey(keys[i]);
                }
                s.setSettingValue(values[i]);
                settingDao.save(s);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/setting");
    }
}
