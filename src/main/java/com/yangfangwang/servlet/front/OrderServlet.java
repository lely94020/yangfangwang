package com.yangfangwang.servlet.front;

import com.yangfangwang.dao.OrderDao;
import com.yangfangwang.model.Member;
import com.yangfangwang.model.Order;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private OrderDao orderDao = new OrderDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Member member = (session != null) ? (Member) session.getAttribute("member") : null;
        if (member == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                List<Order> orders = orderDao.findByMemberId(member.getId());
                req.setAttribute("orders", orders);
                req.getRequestDispatcher("/pages/order.jsp").forward(req, resp);
                break;
            case "view":
                int id = Integer.parseInt(req.getParameter("id"));
                Order order = orderDao.findById(id);
                if (order == null || order.getMemberId() != member.getId()) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                req.setAttribute("order", order);
                req.getRequestDispatcher("/pages/orderDetail.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("orders", orderDao.findByMemberId(member.getId()));
                req.getRequestDispatcher("/pages/order.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Member member = (session != null) ? (Member) session.getAttribute("member") : null;
        if (member == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if ("cancel".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Order order = orderDao.findById(id);
            if (order != null && order.getMemberId() == member.getId()) {
                orderDao.updateStatus(id, 4);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/order?action=list");
    }
}
