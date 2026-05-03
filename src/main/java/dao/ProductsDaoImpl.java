package dao;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import model.Product;
import util.DatabaseConnection;
import util.ModelUtils;
import util.SessionUtil;
import util.Validation;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductsDaoImpl implements ProductsDao {

    // In ProductsDaoImpl.java
    @Override
    public boolean addProduct(HttpServletRequest request) {
        Product product = ModelUtils.getProductFromRequest(request);

        String query = "INSERT INTO products(name, description, image_path, price, quantity, category_id, date_added) VALUES(?,?, ?, ?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            Part image = request.getPart("image");
            String imageName = image.getSubmittedFileName();

            if(!Validation.isValidImageExtension(imageName)){
                SessionUtil.setAttribute(request, "error", "Invalid image extension!");
                return false;
            }

            // Generate unique filename
            String extension = imageName.substring(imageName.lastIndexOf("."));
            String uniqueImageName = System.currentTimeMillis() + "_" + System.nanoTime() + extension;

            InputStream is = image.getInputStream();
            byte[] data = new byte[is.available()];

            is.read(data);

//          C:\fatafat-kin\\uploads\products
            String path = "C:" + File.separator + "fatafat-kin"+ File.separator + "uploads" + File.separator+ "products" + File.separator + uniqueImageName;
            System.out.println(path);

            FileOutputStream fos = new FileOutputStream(path);

            fos.write(data);
            fos.close();

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setString(3, uniqueImageName); // Store just the filename
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getQuantity());
            ps.setInt(6, product.getCategoryId());
            ps.setDate(7, Date.valueOf(product.getDate()));

            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 1;

        } catch (Exception e) {
            System.out.println("Error adding product: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    @Override
    public Product findProductById(int id) {
        String query = "SELECT * FROM products WHERE product_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return ModelUtils.getProductFromResultSet(rs);
            }

        } catch (Exception e) {
            System.out.println("Error finding product by ID: " + e.getMessage());
        }

        return null;
    }

    @Override
    public List<Product> findProductsByName(String name) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE LOWER(name) LIKE LOWER(?)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = ModelUtils.getProductFromResultSet(rs);
                products.add(product);
            }

        } catch (Exception e) {
            System.out.println("Error finding products by name: " + e.getMessage());
        }

        return products;
    }

    @Override
    public List<Product> findProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();

        // inner join between products and category table
        String query = "SELECT * FROM products WHERE category_id=?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = ModelUtils.getProductFromResultSet(rs);
                products.add(product);
            }

        } catch (Exception e) {
            System.out.println("Error finding products by category: " + e.getMessage());
        }

        return products;
    }

    @Override
    public boolean updateProduct(HttpServletRequest request, int id) {
        String query = "UPDATE products SET name = ?, description = ?, image_path = ?, " +
                "price = ?, quantity = ?, category_id = ? WHERE product_id = ?";

        Product product = ModelUtils.getProductFromRequest(request);

        String mainFolder = request.getServletContext().getRealPath("");

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            Part image = request.getPart("image");
            String imageName = image.getSubmittedFileName();

            if(!Validation.isValidImageExtension(imageName)){
                SessionUtil.setAttribute(request, "error", "Invalid image extension!");
                return false;
            }

            String uploadFolder = "static/images/" + imageName;
            String filePath = mainFolder + "/" + uploadFolder;
            // write the image
            image.write(filePath);

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setString(3, uploadFolder);
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getQuantity());
            ps.setInt(6, product.getCategoryId());
            ps.setDate(7, Date.valueOf(product.getDate()));

            int rowsAffected = ps.executeUpdate();

            return rowsAffected >=1;

        } catch (Exception e) {
            System.out.println("Error adding product: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean deleteProduct(int id) {
        String query = "DELETE FROM products WHERE product_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 1;

        } catch (Exception e) {
            System.out.println("Error deleting product: " + e.getMessage());
            return false;
        }
    }

    @Override
    public List<Product> findAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = ModelUtils.getProductFromResultSet(rs);
                products.add(product);
            }

        } catch (Exception e) {
            System.out.println("Error finding all products: " + e.getMessage());
        }

        return products;
    }

    @Override
    public List<Product> findTopProducts() {
      String query = "SELECT p.*, SUM(oi.order_quantity) AS total_quantity_sold,SUM(oi.amount) AS total_revenue FROM orders o " +
                "INNER JOIN order_items oi ON o.order_id=oi.order_id  " +
                "INNER JOIN products p ON p.product_id = oi.product_id " +
                "WHERE o.status='confirmed' " +
                "GROUP BY p.product_id " +
                "ORDER BY total_quantity_sold DESC " +
                "LIMIT 4";

        List<Product> topProducts = new ArrayList<>();

        try(Connection connection = DatabaseConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(query)){
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Product product = ModelUtils.getProductFromResultSet(rs);
                topProducts.add(product);
            }

            return topProducts;
        }catch (SQLException e){
            System.out.println(e.getMessage());
        }

        return null;

    }

    @Override
    public List<Product> findLatestProducts() {
        String query = "SELECT * FROM products ORDER BY date_added DESC LIMIT 4";
        List<Product> latestProducts = new ArrayList<>();

        try(Connection connection = DatabaseConnection.getConnection();
        PreparedStatement ps = connection.prepareStatement(query)){
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Product product = ModelUtils.getProductFromResultSet(rs);
                latestProducts.add(product);
            }

            return latestProducts;
        }catch (SQLException e){
            System.out.println(e.getMessage());
        }

        return null;
    }


//
//    public boolean updateProductQuantity(int productId, int newQuantity) {
//        String query = "UPDATE products SET quantity = ? WHERE product_id = ?";
//
//        try (Connection connection = DatabaseConnection.getConnection();
//             PreparedStatement ps = connection.prepareStatement(query)) {
//
//            ps.setInt(1, newQuantity);
//            ps.setInt(2, productId);
//
//            int rowsAffected = ps.executeUpdate();
//            return rowsAffected >= 1;
//
//        } catch (Exception e) {
//            System.out.println("Error updating product quantity: " + e.getMessage());
//            return false;
//        }
//    }
}