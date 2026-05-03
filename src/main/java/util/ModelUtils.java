package util;

import jakarta.servlet.http.HttpServletRequest;
import model.Order;
import model.OrderItem;
import model.Product;
import model.User;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class ModelUtils {
    public static User getUserFromRequest(HttpServletRequest request){
        return new User(
                request.getParameter("firstName"),
                request.getParameter("lastName"),
                LocalDate.parse(request.getParameter("dob")),
                request.getParameter("email"),
                request.getParameter("phone"),
                request.getParameter("address"),
                request.getParameter("password")
        );
    }
    public static User getUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));

        Date dob = rs.getDate("DOB");
        if (dob != null) {
            user.setDob(dob.toLocalDate());
        }
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setPassword(rs.getString("password"));

        return user;
    }


    public static Product getProductFromRequest(HttpServletRequest request){
        return new Product(
                request.getParameter("name"),
                request.getParameter("description"),
                "",
                Double.parseDouble(request.getParameter("price")),
                Integer.parseInt(request.getParameter("quantity")),
                Integer.parseInt(request.getParameter("category"))
        );

    }
    public static Product getProductFromResultSet(ResultSet rs) throws SQLException {
        Product product = new Product(
                rs.getString("name"),
                rs.getString("description"),
                rs.getString("image_path"),
                rs.getDouble("price"),
                rs.getInt("quantity"),
                rs.getInt("category_id")
        );

        product.setProductId(rs.getInt("product_id"));
        product.setDate(rs.getDate("date_added").toLocalDate());

        return product;
    }


    public static Order getOrderFromRequest(HttpServletRequest request) {
        return new Order(
                Double.parseDouble(request.getParameter("subTotal")),
                Double.parseDouble(request.getParameter("taxAmount")),
                Double.parseDouble(request.getParameter("deliveryCharge")),
                Double.parseDouble(request.getParameter("totalAmount")),
                OrderStatus.valueOf(request.getParameter("orderStatus")),
                Integer.parseInt(request.getParameter("userId"))
        );
    }

    public static Order getOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order(
                rs.getDouble("sub_total"),
                rs.getDouble("tax_amount"),
                rs.getDouble("delivery_charge"),
                rs.getDouble("total_amount"),
                OrderStatus.valueOf(rs.getString("order_status")),
                rs.getInt("user_id")
        );

        order.setOrderId(rs.getInt("order_id"));

        Date date = rs.getDate("date");
        order.setDate(date.toLocalDate());

        return order;
    }


    public static OrderItem getOrderItemFromResultSet(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem(
                rs.getInt("product_id"),
                rs.getInt("order_quantity"),
                rs.getDouble("total_price")
        );

        item.setOrderItemId(rs.getInt("order_item_id"));
        item.setAmount(rs.getDouble("amount"));
        item.setOrderId(rs.getInt("order_id"));

        return item;
    }
}
