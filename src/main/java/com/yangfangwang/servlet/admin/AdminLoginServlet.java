package com.yangfangwang.servlet.admin;

import com.yangfangwang.dao.UserDao;
import com.yangfangwang.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("adminUser") != null) {
            resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "用户名和密码不能为空");
            req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
            return;
        }

        User user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password) && user.getStatus() == 1) {
            HttpSession session = req.getSession();
            session.setAttribute("adminUser", user);
            resp.sendRedirect(req.getContextPath() + "/admin/index.jsp");
        } else {
            req.setAttribute("error", "用户名或密码错误，或账户已被禁用");
            req.getRequestDispatcher("/admin/login.jsp").forward(req, resp);
        }
    }
}
