package model;

import util.OrderStatus;

import java.time.LocalDate;

public class Order {
    private int orderId;
    private LocalDate date;
    private Double subTotal;
    private Double taxAmount;
    private Double deliveryCharge;
    private Double totalAmount;
    private OrderStatus orderStatus;
    private int userId;

    public Order( Double subTotal, Double taxAmount, Double deliveryCharge, Double totalAmount, OrderStatus orderStatus, int userId) {
        this.date = LocalDate.now();
        this.subTotal = subTotal;
        this.taxAmount = taxAmount;
        this.deliveryCharge = deliveryCharge;
        this.totalAmount = totalAmount;
        this.orderStatus = orderStatus;
        this.userId = userId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Double getSubTotal() {
        return subTotal;
    }

    public void setSubTotal(Double subTotal) {
        this.subTotal = subTotal;
    }

    public Double getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(Double taxAmount) {
        this.taxAmount = taxAmount;
    }

    public Double getDeliveryCharge() {
        return deliveryCharge;
    }

    public void setDeliveryCharge(Double deliveryCharge) {
        this.deliveryCharge = deliveryCharge;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
