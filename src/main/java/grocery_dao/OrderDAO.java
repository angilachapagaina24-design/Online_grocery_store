package grocery_dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import grocery_model.Order;
import grocery_model.CartItem;
import grocery_utilities.DBGroceryConfig;
 
public class OrderDAO {
 
    public int getTotalOrderCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
 
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
 
    public double getTotalSalesAmount() {
        double total = 0;
        String sql = "SELECT SUM(total_amount) FROM orders WHERE order_status='delivered'";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
 
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }
 
    public List<Order> getRecentOrders(int limit) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.order_id, u.full_name, o.total_amount, o.order_status " +
                     "FROM orders o JOIN users u ON o.user_id = u.user_id " +
                     "ORDER BY o.order_id DESC LIMIT ?";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrder_status(rs.getInt("order_id"));         
                    o.setUserName(rs.getString("full_name"));
                    o.setTotal_amount(rs.getDouble("total_amount"));
                    o.setOrder_status(rs.getString("order_status"));
                    list.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
 
    public int placeOrder(int userId, double totalAmount,
<<<<<<< HEAD
                          String shippingAddress, String paymentMethod,
                          List<CartItem> cartItems) throws SQLException {
 
        String orderSql = "INSERT INTO orders (user_id, total_amount, shipping_address, payment_method) " +
                          "VALUES (?, ?, ?, ?)";
        String itemSql  = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price) " +
                          "VALUES (?, ?, ?, ?, ?)";
        int generatedOrderId = -1;
 
        try (Connection con = DBGroceryConfig.getConnection()) {
            con.setAutoCommit(false);
 
            // Step 1: Insert into orders table
            try (PreparedStatement ps = con.prepareStatement(
                    orderSql, Statement.RETURN_GENERATED_KEYS)) {
 
                ps.setInt(1, userId);
                ps.setDouble(2, totalAmount);
                ps.setString(3, shippingAddress);
                ps.setString(4, paymentMethod);
                ps.executeUpdate();
 
                try (ResultSet keys = ps.getGeneratedKeys()) {  // Fix: close ResultSet properly
                    if (keys.next()) {
                        generatedOrderId = keys.getInt(1);
                    }
                }
            }
 
            // Step 2: Insert each cart item into order_items table
            if (generatedOrderId != -1) {
                try (PreparedStatement ps = con.prepareStatement(itemSql)) {
                    for (CartItem item : cartItems) {
                        ps.setInt(1, generatedOrderId);
                        ps.setInt(2, item.getId());
                        ps.setString(3, item.getName());
                        ps.setInt(4, item.getQuantity());
                        ps.setDouble(5, item.getPrice());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }
 
            con.commit();
 
        } Connection con = null;
        try {
            con = DBGroceryConfig.getConnection();
            con.setAutoCommit(false);
            // ... your insert logic ...
            con.commit();
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            generatedOrderId = -1;
        } finally {
            if (con != null) try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        }
		return generatedOrderId;
=======
            String shippingAddress, String paymentMethod,
            List<CartItem> cartItems) {

String orderSql = "INSERT INTO orders (user_id, total_amount, shipping_address, payment_method) " +
            "VALUES (?, ?, ?, ?)";
String itemSql  = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price) " +
            "VALUES (?, ?, ?, ?, ?)";
int generatedOrderId = -1;
Connection con = null;

try {
con = DBGroceryConfig.getConnection();
con.setAutoCommit(false);

// Step 1: Insert into orders table
try (PreparedStatement ps = con.prepareStatement(
      orderSql, Statement.RETURN_GENERATED_KEYS)) {

  ps.setInt(1, userId);
  ps.setDouble(2, totalAmount);
  ps.setString(3, shippingAddress);
  ps.setString(4, paymentMethod);
  ps.executeUpdate();

  try (ResultSet keys = ps.getGeneratedKeys()) {
      if (keys.next()) {
          generatedOrderId = keys.getInt(1);
      }
  }
}

// Step 2: Insert each cart item into order_items table
if (generatedOrderId != -1) {
  try (PreparedStatement ps = con.prepareStatement(itemSql)) {
      for (CartItem item : cartItems) {
          ps.setInt(1, generatedOrderId);
          ps.setInt(2, item.getId());
          ps.setString(3, item.getName());
          ps.setInt(4, item.getQuantity());
          ps.setDouble(5, item.getPrice());
          ps.addBatch();
      }
      ps.executeBatch();
  }
}

con.commit();

} catch (Exception e) {
if (con != null) {
  try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
}
e.printStackTrace();
generatedOrderId = -1;
} finally {
if (con != null) {
  try { con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
}
}

return generatedOrderId;

>>>>>>> dbf3f1d1bde20d4cd11bb97dca094f943e274213
    }
}
 