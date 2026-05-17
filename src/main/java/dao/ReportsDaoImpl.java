package dao;

import util.DatabaseConnection;

import java.sql.*;
import java.util.*;

public class ReportsDaoImpl implements ReportsDao {

    @Override
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        return executeCount(sql);
    }

    @Override
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM products";
        return executeCount(sql);
    }

    @Override
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        return executeCount(sql);
    }

    @Override
    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE status='DELIVERED'";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private int executeCount(String sql) {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Monthly revenue
    @Override
    public List<Map<String, Object>> getMonthlyRevenue() {
        String sql = """
            SELECT MONTH(date) AS month, SUM(total_amount) AS revenue
            FROM orders
            WHERE status='DELIVERED'
            GROUP BY MONTH(date)
            ORDER BY month
        """;

        return fetchList(sql, "month", "revenue");
    }

    // Order status
    @Override
    public List<Map<String, Object>> getOrderStatusCount() {
        String sql = """
            SELECT status, COUNT(*) AS total
            FROM orders
            GROUP BY status
        """;

        return fetchList(sql, "order_status", "total");
    }

    // Top products
    @Override
    public List<Map<String, Object>> getTopProducts() {
        String sql = """
            SELECT p.name AS product, SUM(oi.order_quantity) AS sold
            FROM order_items oi
            JOIN products p ON oi.product_id = p.product_id
            GROUP BY p.name
            ORDER BY sold DESC
            LIMIT 5
        """;

        return fetchList(sql, "product", "sold");
    }

    private List<Map<String, Object>> fetchList(String sql, String key1, String key2) {
        List<Map<String, Object>> list = new ArrayList<>();

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put(key1, rs.getObject(1));
                map.put(key2, rs.getObject(2));
                list.add(map);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}