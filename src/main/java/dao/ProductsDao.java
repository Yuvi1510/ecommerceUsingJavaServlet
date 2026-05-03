package dao;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import model.Product;

import java.util.List;

public interface ProductsDao {
    boolean addProduct(HttpServletRequest request);
    Product findProductById(int id);
    List<Product> findProductsByName(String name);
    List<Product> findProductsByCategory(int categoryId);
    boolean updateProduct(HttpServletRequest request, int id);
    boolean deleteProduct(int id);
    List<Product> findAllProducts();
    List<Product> findTopProducts();
    List<Product> findLatestProducts();
}
