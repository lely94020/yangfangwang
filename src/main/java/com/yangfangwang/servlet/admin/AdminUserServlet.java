package com.yangfangwang.servlet.admin;

import com.yangfangwang.dao.UserDao;
import com.yangfangwang.dao.RoleDao;
import com.yangfangwang.model.User;
import com.yangfangwang.util.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/user")
public class AdminUserServlet extends HttpServlet {

    private UserDao userDao = new UserDao();
    private RoleDao roleDao = new RoleDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listUsers(req, resp);
                break;
            case "add":
                req.setAttribute("roles", roleDao.findAll());
                req.getRequestDispatcher("/admin/user/add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("user", userDao.findById(id));
                req.setAttribute("roles", roleDao.findAll());
                req.getRequestDispatcher("/admin/user/edit.jsp").forward(req, resp);
                break;
            default:
                listUsers(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            User u = new User();
            u.setUsername(req.getParameter("username"));
            u.setPassword(req.getParameter("password"));
            u.setRealName(req.getParameter("realName"));
            u.setEmail(req.getParameter("email"));
            u.setPhone(req.getParameter("phone"));
            u.setRoleId(Integer.parseInt(req.getParameter("roleId")));
            u.setStatus(Integer.parseInt(req.getParameter("status")));
            userDao.insert(u);
        } else if ("edit".equals(action)) {
            User u = new User();
            u.setId(Integer.parseInt(req.getParameter("id")));
            u.setRealName(req.getParameter("realName"));
            u.setEmail(req.getParameter("email"));
            u.setPhone(req.getParameter("phone"));
            u.setRoleId(Integer.parseInt(req.getParameter("roleId")));
            u.setStatus(Integer.parseInt(req.getParameter("status")));
            String pwd = req.getParameter("password");
            if (pwd != null && !pwd.isEmpty()) u.setPassword(pwd);
            userDao.update(u);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            userDao.delete(id);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/user?action=list");
    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        if (req.getParameter("page") != null) page = Integer.parseInt(req.getParameter("page"));
        PageUtil pageUtil = new PageUtil(8);
        pageUtil.setCurrentPage(page);
        req.setAttribute("users", userDao.findAll(pageUtil));
        req.setAttribute("page", pageUtil);
        req.getRequestDispatcher("/admin/user/list.jsp").forward(req, resp);
    }
}
