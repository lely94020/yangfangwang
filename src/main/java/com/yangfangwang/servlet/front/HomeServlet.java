package com.yangfangwang.servlet.front;

import com.yangfangwang.dao.ProductDao;
import com.yangfangwang.util.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PageUtil page = new PageUtil(5);
        page.setCurrentPage(1);
        req.setAttribute("featuredProducts", productDao.findOnline(page));
        req.setAttribute("homeEssentials", productDao.findOnlineByCategories("1,2", 10));
        req.setAttribute("healthCare", productDao.findOnlineByCategories("5,6", 10));
        req.getRequestDispatcher("/pages/index.jsp").forward(req, resp);
    }
}
