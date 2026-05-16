package grocery_model;

import java.util.ArrayList;
import java.util.List;

public class Order {

    private int    orderId;
    private int    userId;
    private double totalAmount;
    private String orderStatus;
    private String paymentMethod;
    private String paymentStatus;
    private String shippingAddress;
    private String createdAt;
    private String userName;
    
    
    private List<OrderItem> items = new ArrayList<>();

    public Order() {}

    public int getOrderId()                  { return orderId; }
    public void setOrderId(int orderId)      { this.orderId = orderId; }

    public int getUserId()                   { return userId; }
    public void setUserId(int userId)        { this.userId = userId; }

    public double getTotalAmount()           { return totalAmount; }
    public void setTotalAmount(double v)     { this.totalAmount = v; }

    // Legacy alias kept so old JSP expressions still compile
    public double getTotal_amount()          { return totalAmount; }
    public void setTotal_amount(double v)    { this.totalAmount = v; }

    public String getOrderStatus()           { return orderStatus; }
    public void setOrderStatus(String v)     { this.orderStatus = v; }

    // Legacy alias
    public String getOrder_status()          { return orderStatus; }
    public void setOrder_status(String v)    { this.orderStatus = v; }

    public String getPaymentMethod()         { return paymentMethod; }
    public void setPaymentMethod(String v)   { this.paymentMethod = v; }

    public String getPaymentStatus()         { return paymentStatus; }
    public void setPaymentStatus(String v)   { this.paymentStatus = v; }

    public String getShippingAddress()       { return shippingAddress; }
    public void setShippingAddress(String v) { this.shippingAddress = v; }

    public String getCreatedAt()             { return createdAt; }
    public void setCreatedAt(String v)       { this.createdAt = v; }

    public String getUserName()              { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public List<OrderItem> getItems()              { return items; }
    public void setItems(List<OrderItem> items)    { this.items = items; }
}
