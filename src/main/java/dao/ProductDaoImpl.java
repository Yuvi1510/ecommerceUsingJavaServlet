package dao;

import model.Product;

import java.util.List;

public class ProductDaoImpl implements ProductsDao{
    @Override
    public boolean addProduct(Product product) {
        return false;
    }

    @Override
    public Product findProductById(int id) {
        return null;
    }

    @Override
    public List<Product> findProductsByName(String name) {
        return List.of();
    }

    @Override
    public List<Product> findProductsByCategory(String category) {
        return List.of();
    }

    @Override
    public boolean updateProduct(Product product, int productId) {
        return false;
    }

    @Override
    public boolean deleteProduct(int id) {
        return false;
    }
}
