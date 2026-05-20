package com.yangfangwang.servlet.front;

import com.yangfangwang.dao.MemberDao;
import com.yangfangwang.model.Member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private MemberDao memberDao = new MemberDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String realName = req.getParameter("realName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "用户名和密码不能为空");
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "两次密码输入不一致");
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
            return;
        }

        if (memberDao.findByUsername(username) != null) {
            req.setAttribute("error", "用户名已存在");
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
            return;
        }

        Member member = new Member();
        member.setUsername(username);
        member.setPassword(password);
        member.setRealName(realName);
        member.setPhone(phone);
        member.setEmail(email);
        member.setAddress(address);
        member.setStatus(0); // pending audit

        if (memberDao.insert(member)) {
            req.setAttribute("message", "注册成功！请等待管理员审核您的账户。");
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "注册失败，请稍后再试");
            req.getRequestDispatcher("/pages/register.jsp").forward(req, resp);
        }
    }
}
