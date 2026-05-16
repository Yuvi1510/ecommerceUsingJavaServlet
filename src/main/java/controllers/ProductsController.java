package controllers;

import dao.CategoryDao;
import dao.CategoryDaoImpl;
import dao.ProductsDao;
import dao.ProductsDaoImpl;
import enums.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Category;
import model.Product;
import model.User;
import util.ModelUtils;
import util.SessionUtil;

import javax.management.modelmbean.ModelMBean;
import java.io.IOException;
import java.util.List;

@WebServlet({"/dashboard/products","/shop","/singleProduct"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2 MB
maxFileSize = 1024 * 1024 * 10, // 10 MB
maxRequestSize = 1024 * 1024 * 50) // 50 MB
public class ProductsController extends HttpServlet {
    ProductsDao productsDao = new ProductsDaoImpl();
    CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // remove the msg from session
        String success = (String) SessionUtil.getAttribute(req, "success");
        if (success != null) {
            req.setAttribute("success", success);
            SessionUtil.removeAttribute(req, "success");
        }
        String error = (String) SessionUtil.getAttribute(req, "error");
        if (error != null) {
            req.setAttribute("error", error);
            SessionUtil.removeAttribute(req, "error");
        }

        String uri = req.getRequestURI();
        System.out.println(uri);

        String contextPath = req.getContextPath();
        System.out.println(contextPath);

        String path = uri.substring(contextPath.length());
        System.out.println(path);

        User user = (User) SessionUtil.getAttribute(req, "user");

        // /products is only for admin so
        // if not log ined or if the user does not have an admin role then send back to auth
//        if(path.contains("/products") && (user == null || !user.hasRole(Role.ROLE_ADMIN))){
//            SessionUtil.setAttribute(req, "error", "Please login if you are an admin!");
//            resp.sendRedirect(req.getContextPath() + "/login");
//            return;
//        }



        if(action == null){
            List<Product> products = productsDao.findAllProducts();
            List<Category> categories = categoryDao.getAllCategories();
            req.setAttribute("products", products);
            req.setAttribute("categories", categories);

            for(Product product: products){
                System.out.println(product.getName());
            }

            if(path.contains("/dashboard/products")){
            req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req,resp);

            } else if (path.contains("/shop")) {
                System.out.println("forwarding to shop");
                req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req,resp);
            } else if (path.contains("/singleProduct")) {
                int id = Integer.parseInt(req.getParameter("id"));

                Product product = productsDao.findProductById(id);

                req.setAttribute("product", product);
                req.getRequestDispatcher("/WEB-INF/views/single.jsp").forward(req,resp);

            }
        }else if (action.equals("findProductsByName")) {
            String name = req.getParameter("name");

            List<Product> products = productsDao.findProductsByName(name);
            req.setAttribute("products", products);
            req.setAttribute("categories", categoryDao.getAllCategories());

            if(products == null){
                req.setAttribute("error", "No products found!");
            }

            if(path.contains("/dashboard/products")){
                req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req,resp);

            }else {
                req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req,resp);
            }



        } else if (action.equals("findProductsByCategory")) {
            int categoryId = Integer.parseInt(req.getParameter("category"));
            List<Product> products = productsDao.findProductsByCategory(categoryId);

            if(products == null){
                req.setAttribute("error", "No products found!");
            }
            req.setAttribute("products", products);
            // while doing forward we need to add categories as well
            // otherwise when we click on find products by category, categories will be null and no options will be shown
            req.setAttribute("categories",categoryDao.getAllCategories());
            if(path.contains("/dashboard/products")){
                req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req,resp);

            }else {
                req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req,resp);
            }

        } else if (action.equals("findProductsById")) {
            int id = Integer.parseInt(req.getParameter("productId"));

            Product product = productsDao.findProductById(id);
            if(product == null){
                req.setAttribute("error", "No products found!");
//                req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, resp);

            }else {
                req.setAttribute("products", List.of(product));
                req.setAttribute("categories",categoryDao.getAllCategories());
            }
            if(path.contains("/dashboard/products")){
                req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req,resp);

            }else {
                req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req,resp);
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if(action.equals("add")){

            boolean success = productsDao.addProduct(req);

            if(!success) {
                SessionUtil.setAttribute(req,"error", "Unable to add product");
                req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);
            }
                SessionUtil.setAttribute(req,"success", "Product added successfully");
            resp.sendRedirect(req.getContextPath() +"/dashboard/products");
        } else if (action.equals("edit")) {
            Product product = ModelUtils.getProductFromRequest(req);
            int id = Integer.parseInt(req.getParameter("id"));
            boolean success = productsDao.updateProduct(req,id);

            if(!success){
                SessionUtil.setAttribute(req,"error", "Unable to update product!");
            }else {
                SessionUtil.setAttribute(req,"success","Product updated successfully!");
                req.setAttribute("products", List.of(product));
                req.setAttribute("categories",categoryDao.getAllCategories());
            }
            req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);

        } else if (action.equals("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));

            boolean success = productsDao.deleteProduct(id);

            if(!success){
                SessionUtil.setAttribute(req, "error", "No products found!");
                req.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(req, resp);

            }else {
                SessionUtil.setAttribute(req, "success", "Product deleted successfully");

            }
            resp.sendRedirect(req.getContextPath() +"/dashboard/products");

        }
    }
}
