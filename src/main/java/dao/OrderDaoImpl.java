package dao;

import model.Order;
import model.OrderItem;
import util.DatabaseConnection;
import util.ModelUtils;
import util.OrderStatus;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImpl implements OrderDao {

    @Override
    public boolean addOrder(Order order, List<OrderItem> productIds) {
        String query = "INSERT INTO orders(date, sub_total, tax_amount, delivery_charge, total_amount, status, user_id) VALUES(?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            ps.setDate(1, Date.valueOf(order.getDate()));
            ps.setDouble(2, order.getSubTotal());
            ps.setDouble(3, order.getTaxAmount());
            ps.setDouble(4, order.getDeliveryCharge());
            ps.setDouble(5, order.getTotalAmount());
            ps.setString(6, order.getOrderStatus().name());
            ps.setInt(7, order.getUserId());

            int rowsAffected = ps.executeUpdate();

            if(rowsAffected >= 1){

            }

        } catch (Exception e) {
            System.out.println("Error adding order: " + e.getMessage());
        }
        return false;
    }

    @Override
    public List<Order> findAllOrders() {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders ORDER BY order_id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = ModelUtils.getOrderFromResultSet(rs);
                orders.add(order);
            }

        } catch (Exception e) {
            System.out.println("Error finding all orders: " + e.getMessage());
        }

        return orders;
    }

    @Override
    public Order findOrderById(int orderId) {
        String query = "SELECT * FROM orders WHERE order_id = ? ";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return ModelUtils.getOrderFromResultSet(rs);
            }

        } catch (Exception e) {
            System.out.println("Error finding order by ID: " + e.getMessage());
        }

        return null;
    }

    @Override
    public List<Order> findOrderByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = ModelUtils.getOrderFromResultSet(rs);
                orders.add(order);
            }

        } catch (Exception e) {
            System.out.println("Error finding orders by user ID: " + e.getMessage());
        }

        return orders;
    }

    @Override
    public List<Order> findOrderByUserEmail(String email) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT o.* FROM orders o " +
                "INNER JOIN users u ON o.user_id = u.user_id " +
                "WHERE u.email = ? ORDER BY o.order_id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = ModelUtils.getOrderFromResultSet(rs);
                orders.add(order);
            }

        } catch (Exception e) {
            System.out.println("Error finding orders by user email: " + e.getMessage());
        }

        return orders;
    }

    @Override
    public List<Order> findOrderByStatus(OrderStatus orderStatus) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE status = ? ORDER BY order_id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, orderStatus.name());
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = ModelUtils.getOrderFromResultSet(rs);
                orders.add(order);
            }

        } catch (Exception e) {
            System.out.println("Error finding orders by status: " + e.getMessage());
        }

        return orders;
    }

    @Override
    public boolean updateOrder(Order order, int orderId) {
        String query = "UPDATE orders SET date = ?, sub_total = ?, tax_amount = ?, delivery_charge = ?, total_amount = ?, order_status = ?, user_id = ? WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setDate(1, Date.valueOf(order.getDate()));
            ps.setDouble(2, order.getSubTotal());
            ps.setDouble(3, order.getTaxAmount());
            ps.setDouble(4, order.getDeliveryCharge());
            ps.setDouble(5, order.getTotalAmount());
            ps.setString(6, order.getOrderStatus().name());
            ps.setInt(7, order.getUserId());
            ps.setInt(8, orderId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 1;

        } catch (Exception e) {
            System.out.println("Error updating order: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean deleteOrder(int orderId) {
        String query = "DELETE FROM orders WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, orderId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 1;

        } catch (Exception e) {
            System.out.println("Error deleting order: " + e.getMessage());
            return false;
        }
    }

    @Override
    public List<Order> findOrdersByDateRange(LocalDate startDate, LocalDate endDate) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM orders WHERE date BETWEEN ? AND ? ORDER BY order_id DESC";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setDate(1, Date.valueOf(startDate));
            ps.setDate(2, Date.valueOf(endDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = ModelUtils.getOrderFromResultSet(rs);
                orders.add(order);
            }

        } catch (Exception e) {
            System.out.println("Error finding orders by date range: " + e.getMessage());
        }

        return orders;
    }

    @Override
    public boolean updateOrderStatus(int orderId, OrderStatus newStatus) {
        String query = "UPDATE orders SET order_status = ? WHERE order_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, newStatus.name());
            ps.setInt(2, orderId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 1;

        } catch (Exception e) {
            System.out.println("Error updating order status: " + e.getMessage());
            return false;
        }
    }

}