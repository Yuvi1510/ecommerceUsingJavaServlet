package dao;

import model.Product;

import java.util.List;

public interface ProductsDao {
    boolean addProduct(Product product);
    Product findProductById(int id);
    List<Product> findProductsByName(String name);
    List<Product> findProductsByCategory(int categoryId);
    boolean updateProduct(Product product, int productId);
    boolean deleteProduct(int id);
    List<Product> findAllProducts();
    List<Product> findTopProducts();
    List<Product> findLatestProducts();
}
