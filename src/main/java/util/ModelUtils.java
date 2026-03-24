package util;

import jakarta.servlet.http.HttpServletRequest;
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
                request.getParameter("image"),
                Double.parseDouble(request.getParameter("price")),
                Integer.parseInt(request.getParameter("quantity")),
                1,
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
                rs.getInt("store_id"),
                rs.getInt("category_id")
        );

        product.setProductId(rs.getInt("product_id"));

        return product;
    }
}
