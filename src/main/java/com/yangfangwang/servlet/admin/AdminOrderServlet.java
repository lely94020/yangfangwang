package com.yangfangwang.servlet.admin;

import com.yangfangwang.dao.OrderDao;
import com.yangfangwang.util.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/order")
public class AdminOrderServlet extends HttpServlet {

    private OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listOrders(req, resp);
                break;
            case "detail":
                viewDetail(req, resp);
                break;
            default:
                listOrders(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("status".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            int status = Integer.parseInt(req.getParameter("status"));
            orderDao.updateStatus(id, status);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            orderDao.delete(id);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/order?action=list");
    }

    private void listOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }
        PageUtil pageUtil = new PageUtil(8);
        pageUtil.setCurrentPage(page);

        req.setAttribute("orders", orderDao.findAll(pageUtil));
        req.setAttribute("page", pageUtil);
        req.getRequestDispatcher("/admin/order/list.jsp").forward(req, resp);
    }

    private void viewDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        req.setAttribute("order", orderDao.findById(id));
        req.getRequestDispatcher("/admin/order/detail.jsp").forward(req, resp);
    }
}
