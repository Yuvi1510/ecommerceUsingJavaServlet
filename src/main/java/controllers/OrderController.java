package controllers;

import dao.OrderDao;
import dao.OrderDaoImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.Order;
import model.OrderItem;
import model.User;
import util.ModelUtils;
import util.SessionUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/order")
public class OrderController extends HttpServlet {
    OrderDao orderDao = new OrderDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        User user = (User) SessionUtil.getAttribute(req, "user");

        if("create".equals(action)){
            System.out.println(req.getParameter("id"));
            System.out.println(req.getParameter("subTotal"));
            Order order = ModelUtils.getOrderFromRequest(req);
            order.setUserId(user.getUserId());

            int productId = Integer.parseInt(req.getParameter("id"));

//            int quantity = Integer.parseInt(req.getParameter("quantity"));
            double amount = Double.parseDouble(req.getParameter("subTotal"));

//            OrderItem orderItem = new OrderItem(productId, quantity, amount);

            CartItem cartItem = new CartItem(1, amount, 0, productId);

            boolean success = orderDao.addOrder(order, List.of(cartItem));

            if(success){
                System.out.println("New order created!");
            }else {
                System.out.println("something went wrong");
            }
        }
    }
}
