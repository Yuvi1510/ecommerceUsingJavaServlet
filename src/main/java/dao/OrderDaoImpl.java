package dao;

import dto.OrderDto;
import dto.OrderItemDto;
import model.CartItem;
import model.Order;
import model.OrderItem;
import util.DatabaseConnection;
import util.ModelUtils;
import enums.OrderStatus;

import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

public class OrderDaoImpl implements OrderDao {
    OrderItemDao orderItemDao = new OrderItemDaoImpl();

    private OrderItem mapCartItemToOrderItem(CartItem cartItem){
        OrderItem orderItem = new OrderItem(cartItem.getProductId(), cartItem.getTotalItems(), cartItem.getTotalPrice());
        return orderItem;
    }

    @Override
    public boolean buyNow(Order order, CartItem cartItem) {

        String query =
                "INSERT INTO orders(date, sub_total, tax_amount, delivery_charge, total_amount, status, user_id) " +
                        "VALUES(?, ?, ?, ?, ?, ?, ?)";

        String insertOrderItemQuery =
                "INSERT INTO order_items(order_quantity, amount, order_id, product_id) " +
                        "VALUES(?, ?, ?, ?)";

        String updateProductQuantity =
                "UPDATE products SET quantity=? WHERE product_id = ?";

        String getQuantityQuery =
                "SELECT quantity FROM products WHERE product_id=?";

        try (Connection connection = DatabaseConnection.getConnection()) {

            connection.setAutoCommit(false);

            try (
                    PreparedStatement ps = connection.prepareStatement(
                            query,
                            Statement.RETURN_GENERATED_KEYS
                    );

                    PreparedStatement insertOrderItem =
                            connection.prepareStatement(insertOrderItemQuery);

                    PreparedStatement setQuantity =
                            connection.prepareStatement(updateProductQuantity);

                    PreparedStatement getQuantity =
                            connection.prepareStatement(getQuantityQuery)
            ) {

                // Insert order
                ps.setDate(1, Date.valueOf(order.getDate()));
                ps.setDouble(2, order.getSubTotal());
                ps.setDouble(3, order.getTaxAmount());
                ps.setDouble(4, order.getDeliveryCharge());
                ps.setDouble(5, order.getTotalAmount());
                ps.setString(6, order.getOrderStatus().name());
                ps.setInt(7, order.getUserId());

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected < 1) {
                    connection.rollback();
                    return false;
                }

                // Get generated order id
                int orderId = 0;

                ResultSet rs = ps.getGeneratedKeys();

                if (rs.next()) {
                    orderId = rs.getInt(1);
                } else {
                    connection.rollback();
                    return false;
                }

                // Convert cart item to order item
                OrderItem orderItem = mapCartItemToOrderItem(cartItem);

                orderItem.setOrderId(orderId);

                // Check product quantity
                getQuantity.setInt(1, orderItem.getProductId());

                ResultSet quantityRs = getQuantity.executeQuery();

                if (!quantityRs.next()) {
                    connection.rollback();
                    return false;
                }

                int productQuantity = quantityRs.getInt("quantity");

                // Insufficient stock check
                if (productQuantity < orderItem.getOrderQuantity()) {
                    connection.rollback();
                    return false;
                }

                // Insert order item
                insertOrderItem.setInt(1, orderItem.getOrderQuantity());
                insertOrderItem.setDouble(2, orderItem.getAmount());
                insertOrderItem.setInt(3, orderId);
                insertOrderItem.setInt(4, orderItem.getProductId());

                int orderItemRows = insertOrderItem.executeUpdate();

                if (orderItemRows < 1) {
                    connection.rollback();
                    return false;
                }

                // Update product quantity
                setQuantity.setInt(
                        1,
                        productQuantity - orderItem.getOrderQuantity()
                );

                setQuantity.setInt(2, orderItem.getProductId());

                int updatedRows = setQuantity.executeUpdate();

                if (updatedRows < 1) {
                    connection.rollback();
                    return false;
                }

                connection.commit();

                return true;

            } catch (Exception e) {

                connection.rollback();

                e.printStackTrace();
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean createOrder(int userId) {

        String getCartQuery =
                "SELECT cart_id FROM carts WHERE user_id = ?";

        String getCartItemsQuery =
                "SELECT * FROM cart_items WHERE cart_id = ?";

        String insertOrderQuery =
                "INSERT INTO orders(date, sub_total, tax_amount, delivery_charge, total_amount, status, user_id) " +
                        "VALUES(?, ?, ?, ?, ?, ?, ?)";

        String insertOrderItemQuery =
                "INSERT INTO order_items(order_quantity, amount, order_id, product_id) " +
                        "VALUES(?, ?, ?, ?)";

        String deleteCartItemsQuery =
                "DELETE FROM cart_items WHERE cart_id = ?";
        String updateProductQuantity = "UPDATE products SET quantity=? WHERE product_id = ?";
        String getQuantityQuery = "SELECT quantity FROM products WHERE product_id=?";

        try (Connection connection = DatabaseConnection.getConnection()) {

            // Transaction start
            connection.setAutoCommit(false);

            int cartId = 0;

            // Get cart id
            try (PreparedStatement ps = connection.prepareStatement(getCartQuery)) {

                ps.setInt(1, userId);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    cartId = rs.getInt("cart_id");
                } else {
                    return false;
                }
            }

            // Get cart items
            List<CartItem> cartItems = new ArrayList<>();

            double subtotal = 0;

            try (PreparedStatement ps = connection.prepareStatement(getCartItemsQuery)) {

                ps.setInt(1, cartId);

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {

                    CartItem cartItem = new CartItem(
                            rs.getInt("total_items"),
                            rs.getDouble("total_price"),
                            rs.getInt("cart_id"),
                            rs.getInt("product_id")
                    );

                    cartItem.setCartItemId(rs.getInt("cart_item_id"));

                    subtotal += cartItem.getTotalPrice();

                    cartItems.add(cartItem);
                }
            }

            // Empty cart check
            if (cartItems.isEmpty()) {
                return false;
            }

            // Calculate totals
            double taxAmount = subtotal * 0.13;
            double deliveryCharge = 150;
            double totalAmount = subtotal + taxAmount + deliveryCharge;

            int orderId = 0;

            // Create order
            try (PreparedStatement ps = connection.prepareStatement(
                    insertOrderQuery,
                    Statement.RETURN_GENERATED_KEYS
            )) {

                ps.setDate(1, Date.valueOf(LocalDate.now()));
                ps.setDouble(2, subtotal);
                ps.setDouble(3, taxAmount);
                ps.setDouble(4, deliveryCharge);
                ps.setDouble(5, totalAmount);
                ps.setString(6, OrderStatus.PENDING.name());
                ps.setInt(7, userId);

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected <= 0) {
                    connection.rollback();
                    return false;
                }

                ResultSet rs = ps.getGeneratedKeys();

                if (rs.next()) {
                    orderId = rs.getInt(1);
                } else {
                    connection.rollback();
                    return false;
                }
            }

            // Create order items
            try (PreparedStatement ps = connection.prepareStatement(insertOrderItemQuery)) {

                for (CartItem item : cartItems) {

                    ps.setInt(1, item.getTotalItems());
                    ps.setDouble(2, item.getTotalPrice());
                    ps.setInt(3, orderId);
                    ps.setInt(4, item.getProductId());

                    ps.addBatch();
                }

                ps.executeBatch();

                // Update product quantities
                try (
                        PreparedStatement getPs = connection.prepareStatement(getQuantityQuery);
                        PreparedStatement updatePs = connection.prepareStatement(updateProductQuantity)
                ) {

                    for (CartItem item : cartItems) {

                        // Get current product quantity
                        getPs.setInt(1, item.getProductId());

                        ResultSet rs = getPs.executeQuery();

                        if (rs.next()) {

                            int currentQuantity = rs.getInt("quantity");

                            // Remaining quantity after order
                            int updatedQuantity = currentQuantity - item.getTotalItems();

                            // Prevent negative quantity
                            if (updatedQuantity < 0) {
                                connection.rollback();
                                return false;
                            }

                            // Update product quantity
                            updatePs.setInt(1, updatedQuantity);
                            updatePs.setInt(2, item.getProductId());

                            updatePs.addBatch();

                        } else {
                            connection.rollback();
                            return false;
                        }
                    }

                    updatePs.executeBatch();
                }
            }

            // Remove cart items
            try (PreparedStatement ps = connection.prepareStatement(deleteCartItemsQuery)) {

                ps.setInt(1, cartId);

                ps.executeUpdate();
            }

            // Commit transaction
            connection.commit();

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<OrderDto> findAllOrders() {

        String query = """
        SELECT 
            o.order_id,
            o.date,
            o.sub_total,
            o.tax_amount,
            o.delivery_charge,
            o.total_amount,
            o.status,
            o.user_id,

            u.email,

            oi.order_item_id,
            oi.order_quantity,
            oi.amount,
            oi.product_id,

            p.name,
            p.description,
            p.image_path,
            p.price

        FROM orders o

        JOIN users u
            ON o.user_id = u.user_id

        JOIN order_items oi
            ON o.order_id = oi.order_id

        JOIN products p
            ON oi.product_id = p.product_id

        ORDER BY o.date ASC
    """;

        try (Connection connection = DatabaseConnection.getConnection()) {

            Map<Integer, OrderDto> orderMap = new LinkedHashMap<>();

            PreparedStatement ps = connection.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                int orderId = rs.getInt("order_id");

                OrderDto orderDto = orderMap.get(orderId);

                // Create order only once
                if (orderDto == null) {

                    orderDto = new OrderDto();

                    orderDto.setOrderId(orderId);
                    orderDto.setDate(rs.getDate("date").toLocalDate());
                    orderDto.setSubTotal(rs.getDouble("sub_total"));
                    orderDto.setTaxAmount(rs.getDouble("tax_amount"));
                    orderDto.setDeliveryCharge(rs.getDouble("delivery_charge"));
                    orderDto.setTotalAmount(rs.getDouble("total_amount"));
                    orderDto.setOrderStatus(
                            OrderStatus.valueOf(rs.getString("status"))
                    );
                    orderDto.setUserId(rs.getInt("user_id"));

                    // Set user email
                    orderDto.setUserEmail(rs.getString("email"));

                    orderMap.put(orderId, orderDto);
                }

                // Create order item
                OrderItemDto itemDto = new OrderItemDto();

                itemDto.setOrderItemId(rs.getInt("order_item_id"));
                itemDto.setOrderQuantity(rs.getInt("order_quantity"));
                itemDto.setAmount(rs.getDouble("amount"));
                itemDto.setOrderId(orderId);
                itemDto.setProductId(rs.getInt("product_id"));

                itemDto.setName(rs.getString("name"));
                itemDto.setDescription(rs.getString("description"));
                itemDto.setImagePath(rs.getString("image_path"));
                itemDto.setPrice(rs.getDouble("price"));

                // Add item to order
                orderDto.getOrderItems().add(itemDto);
            }

            return new ArrayList<>(orderMap.values());

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

//    @Override
//    public Order findOrderById(int orderId) {
//        String query = "SELECT * FROM orders WHERE order_id = ? ";
//
//        try (Connection connection = DatabaseConnection.getConnection();
//             PreparedStatement ps = connection.prepareStatement(query)) {
//
//            ps.setInt(1, orderId);
//            ResultSet rs = ps.executeQuery();
//
//            if (rs.next()) {
//                return ModelUtils.getOrderFromResultSet(rs);
//            }
//
//        } catch (Exception e) {
//            System.out.println("Error finding order by ID: " + e.getMessage());
//        }
//
//        return null;
//    }

    @Override
    public List<OrderDto> findOrderByUserId(int userId) {
        String query = """
    SELECT 
        o.order_id,
        o.date,
        o.sub_total,
        o.tax_amount,
        o.delivery_charge,
        o.total_amount,
        o.status,
        o.user_id,

        oi.order_item_id,
        oi.order_quantity,
        oi.amount,
        oi.product_id,

        p.name,
        p.description,
        p.image_path,
        p.price

    FROM orders o
    JOIN order_items oi 
        ON o.order_id = oi.order_id
    JOIN products p 
        ON oi.product_id = p.product_id

    WHERE o.user_id = ?
    ORDER BY o.date ASC
""";

        try(Connection connection = DatabaseConnection.getConnection()){
            Map<Integer, OrderDto> orderMap = new HashMap<>();

            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                int orderId = rs.getInt("order_id");

                OrderDto orderDto = orderMap.get(orderId);

                if (orderDto == null) {

                    orderDto = new OrderDto();

                    orderDto.setOrderId(orderId);
                    orderDto.setDate(rs.getDate("date").toLocalDate());
                    orderDto.setSubTotal(rs.getDouble("sub_total"));
                    orderDto.setTaxAmount(rs.getDouble("tax_amount"));
                    orderDto.setDeliveryCharge(rs.getDouble("delivery_charge"));
                    orderDto.setTotalAmount(rs.getDouble("total_amount"));
                    orderDto.setOrderStatus(
                            OrderStatus.valueOf(rs.getString("status"))
                    );
                    orderDto.setUserId(rs.getInt("user_id"));

                    orderMap.put(orderId, orderDto);
                }

                OrderItemDto itemDto = new OrderItemDto();

                itemDto.setOrderItemId(rs.getInt("order_item_id"));
                itemDto.setOrderQuantity(rs.getInt("order_quantity"));
                itemDto.setAmount(rs.getDouble("amount"));
                itemDto.setOrderId(orderId);
                itemDto.setProductId(rs.getInt("product_id"));

                itemDto.setName(rs.getString("name"));
                itemDto.setDescription(rs.getString("description"));
                itemDto.setImagePath(rs.getString("image_path"));
                itemDto.setPrice(rs.getDouble("price"));

                orderDto.getOrderItems().add(itemDto);
            }

            List<OrderDto> orders = new ArrayList<>(orderMap.values());

            return orders;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

//    @Override
//    public List<Order> findOrderByUserEmail(String email) {
//        List<Order> orders = new ArrayList<>();
//        String query = "SELECT o.* FROM orders o " +
//                "INNER JOIN users u ON o.user_id = u.user_id " +
//                "WHERE u.email = ? ORDER BY o.order_id DESC";
//
//        try (Connection connection = DatabaseConnection.getConnection();
//             PreparedStatement ps = connection.prepareStatement(query)) {
//
//            ps.setString(1, email);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                Order order = ModelUtils.getOrderFromResultSet(rs);
//                orders.add(order);
//            }
//
//        } catch (Exception e) {
//            System.out.println("Error finding orders by user email: " + e.getMessage());
//        }
//
//        return orders;
//    }

//    @Override
//    public List<Order> findOrderByStatus(OrderStatus orderStatus) {
//        List<Order> orders = new ArrayList<>();
//        String query = "SELECT * FROM orders WHERE status = ? ORDER BY order_id DESC";
//
//        try (Connection connection = DatabaseConnection.getConnection();
//             PreparedStatement ps = connection.prepareStatement(query)) {
//
//            ps.setString(1, orderStatus.name());
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                Order order = ModelUtils.getOrderFromResultSet(rs);
//                orders.add(order);
//            }
//
//        } catch (Exception e) {
//            System.out.println("Error finding orders by status: " + e.getMessage());
//        }
//
//        return orders;
//    }
//
//    @Override
//    public boolean updateOrder(Order order, int orderId) {
//        String query = "UPDATE orders SET date = ?, sub_total = ?, tax_amount = ?, delivery_charge = ?, total_amount = ?, order_status = ?, user_id = ? WHERE order_id = ?";
//
//        try (Connection connection = DatabaseConnection.getConnection();
//             PreparedStatement ps = connection.prepareStatement(query)) {
//
//            ps.setDate(1, Date.valueOf(order.getDate()));
//            ps.setDouble(2, order.getSubTotal());
//            ps.setDouble(3, order.getTaxAmount());
//            ps.setDouble(4, order.getDeliveryCharge());
//            ps.setDouble(5, order.getTotalAmount());
//            ps.setString(6, order.getOrderStatus().name());
//            ps.setInt(7, order.getUserId());
//            ps.setInt(8, orderId);
//
//            int rowsAffected = ps.executeUpdate();
//            return rowsAffected >= 1;
//
//        } catch (Exception e) {
//            System.out.println("Error updating order: " + e.getMessage());
//            return false;
//        }
//    }
//
//    @Override
//    public boolean deleteOrder(int orderId) {
//        String query = "DELETE FROM orders WHERE order_id = ?";
//
//        try (Connection connection = DatabaseConnection.getConnection();
//             PreparedStatement ps = connection.prepareStatement(query)) {
//
//            ps.setInt(1, orderId);
//            int rowsAffected = ps.executeUpdate();
//            return rowsAffected >= 1;
//
//        } catch (Exception e) {
//            System.out.println("Error deleting order: " + e.getMessage());
//            return false;
//        }
//    }
//
//    @Override
//    public List<Order> findOrdersByDateRange(LocalDate startDate, LocalDate endDate) {
//        List<Order> orders = new ArrayList<>();
//        String query = "SELECT * FROM orders WHERE date BETWEEN ? AND ? ORDER BY order_id DESC";
//
//        try (Connection connection = DatabaseConnection.getConnection();
//             PreparedStatement ps = connection.prepareStatement(query)) {
//
//            ps.setDate(1, Date.valueOf(startDate));
//            ps.setDate(2, Date.valueOf(endDate));
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                Order order = ModelUtils.getOrderFromResultSet(rs);
//                orders.add(order);
//            }
//
//        } catch (Exception e) {
//            System.out.println("Error finding orders by date range: " + e.getMessage());
//        }
//
//        return orders;
//    }

    @Override
    public boolean updateOrderStatus(int orderId, OrderStatus newStatus) {
        String query = "UPDATE orders SET status = ? WHERE order_id = ?";

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