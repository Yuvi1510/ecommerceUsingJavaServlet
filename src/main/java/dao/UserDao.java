package dao;

import model.User;

import java.util.List;

public interface UserDao {
    boolean addUser(User user);
    List<User> findAllUsers();
    User findUserById(int id);
    User findUserByEmail(String email);
    boolean updateUser(User user, int userId);
    boolean deleteUser(int id);
}
