package dao;

import model.Category;
import util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao{
    @Override
    public boolean addCategory(Category category) {
        String query = "INSERT INTO categories(name) VALUES(?)";

        try(Connection connection = DatabaseConnection.getConnection()){
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, category.getName());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected>=1;
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return false;
    }

    @Override
    public List<Category> getAllCategories() {
        String query = "SELECT * FROM categories";
        List<Category> categories = new ArrayList<>();

        try(Connection connection = DatabaseConnection.getConnection()){
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()){
                Category category = new Category(rs.getString("name"));
                category.setCategoryId(rs.getInt("category_id"));
                categories.add(category);
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return categories;
    }

    @Override
    public boolean updateCategory(Category category, int categoryId) {
        String query = "UPDATE TABLE categories SET name=? WHERE category_id=?";

        try(Connection connection = DatabaseConnection.getConnection()){
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, category.getName());
            ps.setInt(2, categoryId);

            int rowsAffected = ps.executeUpdate();

            return  rowsAffected>=1;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    @Override
    public boolean deleteCategory(int categoryId) {
        String query = "DELETE FROM categories WHERE category_id=?";

        try(Connection connection = DatabaseConnection.getConnection()){
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, categoryId);
             int rowsAffected = ps.executeUpdate();

             return rowsAffected>= 1;
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
        return false;
    }
}
