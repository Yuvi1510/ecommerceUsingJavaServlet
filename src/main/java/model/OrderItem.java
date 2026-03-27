package model;

import dao.ProductsDao;
import dao.ProductsDaoImpl;

public class OrderItem {
    private int orderItemId;
    private int orderQuantity;
    private Double amount;
    private int orderId;
    private int productId;

    ProductsDao productsDao = new ProductsDaoImpl();

    public OrderItem( int productId, int orderQuantity, Double amount) {
        this.orderQuantity = orderQuantity >= 1? orderQuantity: 0;
        this.productId = productId;
        this.amount =amount;
    }

    public void updateQuantity(int orderQuantity){
        this.orderQuantity = orderQuantity;
        this.amount = productsDao.findProductById(productId).getPrice() * orderQuantity;

    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(int orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}

