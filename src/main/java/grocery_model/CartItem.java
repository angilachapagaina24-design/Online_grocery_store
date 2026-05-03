package grocery_model;

public class CartItem {
    private int id;
    private String name;
    private double price;
    private int quantity;
    private String image;   

    // Constructor ma image थप
    public CartItem(int id, String name, double price, int quantity, String image) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.image = image;   // ← NEW
    }

    // Existing getters/setters...
    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    // Image getter ← NEW
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}