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

        // if np user in session then redirect to login
        if(user == null){
            SessionUtil.setAttribute(req, "error", "Please login first!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }


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

        // if user is null then user is not logged in so show error msg
        if(user == null){
            req.setAttribute("error", "Please login first!");
            req.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(req, resp);
            return;
        }

        if("add".equals(action)){
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            if(quantity <=0 ){
                req.setAttribute("error", "Quantity must be greater than 0");
                Product product = productsDao.findProductById(productId);

                req.setAttribute("product", product);
                req.getRequestDispatcher("/WEB-INF/views/single.jsp").forward(req,resp);
            }
            boolean success = cartDao.addToCart(user.getUserId(), productId, quantity);
             // get the product
            Product product = productsDao.findProductById(productId);
            // set the product in the request
            req.setAttribute("product", product);
            if(success){
                // attach a success msg
                req.setAttribute("success", "Product successfully added to cart");
            }else {

                req.setAttribute( "error", "Failed to add product to cart");
            }
            req.getRequestDispatcher("/WEB-INF/views/single.jsp").forward(req,resp);
        }else if("remove".equals(action)){
            int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
            boolean success = cartDao.removeFromCart(user.getUserId(), cartItemId);

            if(success){
                // attach a success msg
                SessionUtil.setAttribute(req,"success", "Item successfully removed");
            }else {

                SessionUtil.setAttribute(req,"error", "Failed to remove item");
            }
           resp.sendRedirect(req.getContextPath() + "/cart");

        }else if("updateQuantity".equals(action)){
            int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            boolean success = cartDao.updateCartItemQuantity(user.getUserId(), cartItemId, quantity);

            if(success){
                // attach a success msg
                SessionUtil.setAttribute(req,"success", "Item quantity successfully updated");
            }else {

                SessionUtil.setAttribute(req, "error", "Failed to update item quantity");
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}
