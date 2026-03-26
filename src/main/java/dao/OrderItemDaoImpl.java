package dao;

import model.OrderItem;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDaoImpl implements OrderItemDao {

    @Override
    public boolean addOrderItem(List<OrderItem> items) {
        if (items == null || items.isEmpty()) {
            System.out.println("No items to add");
            return false;
        }

        String query = "INSERT INTO order_items(order_quantity, amount, order_id, product_id) VALUES(?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            // Add all items to batch
            for (OrderItem item : items) {
                ps.setInt(1, item.getOrderQuantity());
                ps.setDouble(2, item.getAmount() != null ? item.getAmount() : 0.0);
                ps.setInt(3, item.getOrderId());
                ps.setInt(4, item.getProductId());
                ps.addBatch();
            }

            // Execute batch
            int[] affectedRows = ps.executeBatch();

            // Check if all items were added successfully
            for (int rows : affectedRows) {
                if (rows <= 0) {
                    System.out.println("Failed to add some order items");
                    return false;
                }
            }

            // Retrieve generated IDs
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                int index = 0;
                while (generatedKeys.next() && index < items.size()) {
                    items.get(index).setOrderItemId(generatedKeys.getInt(1));
                    index++;
                }
            }

            System.out.println("Successfully added " + items.size() + " order items");
            return true;

        } catch (SQLException e) {
            System.out.println("Error adding order items: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.out.println("Unexpected error adding order items: " + e.getMessage());
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

            if (rowsAffected >= 1) {
                System.out.println("Order item deleted successfully with ID: " + orderItemId);
                return true;
            } else {
                System.out.println("No order item found with ID: " + orderItemId);
                return false;
            }

        } catch (SQLException e) {
            System.out.println("Error deleting order item: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.out.println("Unexpected error deleting order item: " + e.getMessage());
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

            // First, get the product price to recalculate amount
            double productPrice = getProductPriceForOrderItem(itemId);

            // Calculate new amount
            double newAmount = productPrice * quantity;

            ps.setInt(1, quantity);
            ps.setDouble(2, newAmount);
            ps.setInt(3, itemId);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected >= 1) {
                System.out.println("Order item quantity updated successfully. New quantity: " + quantity);
                return true;
            } else {
                System.out.println("No order item found with ID: " + itemId);
                return false;
            }

        } catch (SQLException e) {
            System.out.println("Error updating order item quantity: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.out.println("Unexpected error updating order item quantity: " + e.getMessage());
            return false;
        }
    }

    // Additional helper methods

    /**
     * Get product price for an order item
     */
    private double getProductPriceForOrderItem(int orderItemId) {
        String query = "SELECT p.price FROM order_items oi " +
                "INNER JOIN products p ON oi.product_id = p.product_id " +
                "WHERE oi.order_item_id = ?";

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

    /**
     * Find order item by ID
     */
    public OrderItem findOrderItemById(int orderItemId) {
        String query = "SELECT * FROM order_items WHERE order_item_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderItemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractOrderItemFromResultSet(rs);
            }

        } catch (SQLException e) {
            System.out.println("Error finding order item by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Find all order items by order ID
     */
    public List<OrderItem> findOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = extractOrderItemFromResultSet(rs);
                orderItems.add(item);
            }

        } catch (SQLException e) {
            System.out.println("Error finding order items by order ID: " + e.getMessage());
            e.printStackTrace();
        }

        return orderItems;
    }

    /**
     * Find all order items by product ID
     */
    public List<OrderItem> findOrderItemsByProductId(int productId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String query = "SELECT * FROM order_items WHERE product_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = extractOrderItemFromResultSet(rs);
                orderItems.add(item);
            }

        } catch (SQLException e) {
            System.out.println("Error finding order items by product ID: " + e.getMessage());
            e.printStackTrace();
        }

        return orderItems;
    }

    /**
     * Delete all order items for a specific order
     */
    public boolean deleteOrderItemsByOrderId(int orderId) {
        String query = "DELETE FROM order_items WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Deleted " + rowsAffected + " order items for order ID: " + orderId);
            return rowsAffected >= 0;

        } catch (SQLException e) {
            System.out.println("Error deleting order items by order ID: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get total amount for an order
     */
    public double getOrderTotalAmount(int orderId) {
        String query = "SELECT SUM(amount) as total FROM order_items WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (SQLException e) {
            System.out.println("Error getting order total amount: " + e.getMessage());
            e.printStackTrace();
        }

        return 0.0;
    }

    /**
     * Update amount for an order item (recalculate based on current product price)
     */
    public boolean recalculateOrderItemAmount(int orderItemId) {
        String query = "UPDATE order_items oi " +
                "SET oi.amount = (SELECT p.price FROM products p WHERE p.product_id = oi.product_id) * oi.order_quantity " +
                "WHERE oi.order_item_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderItemId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 1;

        } catch (SQLException e) {
            System.out.println("Error recalculating order item amount: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Batch update multiple order items
     */
    public boolean updateOrderItemsBatch(List<OrderItem> items) {
        if (items == null || items.isEmpty()) {
            return false;
        }

        String query = "UPDATE order_items SET order_quantity = ?, amount = ? WHERE order_item_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            for (OrderItem item : items) {
                ps.setInt(1, item.getOrderQuantity());
                ps.setDouble(2, item.getAmount() != null ? item.getAmount() : 0.0);
                ps.setInt(3, item.getOrderItemId());
                ps.addBatch();
            }

            int[] affectedRows = ps.executeBatch();

            for (int rows : affectedRows) {
                if (rows <= 0) {
                    return false;
                }
            }

            return true;

        } catch (SQLException e) {
            System.out.println("Error updating order items batch: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get count of items in an order
     */
    public int getOrderItemCount(int orderId) {
        String query = "SELECT COUNT(*) as count FROM order_items WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }

        } catch (SQLException e) {
            System.out.println("Error getting order item count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Check if order item exists
     */
    public boolean orderItemExists(int orderItemId) {
        String query = "SELECT COUNT(*) FROM order_items WHERE order_item_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderItemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.out.println("Error checking order item existence: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Helper method to extract OrderItem from ResultSet
     */
    private OrderItem extractOrderItemFromResultSet(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem(
                rs.getInt("product_id"),
                rs.getInt("order_quantity")
        );

        item.setOrderItemId(rs.getInt("order_item_id"));
        item.setAmount(rs.getDouble("amount"));
        item.setOrderId(rs.getInt("order_id"));

        return item;
    }
}