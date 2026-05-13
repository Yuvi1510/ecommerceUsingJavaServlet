package dao;

import dto.CartItemDto;
import model.Cart;
import model.CartItem;

import java.util.List;

public interface CartDao {
    boolean createCart(int userId);
    boolean addToCart(int userId, int productId);
    boolean removeFromCart(int userId, int id);
    boolean updateCartItemQuantity(int userId, int id, int quantity);
    List<CartItemDto> getAllCartItems(int userId);
}
