package com.yangfangwang.servlet.admin;

import com.yangfangwang.dao.RoleDao;
import com.yangfangwang.model.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/role")
public class AdminRoleServlet extends HttpServlet {

    private RoleDao roleDao = new RoleDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                req.setAttribute("roles", roleDao.findAll());
                req.getRequestDispatcher("/admin/role/list.jsp").forward(req, resp);
                break;
            case "add":
                req.getRequestDispatcher("/admin/role/add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("role", roleDao.findById(id));
                req.getRequestDispatcher("/admin/role/edit.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("roles", roleDao.findAll());
                req.getRequestDispatcher("/admin/role/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            Role r = new Role();
            r.setName(req.getParameter("name"));
            r.setDescription(req.getParameter("description"));
            roleDao.insert(r);
        } else if ("edit".equals(action)) {
            Role r = new Role();
            r.setId(Integer.parseInt(req.getParameter("id")));
            r.setName(req.getParameter("name"));
            r.setDescription(req.getParameter("description"));
            roleDao.update(r);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            roleDao.delete(id);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/role?action=list");
    }
}
