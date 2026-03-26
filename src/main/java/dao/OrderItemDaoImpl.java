package dao;

import model.OrderItem;

import java.util.List;

public class OrderItemDaoImpl implements  OrderItemDao{
    @Override
    public boolean addOrderItem(List<OrderItem> items) {
        return false;
    }

    @Override
    public boolean deleteOrderItem(int orderItemId) {
        return false;
    }

    @Override
    public boolean updateOrderItemQuantity(int quantity) {
        return false;
    }
}
