package model;

public class Product {
    private int productId;
    private String name;
    private String description;
    private String imagePath;
    private Double price;
    private int quantity;
    private int storeId;
    private int categoryId;

    public Product(){

    }

    public Product(String name, String description, String imagePath, Double price, int quantity, int storeId, int categoryId) {
        this.name = name;
        this.description = description;
        this.imagePath = imagePath;
        this.price = price;
        this.quantity = quantity;
        this.storeId = storeId;
        this.categoryId = categoryId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
}
