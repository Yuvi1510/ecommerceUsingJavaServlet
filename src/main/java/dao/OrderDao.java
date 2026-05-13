package dao;

import dto.OrderDto;
import model.CartItem;
import model.Order;
import enums.OrderStatus;

import java.time.LocalDate;
import java.util.List;

public interface OrderDao {
    boolean addOrder(Order order, List<CartItem> productIds);
    List<Order> findAllOrders();
    Order findOrderById(int orderId);
    List<OrderDto> findOrderByUserId(int userId);
    List<Order> findOrderByUserEmail(String email);
    List<Order> findOrderByStatus(OrderStatus orderStatus);
    boolean updateOrder(Order order, int orderId);
    boolean deleteOrder(int orderId);
    List<Order> findOrdersByDateRange(LocalDate startDate, LocalDate endDate);
    boolean updateOrderStatus(int orderId, OrderStatus newStatus);
}
