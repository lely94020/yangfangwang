package com.yangfangwang.servlet.front;

import com.yangfangwang.dao.MemberDao;
import com.yangfangwang.model.Member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private MemberDao memberDao = new MemberDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "用户名和密码不能为空");
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            return;
        }

        Member member = memberDao.findByUsername(username);
        if (member != null && member.getPassword().equals(password)) {
            if (member.getStatus() == 1) {
                HttpSession session = req.getSession();
                session.setAttribute("member", member);
                resp.sendRedirect(req.getContextPath() + "/");
            } else if (member.getStatus() == 0) {
                req.setAttribute("error", "您的账户正在审核中，请耐心等待");
                req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "您的账户已被禁用");
                req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "用户名或密码错误");
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        }
    }
}
