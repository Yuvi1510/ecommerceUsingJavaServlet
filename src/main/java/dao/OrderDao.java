package dao;

import model.CartItem;
import model.Order;
import model.OrderItem;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Or;
import util.OrderStatus;

import java.time.LocalDate;
import java.util.List;

public interface OrderDao {
    boolean addOrder(Order order, List<CartItem> productIds);
    List<Order> findAllOrders();
    Order findOrderById(int orderId);
    List<Order> findOrderByUserId(int userId);
    List<Order> findOrderByUserEmail(String email);
    List<Order> findOrderByStatus(OrderStatus orderStatus);
    boolean updateOrder(Order order, int orderId);
    boolean deleteOrder(int orderId);
    List<Order> findOrdersByDateRange(LocalDate startDate, LocalDate endDate);
    boolean updateOrderStatus(int orderId, OrderStatus newStatus);
}
