package dao;

import java.util.Map;
import java.util.List;

public interface ReportsDao {

    // Top summary cards
    int getTotalUsers();
    int getTotalProducts();
    int getTotalOrders();
    double getTotalRevenue();

    // Charts data
    List<Map<String, Object>> getMonthlyRevenue();
    List<Map<String, Object>> getOrderStatusCount();
    List<Map<String, Object>> getTopProducts();
}