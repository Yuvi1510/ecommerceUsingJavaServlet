package dao;

import model.User;
import util.DatabaseConnection;
import util.ModelUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao{
    @Override
    public boolean addUser(User user) {
        String query = "INSERT INTO users(first_name, last_name,DOB,email,phone, address, password) VALUES(?,?,?,?,?,?,?)";
        try(Connection connection = DatabaseConnection.getConnection()){
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setDate(3, Date.valueOf(user.getDob()));
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getPassword());

            int rowsAffected = ps.executeUpdate();

            return rowsAffected >= 1;

        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    @Override
    public List<User> findAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                User user = ModelUtils.getUserFromResultSet(rs);
                users.add(user);
            }

        } catch (Exception e) {
            System.out.println("Error finding all users: " + e.getMessage());
        }

        return users;
    }

    @Override
    public User findUserById(int id) {
        String query = "SELECT * FROM users WHERE user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return ModelUtils.getUserFromResultSet(rs);
            }

        } catch (Exception e) {
            System.out.println("Error finding user by ID: " + e.getMessage());
        }

        return null;
    }

    @Override
    public User findUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return ModelUtils.getUserFromResultSet(rs);
            }

        } catch (Exception e) {
            System.out.println("Error finding user by email: " + e.getMessage());
        }

        return null;
    }

    @Override
    public boolean updateUser(User user, int userId) {
        String query = "UPDATE users SET first_name = ?, last_name = ?, DOB = ?, email = ?, phone = ?, address = ? WHERE user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());

                ps.setDate(3, Date.valueOf(user.getDob()));

            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setInt(7, userId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 1;

        } catch (Exception e) {
            System.out.println("Error updating user: " + e.getMessage());
            return false;
        }
    }


    @Override
    public boolean deleteUser(int id) {
        String query = "DELETE FROM users WHERE user_id = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected >= 1;

        } catch (Exception e) {
            System.out.println("Error deleting user: " + e.getMessage());
            return false;
        }
    }


}
