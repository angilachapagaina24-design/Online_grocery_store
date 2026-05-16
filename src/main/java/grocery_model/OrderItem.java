package grocery_model;

public class OrderItem {
    private int    orderItemId;
    private int    orderId;
    private int    productId;
    private String productName;
    private int    quantity;
    private double price;

    public OrderItem() {}

    public int    getOrderItemId()                   { return orderItemId; }
    public void   setOrderItemId(int v)              { this.orderItemId = v; }

    public int    getOrderId()                       { return orderId; }
    public void   setOrderId(int v)                  { this.orderId = v; }

    public int    getProductId()                     { return productId; }
    public void   setProductId(int v)                { this.productId = v; }

    public String getProductName()                   { return productName; }
    public void   setProductName(String v)           { this.productName = v; }

    public int    getQuantity()                      { return quantity; }
    public void   setQuantity(int v)                 { this.quantity = v; }

    public double getPrice()                         { return price; }
    public void   setPrice(double v)                 { this.price = v; }

    public double getSubtotal()                      { return price * quantity; }
}