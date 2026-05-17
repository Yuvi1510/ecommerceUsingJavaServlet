package controllers;

import dao.*;
import dto.CartItemDto;
import dto.OrderDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.Order;
import model.Product;
import model.User;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Or;
import util.ModelUtils;
import enums.OrderStatus;
import util.SessionUtil;

import java.io.IOException;
import java.util.List;

@WebServlet({"/dashboard/orders","/my-orders","/orders"})
public class OrderController extends HttpServlet {
    OrderDao orderDao = new OrderDaoImpl();
    CartDao cartDao = new CartDaoImpl();
    ProductsDao productsDao = new ProductsDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User user = (User) SessionUtil.getAttribute(req, "user");

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
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        if(action == null){

            if(path.contains("/my-order")){
                List<OrderDto> orders = orderDao.findOrderByUserId(user.getUserId());
                req.setAttribute("orders", orders);

                req.getRequestDispatcher("/WEB-INF/views/order.jsp").forward(req,resp);
            }else if(path.contains("/dashboard/orders")){
                List<OrderDto> orders = orderDao.findAllOrders();
                req.setAttribute("orders", orders);

                req.getRequestDispatcher("/WEB-INF/views/admin/adminOrders.jsp").forward(req,resp);
            }
        }else if ("cancel".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));

            boolean successful = orderDao.updateOrderStatus(id, OrderStatus.CANCELLED);

            if(successful){
                SessionUtil.setAttribute(req, "success", "Order successfully cancelled");
            }else {
                SessionUtil.setAttribute(req, "error", "Failed to cancel order");
            }

           resp.sendRedirect(req.getContextPath() + "/my-orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User user = (User) SessionUtil.getAttribute(req, "user");

        if(user == null){
            SessionUtil.setAttribute(req, "error", "Please login first!");
            req.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(req, resp);
            return;
        }

        if("buy-now".equals(action)){
            System.out.println(req.getParameter("id"));
            System.out.println(req.getParameter("subTotal"));
            Order order = ModelUtils.getOrderFromRequest(req);
            order.setUserId(user.getUserId());

            int productId = Integer.parseInt(req.getParameter("id"));

//            int quantity = Integer.parseInt(req.getParameter("quantity"));
            double amount = Double.parseDouble(req.getParameter("subTotal"));

//            OrderItem orderItem = new OrderItem(productId, quantity, amount);

            CartItem cartItem = new CartItem(1, amount, 0, productId);

            boolean success = orderDao.buyNow(order, cartItem);

            if(success){
                SessionUtil.setAttribute(req, "success", "Order created successfully");
                resp.sendRedirect(req.getContextPath() + "/my-orders");
            }else {
                SessionUtil.setAttribute(req, "error", "Failed to create order");
                resp.sendRedirect(req.getContextPath() + "/shop");
            }
        } else if ("create".equals(action)) {
            System.out.println("Creating order");
            boolean success = orderDao.createOrder(user.getUserId());
            if(success){
                SessionUtil.setAttribute(req, "success", "Order created successfully");
                resp.sendRedirect(req.getContextPath() + "/my-orders");
            }else {
                SessionUtil.setAttribute(req, "error", "Failed to create order");
                resp.sendRedirect(req.getContextPath() + "/cart");
            }

        } else if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            OrderStatus orderStatus = OrderStatus.valueOf(req.getParameter("status"));

            boolean success = orderDao.updateOrderStatus(orderId, orderStatus);

            if(success){
                SessionUtil.setAttribute(req, "success", "Order status successfully updated");
            }else {
                SessionUtil.setAttribute(req, "error", "Failed to update order status");
            }
            resp.sendRedirect(req.getContextPath() + "/dashboard/orders");
        }
    }
}