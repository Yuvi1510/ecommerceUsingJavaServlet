package dao;

import model.OrderItem;

import java.util.List;

public interface OrderItemDao {
    boolean addOrderItem(List<OrderItem> items);
    boolean deleteOrderItem(int orderItemId);
    boolean updateOrderItemQuantity(int quantity);
}
