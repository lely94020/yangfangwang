package com.yangfangwang.servlet.front;

import com.yangfangwang.dao.CartDao;
import com.yangfangwang.dao.OrderDao;
import com.yangfangwang.dao.MemberDao;
import com.yangfangwang.model.Cart;
import com.yangfangwang.model.Member;
import com.yangfangwang.model.Order;
import com.yangfangwang.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartDao cartDao = new CartDao();
    private OrderDao orderDao = new OrderDao();
    private MemberDao memberDao = new MemberDao();

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
                List<Cart> cartList = cartDao.findByMemberId(member.getId());
                req.setAttribute("cartItems", cartList);
                req.getRequestDispatcher("/pages/cart.jsp").forward(req, resp);
                break;
            case "count":
                int count = cartDao.countByMemberId(member.getId());
                resp.setContentType("application/json");
                resp.getWriter().write("{\"count\": " + count + "}");
                break;
            default:
                req.setAttribute("cartItems", cartDao.findByMemberId(member.getId()));
                req.getRequestDispatcher("/pages/cart.jsp").forward(req, resp);
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
        if ("add".equals(action)) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = 1;
            if (req.getParameter("quantity") != null) {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            }
            cartDao.addOrUpdate(member.getId(), productId, quantity);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            cartDao.updateQuantity(id, quantity);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            cartDao.delete(id);
        } else if ("checkout".equals(action)) {
            // checkout - create order from cart
            String consignee = req.getParameter("consignee");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");

            Member fullMember = memberDao.findById(member.getId());

            List<Cart> cartItems = cartDao.findByMemberId(member.getId());
            if (cartItems.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/cart");
                return;
            }

            double total = 0;
            for (Cart item : cartItems) {
                total += item.getSubtotal();
            }

            String orderNo = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date())
                    + String.format("%04d", member.getId());

            Order order = new Order();
            order.setOrderNo(orderNo);
            order.setMemberId(member.getId());
            order.setTotalAmount(total);
            order.setStatus(0);
            order.setConsignee(consignee != null ? consignee : fullMember.getRealName());
            order.setPhone(phone != null ? phone : fullMember.getPhone());
            order.setAddress(address != null ? address : fullMember.getAddress());

            int orderId = orderDao.insert(order);
            if (orderId > 0) {
                for (Cart item : cartItems) {
                    OrderItem oi = new OrderItem();
                    oi.setOrderId(orderId);
                    oi.setProductId(item.getProductId());
                    oi.setProductName(item.getProductName());
                    oi.setPrice(item.getPrice());
                    oi.setQuantity(item.getQuantity());
                    oi.setSubtotal(item.getSubtotal());
                    orderDao.insertItem(oi);
                }
                cartDao.deleteByMemberId(member.getId());
                resp.sendRedirect(req.getContextPath() + "/order?action=list");
                return;
            }
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
