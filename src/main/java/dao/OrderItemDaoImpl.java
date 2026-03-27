package dao;

import model.CartItem;
import model.OrderItem;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.ModelUtils;

public class OrderItemDaoImpl implements OrderItemDao {
        ProductsDao productsDao = new ProductsDaoImpl();



    @Override
    public boolean addOrderItem(OrderItem item) {


        String query = "INSERT INTO order_items(order_quantity, amount, order_id, product_id) VALUES(?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, item.getOrderQuantity());
            ps.setDouble(2, item.getAmount() >0 ? item.getAmount() : 0.0);
            ps.setInt(3, item.getOrderId());
            ps.setInt(4, item.getProductId());


            int rowsAffected = ps.executeUpdate();

           return  rowsAffected >=1;


        } catch (SQLException e) {
            System.out.println("Error adding order item: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    @Override
    public boolean deleteOrderItem(int orderItemId) {
        String query = "DELETE FROM order_items WHERE order_item_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderItemId);
            int rowsAffected = ps.executeUpdate();

            return rowsAffected>=1;
        } catch (SQLException e) {
            System.out.println("Error deleting order item: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateOrderItemQuantity(int itemId, int quantity) {
        if (quantity <= 0) {
            System.out.println("Quantity must be greater than 0");
            return false;
        }

        String query = "UPDATE order_items SET order_quantity = ?, amount = ? WHERE order_item_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            double productPrice = getProductPriceForOrderItem(itemId);


            double newAmount = productPrice * quantity;

            ps.setInt(1, quantity);
            ps.setDouble(2, newAmount);
            ps.setInt(3, itemId);

            int rowsAffected = ps.executeUpdate();

            return rowsAffected>=1;

        } catch (SQLException e) {
            System.out.println("Error updating order item quantity: " + e.getMessage());

            return false;
        }
    }


    private double getProductPriceForOrderItem(int orderItemId) {
        String query = "SELECT p.price FROM order_items oi INNER JOIN products p ON oi.product_id = p.product_id WHERE oi.order_item_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderItemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("price");
            }

        } catch (SQLException e) {
            System.out.println("Error getting product price: " + e.getMessage());
        }

        return 0.0;
    }

    @Override
    public List<OrderItem> findOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = ModelUtils.getOrderItemFromResultSet(rs);
                orderItems.add(item);
            }

        } catch (SQLException e) {
            System.out.println("Error finding order items by order ID: " + e.getMessage());
            e.printStackTrace();
        }

        return orderItems;
    }

    @Override
    public boolean deleteOrderItemsByOrderId(int orderId) {
        String query = "DELETE FROM order_items WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Deleted " + rowsAffected + " order items for order ID: " + orderId);
            return rowsAffected >= 1;

        } catch (SQLException e) {
            System.out.println("Error deleting order items by order ID: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


//    public int getOrderItemCount(int orderId) {
//        String query = "SELECT COUNT(*) as count FROM order_items WHERE order_id = ?";
//
//        try (Connection connection = DatabaseConnection.getConnection();
//             PreparedStatement ps = connection.prepareStatement(query)) {
//
//            ps.setInt(1, orderId);
//            ResultSet rs = ps.executeQuery();
//
//            if (rs.next()) {
//                return rs.getInt("count");
//            }
//
//        } catch (SQLException e) {
//            System.out.println("Error getting order item count: " + e.getMessage());
//            e.printStackTrace();
//        }
//
//        return 0;
//    }


}