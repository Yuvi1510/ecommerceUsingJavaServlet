package controllers;

import dao.OrderDao;
import dao.OrderDaoImpl;
import dto.OrderDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.Order;
import model.User;
import util.ModelUtils;
import enums.OrderStatus;
import util.SessionUtil;

import java.io.IOException;
import java.util.List;

@WebServlet({"/order","/my-orders"})
public class OrderController extends HttpServlet {
    OrderDao orderDao = new OrderDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println("getting otders");
        String action = req.getParameter("action");
        User user = (User) SessionUtil.getAttribute(req, "user");

        if(user == null){
            req.setAttribute("error", "Please login first!");
            req.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(req, resp);
            return;
        }

        if(action == null){
            List<OrderDto> orders = orderDao.findOrderByUserId(user.getUserId());

            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/WEB-INF/views/order.jsp").forward(req,resp);
        }else if ("cancel".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));

            boolean success = orderDao.updateOrderStatus(id, OrderStatus.CANCELLED);

            if(success){
                req.setAttribute("success", "Order successfully cancelled");
            }else {

                req.setAttribute("error", "Failed to cancel order");
            }

            List<OrderDto> orders = orderDao.findOrderByUserId(user.getUserId());

            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/WEB-INF/views/order.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User user = (User) SessionUtil.getAttribute(req, "user");

        if(user == null){
            req.setAttribute("error", "Please login first!");
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

            boolean success = orderDao.buyNow(order, List.of(cartItem));

            if(success){
                System.out.println("New order created!");
                List<OrderDto> orders = orderDao.findOrderByUserId(user.getUserId());
                req.setAttribute("orders", orders);
                req.setAttribute("success","Order created successfully");
                req.getRequestDispatcher("/WEB-INF/views/order.jsp").forward(req,resp);
            }else {
                System.out.println("something went wrong");
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else if ("create".equals(action)) {
            System.out.println("Creating order");
            boolean success = orderDao.createOrder(user.getUserId());
            if(success){
                System.out.println("New order created!");
                List<OrderDto> orders = orderDao.findOrderByUserId(user.getUserId());
                req.setAttribute("orders", orders);
                req.setAttribute("success","Order created successfully");
                req.getRequestDispatcher("/WEB-INF/views/order.jsp").forward(req,resp);
            }else {
                System.out.println("something went wrong");
                resp.sendRedirect(req.getContextPath() + "/cart");
            }

        }
    }
}
