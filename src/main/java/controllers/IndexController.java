package controllers;

import dao.ProductsDao;
import dao.ProductsDaoImpl;
import dao.ReportsDao;
import dao.ReportsDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import util.SessionUtil;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/home")
public class IndexController extends HttpServlet {

    ProductsDao productsDao = new ProductsDaoImpl();
    ReportsDao reportsDao = new ReportsDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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

        List<Product> products = productsDao.findAllProducts();

        Collections.shuffle(products);
        List<Product> topPicks = productsDao.findTopProducts();
        req.setAttribute("topPicks", topPicks);
        req.setAttribute("products", products);

//        List<Product> fashion = productsDao.findProductsByCategory()
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req,resp);
    }

//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);
//    }
}
