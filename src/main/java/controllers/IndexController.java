package controllers;

import dao.ProductsDao;
import dao.ProductsDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/home")
public class IndexController extends HttpServlet {

    ProductsDao productsDao = new ProductsDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req,resp);
        List<Product> products = productsDao.findAllProducts();

        Collections.shuffle(products);
        List<Product> topPicks = products.subList(0, Math.min(products.size(), 4));
        req.setAttribute("topPicks", topPicks);
    }

//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        super.doPost(req, resp);
//    }
}
