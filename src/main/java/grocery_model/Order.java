package grocery_model;

public class Order {
    private int id;
    private double total_amount;
    private String order_status;

    // Default Constructor
    public Order() {}

    // Getters and Setters
    public double getTotal_amount() { return total_amount; }
    public void setTotal_amount(double total_amount) { this.total_amount = total_amount; }
    
    public String getOrder_status() { return order_status; }
    public void setOrder_status(String string) { this.order_status = string; }

	public void setUserName(String string) {
		// TODO Auto-generated method stub
		
	}

	public void setOrder_status(int int1) {
		// TODO Auto-generated method stub
		
	}
}