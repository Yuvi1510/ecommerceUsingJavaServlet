package dao;

import dto.CartItemDto;
import model.Cart;
import model.CartItem;
import model.User;
import util.DatabaseConnection;
import util.SessionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDaoImpl implements CartDao{
    @Override
    public boolean createCart(int userId) {
        String query = "INSERT INTO carts(user_id, quantity) VALUES(?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setInt(2, 0); // default cart quantity

            int rowsAffected = ps.executeUpdate();

            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean addToCart(int userId, int productId) {

        String getProductQuery =
                "SELECT price FROM products WHERE product_id = ?";

        String getCartQuery =
                "SELECT cart_id FROM carts WHERE user_id = ?";

        String checkCartItemQuery =
                "SELECT cart_item_id FROM cart_items " +
                        "WHERE cart_id = ? AND product_id = ?";

        String insertCartItemQuery =
                "INSERT INTO cart_items(total_items, total_price, cart_id, product_id) " +
                        "VALUES(?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection()) {

            // Get product price
            double productPrice = 0;

            try (PreparedStatement ps = connection.prepareStatement(getProductQuery)) {

                ps.setInt(1, productId);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    productPrice = rs.getDouble("price");
                } else {
                    return false;
                }
            }

            // Get user's cart id
            int cartId = 0;

            try (PreparedStatement ps = connection.prepareStatement(getCartQuery)) {

                ps.setInt(1, userId);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    cartId = rs.getInt("cart_id");
                } else {
                    return false;
                }
            }

            // Check if product already exists in cart
            try (PreparedStatement ps = connection.prepareStatement(checkCartItemQuery)) {

                ps.setInt(1, cartId);
                ps.setInt(2, productId);

                ResultSet rs = ps.executeQuery();

                // Already exists → do nothing
                if (rs.next()) {
                    return true;
                }
            }

            // Insert new cart item
            try (PreparedStatement ps = connection.prepareStatement(insertCartItemQuery)) {

                ps.setInt(1, 1);
                ps.setDouble(2, productPrice);
                ps.setInt(3, cartId);
                ps.setInt(4, productId);

                int rowsAffected = ps.executeUpdate();

                return rowsAffected > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean removeFromCart(int userId, int id) {

        String getCartQuery = "SELECT cart_id FROM carts WHERE user_id = ?";
        String deleteQuery = "DELETE FROM cart_items WHERE cart_item_id = ? AND cart_id = ?";

        try (Connection connection = DatabaseConnection.getConnection()) {

            int cartId = 0;

            // Get user's cart
            try (PreparedStatement ps = connection.prepareStatement(getCartQuery)) {

                ps.setInt(1, userId);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    cartId = rs.getInt("cart_id");
                } else {
                    return false;
                }
            }

            // Delete only from user's cart
            try (PreparedStatement ps = connection.prepareStatement(deleteQuery)) {

                ps.setInt(1, id);
                ps.setInt(2, cartId);

                int rowsAffected = ps.executeUpdate();

                return rowsAffected > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean updateCartItemQuantity(int userId, int id, int quantity) {

        // Validation
        if (quantity <= 0) {
            return false;
        }

        String getCartQuery = "SELECT cart_id FROM carts WHERE user_id = ?";
        String getPriceQuery =
                "SELECT p.price FROM cart_items ci " +
                        "JOIN products p ON ci.product_id = p.product_id " +
                        "WHERE ci.cart_item_id = ?";

        String updateQuery =
                "UPDATE cart_items " +
                        "SET total_items = ?, total_price = ? " +
                        "WHERE cart_item_id = ? AND cart_id = ?";

        try (Connection connection = DatabaseConnection.getConnection()) {

            int cartId = 0;

            // Get cart id using userId
            try (PreparedStatement ps = connection.prepareStatement(getCartQuery)) {

                ps.setInt(1, userId);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    cartId = rs.getInt("cart_id");
                } else {
                    return false;
                }
            }

            double productPrice = 0;

            // Get product price from database
            try (PreparedStatement ps = connection.prepareStatement(getPriceQuery)) {

                ps.setInt(1, id);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    productPrice = rs.getDouble("price");
                } else {
                    return false;
                }
            }

            double totalPrice = productPrice * quantity;

            // Update cart item securely
            try (PreparedStatement ps = connection.prepareStatement(updateQuery)) {

                ps.setInt(1, quantity);
                ps.setDouble(2, totalPrice);
                ps.setInt(3, id);
                ps.setInt(4, cartId);

                int rowsAffected = ps.executeUpdate();

                return rowsAffected > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<CartItemDto> getAllCartItems(int userId) {

        List<CartItemDto> cartItems = new ArrayList<>();

        String query =
                "SELECT ci.cart_item_id, ci.total_items, ci.total_price, " +
                        "ci.cart_id, ci.product_id, " +
                        "p.name, p.description, p.image_path, p.price " +
                        "FROM cart_items ci " +
                        "JOIN carts c ON ci.cart_id = c.cart_id " +
                        "JOIN products p ON ci.product_id = p.product_id " +
                        "WHERE c.user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartItemDto cartItem = new CartItemDto();

                cartItem.setCartItemId(rs.getInt("cart_item_id"));
                cartItem.setTotalItems(rs.getInt("total_items"));
                cartItem.setTotalPrice(rs.getDouble("total_price"));
                cartItem.setCartId(rs.getInt("cart_id"));
                cartItem.setProductId(rs.getInt("product_id"));

                cartItem.setName(rs.getString("name"));
                cartItem.setDescription(rs.getString("description"));
                cartItem.setImagePath(rs.getString("image_path"));
                cartItem.setPrice(rs.getDouble("price"));

                cartItems.add(cartItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartItems;
    }
}
