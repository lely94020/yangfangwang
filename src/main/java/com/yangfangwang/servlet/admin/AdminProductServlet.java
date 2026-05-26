package com.yangfangwang.servlet.admin;

import com.yangfangwang.dao.CategoryDao;
import com.yangfangwang.dao.ProductDao;
import com.yangfangwang.model.Product;
import com.yangfangwang.util.PageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/product")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, fileSizeThreshold = 1024 * 1024)
public class AdminProductServlet extends HttpServlet {

    private ProductDao productDao = new ProductDao();
    private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listProducts(req, resp);
                break;
            case "add":
                showAddForm(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "view":
                viewProduct(req, resp);
                break;
            default:
                listProducts(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                addProduct(req, resp);
                break;
            case "edit":
                updateProduct(req, resp);
                break;
            case "delete":
                deleteProduct(req, resp);
                break;
            case "status":
                updateStatus(req, resp);
                break;
            default:
                listProducts(req, resp);
        }
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }
        PageUtil pageUtil = new PageUtil(8);
        pageUtil.setCurrentPage(page);

        req.setAttribute("products", productDao.findAll(pageUtil));
        req.setAttribute("page", pageUtil);
        req.getRequestDispatcher("/admin/product/list.jsp").forward(req, resp);
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("categories", categoryDao.findAll());
        req.getRequestDispatcher("/admin/product/add.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        req.setAttribute("product", productDao.findById(id));
        req.setAttribute("categories", categoryDao.findAll());
        req.getRequestDispatcher("/admin/product/edit.jsp").forward(req, resp);
    }

    private void viewProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        req.setAttribute("product", productDao.findById(id));
        req.getRequestDispatcher("/admin/product/view.jsp").forward(req, resp);
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Product p = new Product();
        p.setName(req.getParameter("name"));
        p.setGenericName(req.getParameter("genericName"));
        p.setApprovalNumber(req.getParameter("approvalNumber"));
        p.setManufacturer(req.getParameter("manufacturer"));
        p.setSpecification(req.getParameter("specification"));
        p.setDosageForm(req.getParameter("dosageForm"));
        p.setDescription(req.getParameter("description"));
        p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        p.setPrice(Double.parseDouble(req.getParameter("price")));
        p.setStock(Integer.parseInt(req.getParameter("stock")));
        p.setStatus(req.getParameter("status") != null ? Integer.parseInt(req.getParameter("status")) : 0);
        p.setImageUrl(uploadFile(req));

        if (productDao.insert(p)) {
            resp.sendRedirect(req.getContextPath() + "/admin/product?action=list");
        } else {
            req.setAttribute("error", "添加商品失败");
            req.setAttribute("categories", categoryDao.findAll());
            req.getRequestDispatcher("/admin/product/add.jsp").forward(req, resp);
        }
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Product p = productDao.findById(id);
        if (p == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/product?action=list");
            return;
        }

        p.setName(req.getParameter("name"));
        p.setGenericName(req.getParameter("genericName"));
        p.setApprovalNumber(req.getParameter("approvalNumber"));
        p.setManufacturer(req.getParameter("manufacturer"));
        p.setSpecification(req.getParameter("specification"));
        p.setDosageForm(req.getParameter("dosageForm"));
        p.setDescription(req.getParameter("description"));
        p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        p.setPrice(Double.parseDouble(req.getParameter("price")));
        p.setStock(Integer.parseInt(req.getParameter("stock")));
        p.setStatus(req.getParameter("status") != null ? Integer.parseInt(req.getParameter("status")) : 0);

        String uploaded = uploadFile(req);
        if (uploaded != null) {
            p.setImageUrl(uploaded);
        }

        if (productDao.update(p)) {
            resp.sendRedirect(req.getContextPath() + "/admin/product?action=list");
        } else {
            req.setAttribute("error", "更新商品失败");
            req.setAttribute("product", p);
            req.setAttribute("categories", categoryDao.findAll());
            req.getRequestDispatcher("/admin/product/edit.jsp").forward(req, resp);
        }
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        productDao.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/product?action=list");
    }

    private void updateStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        int status = Integer.parseInt(req.getParameter("status"));
        productDao.updateStatus(id, status);
        resp.sendRedirect(req.getContextPath() + "/admin/product?action=list");
    }

    private String uploadFile(HttpServletRequest req) {
        try {
            Part filePart = req.getPart("imageFile");
            if (filePart == null || filePart.getSize() == 0) return null;

            String submittedFileName = filePart.getSubmittedFileName();
            if (submittedFileName == null || submittedFileName.isEmpty()) return null;

            String ext = "";
            int dot = submittedFileName.lastIndexOf('.');
            if (dot > 0) ext = submittedFileName.substring(dot);

            String fileName = UUID.randomUUID().toString() + ext;
            String uploadDir = "/Users/a1/IdeaProjects/yangfangwang/uploads/products";
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            filePart.write(uploadDir + File.separator + fileName);
            return "uploads/products/" + fileName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
