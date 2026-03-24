package model;

public class CartItem {
    private int cartItemId;
    private int totalItems;
    private Double totalPrice;
    private int cartId;
    private int productId;

    public CartItem(int totalItems, Double totalPrice, int cartId, int productId) {
        this.totalItems = totalItems;
        this.totalPrice = totalPrice;
        this.cartId = cartId;
        this.productId = productId;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getTotalItems() {
        return totalItems;
    }

    public void setTotalItems(int totalItems) {
        this.totalItems = totalItems;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}
