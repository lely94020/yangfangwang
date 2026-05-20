package com.yangfangwang.servlet.admin;

import com.yangfangwang.dao.MemberDao;
import com.yangfangwang.util.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/member")
public class AdminMemberServlet extends HttpServlet {

    private MemberDao memberDao = new MemberDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                int page = 1;
                if (req.getParameter("page") != null) page = Integer.parseInt(req.getParameter("page"));
                PageUtil pageUtil = new PageUtil(8);
                pageUtil.setCurrentPage(page);
                req.setAttribute("members", memberDao.findAll(pageUtil));
                req.setAttribute("page", pageUtil);
                req.getRequestDispatcher("/admin/member/list.jsp").forward(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin/member?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("status".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            int status = Integer.parseInt(req.getParameter("status"));
            memberDao.updateStatus(id, status);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            memberDao.delete(id);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/member?action=list");
    }
}
