package dao;

import model.CartItem;
import model.OrderItem;

import java.util.List;

public interface OrderItemDao {
    boolean addOrderItem(OrderItem item);
    boolean deleteOrderItem(int orderItemId);
    boolean updateOrderItemQuantity(int itemId, int quantity);
    List<OrderItem> findOrderItemsByOrderId(int orderId);
    boolean deleteOrderItemsByOrderId(int orderId);
}
