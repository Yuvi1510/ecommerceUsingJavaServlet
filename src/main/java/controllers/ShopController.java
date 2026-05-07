//package controllers;
//
//import dao.CategoryDao;
//import dao.CategoryDaoImpl;
//import dao.ProductsDao;
//import dao.ProductsDaoImpl;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import model.Category;
//import model.Product;
//
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/shop")
//public class ShopController extends HttpServlet {
//    ProductsDao productsDao = new ProductsDaoImpl();
//    CategoryDao categoryDao = new CategoryDaoImpl();
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String action = req.getParameter("action");
//
//        if(action == null){
//            List<Product> products = productsDao.findAllProducts();
//            List<Category> categories = categoryDao.getAllCategories();
//            req.setAttribute("products", products);
//            req.setAttribute("categories", categories);
//            req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req,resp);
//        } else if (action.equals("findProductsByName")) {
//            String name = req.getParameter("name");
//
//            List<Product> products = productsDao.findProductsByName(name);
//
//            if(products == null){
//                req.setAttribute("error", "No products found!");
//                req.setAttribute("categories", categoryDao.getAllCategories());
//                req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req, resp);
//
//            }
//
//            resp.sendRedirect(req.getContextPath() +"/products");
//
//        } else if (action.equals("findProductsByCategory")) {
//            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
//            List<Product> products = productsDao.findProductsByCategory(categoryId);
//
//            if(products == null){
//                req.setAttribute("error", "No products found!");
//                req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req, resp);
//
//            }
//            req.setAttribute("products", products);
//            // while doing forward we need to add categories as well
//            // otherwise when we click on find products by category, categories will be null and no options will be shown
//            req.setAttribute("categories",categoryDao.getAllCategories());
//            req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req, resp);
//
//        }
//        else if (action.equals("findProductsById")) {
//            int id = Integer.parseInt(req.getParameter("productId"));
//
//            Product product = productsDao.findProductById(id);
//            if(product == null){
//                req.setAttribute("error", "No products found!");
////                req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, resp);
//
//            }else {
//                req.setAttribute("products", List.of(product));
//                req.setAttribute("categories",categoryDao.getAllCategories());
//            }
//            req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req, resp);
//
//        }
//    }
//}
