package com.yangfangwang.servlet.front;

import com.yangfangwang.dao.ProductDao;
import com.yangfangwang.model.Product;
import com.yangfangwang.util.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                productList(req, resp);
                break;
            case "view":
                viewProduct(req, resp);
                break;
            case "search":
                searchProduct(req, resp);
                break;
            default:
                productList(req, resp);
        }
    }

    private void productList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }
        PageUtil pageUtil = new PageUtil(8);
        pageUtil.setCurrentPage(page);

        String categoryId = req.getParameter("categoryId");
        if (categoryId != null && !categoryId.isEmpty()) {
            req.setAttribute("products", productDao.findByCategory(Integer.parseInt(categoryId), pageUtil));
        } else {
            req.setAttribute("products", productDao.findOnline(pageUtil));
        }
        req.setAttribute("page", pageUtil);
        req.getRequestDispatcher("/pages/productList.jsp").forward(req, resp);
    }

    private void viewProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productDao.findById(id);
        if (product == null || product.getStatus() == 0) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        req.setAttribute("product", product);
        req.getRequestDispatcher("/pages/productDetail.jsp").forward(req, resp);
    }

    private void searchProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        int page = 1;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }
        PageUtil pageUtil = new PageUtil(8);
        pageUtil.setCurrentPage(page);

        req.setAttribute("products", productDao.search(keyword, pageUtil));
        req.setAttribute("page", pageUtil);
        req.setAttribute("keyword", keyword);
        req.getRequestDispatcher("/pages/productList.jsp").forward(req, resp);
    }
}
