package dao;

import model.Category;
import java.util.List;

public interface CategoryDao {
    boolean addCategory(Category category);
    List<Category> getAllCategories();
    boolean updateCategory(Category category, int CategoryId);
    boolean deleteCategory( int categoryId);
}
