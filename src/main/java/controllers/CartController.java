package controllers;

import dao.CartDao;
import dao.CartDaoImpl;
import dao.ProductsDao;
import dao.ProductsDaoImpl;
import dto.CartItemDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.Product;
import model.User;
import util.SessionUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    CartDao cartDao = new CartDaoImpl();
    ProductsDao productsDao = new ProductsDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User user = (User) SessionUtil.getAttribute(req, "user");


        if(action==null){
            List<CartItemDto> cartItems = cartDao.getAllCartItems(user.getUserId());
            req.setAttribute("cartItems", cartItems);
            req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User user = (User) SessionUtil.getAttribute(req, "user");

        if("add".equals(action)){
            int productId = Integer.parseInt(req.getParameter("productId"));
            boolean success = cartDao.addToCart(user.getUserId(), productId);
             // get the product
            Product product = productsDao.findProductById(productId);
            // set the product in the request
            req.setAttribute("product", product);
            if(success){
                // attach a success msg
                req.setAttribute("success", "Product successfully added to cart");
            }else {

                req.setAttribute("error", "Failed to add product to cart");
            }
            req.getRequestDispatcher("/WEB-INF/views/single.jsp").forward(req,resp);
        }else if("remove".equals(action)){
            int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
            boolean success = cartDao.removeFromCart(user.getUserId(), cartItemId);
        }
    }
}
