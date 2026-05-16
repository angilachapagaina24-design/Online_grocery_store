package grocery_model;
 
/**
 * Model class representing a Product in the grocery store.
 * Maps directly to the 'product' table in the database.
 */
public class Product {
 
    private int productId;
    private int categoryId;
    private String name;
    private String description;
    private double price;
    private int stockQuantity;
    private String unit;
    private String imageUrl;
    private String brand;
    private String expiryDate;
    private String status;
    private int totalSold;
 
    // Default constructor
    public Product() {}
 
    // ---- Getters & Setters ----
 
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
 
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
 
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
 
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
 
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
 
    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }
 
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
 
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
 
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
 
    public String getExpiryDate() { return expiryDate; }
    public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }
 
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public int getTotalSold()           { return totalSold; }
    public void setTotalSold(int v)     { this.totalSold = v; }
}