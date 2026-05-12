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
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public double getTotalSalesAmount() {
        double total = 0;
        String sql = "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE order_status='delivered'";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getDouble(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Order> getRecentOrders(int limit) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.order_id, u.full_name, o.total_amount, o.order_status " +
                     "FROM orders o " +
                     "JOIN users u ON o.user_id = u.user_id " +
                     "ORDER BY o.order_id DESC LIMIT ?";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("order_id"));
                    o.setUserName(rs.getString("full_name"));
                    o.setTotalAmount(rs.getDouble("total_amount"));
                    o.setOrderStatus(rs.getString("order_status"));
                    list.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── Place Order with stock deduction ─────────────────────────────────────
    public int placeOrder(int userId, double totalAmount, String shippingAddress,
                          String paymentMethod, List<CartItem> cartItems) {

    	String orderSql = "INSERT INTO orders (user_id, total_amount, delivery_address, payment_method) " +
                "VALUES (?, ?, ?, ?)";
        String itemSql  = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price) " +
                          "VALUES (?, ?, ?, ?, ?)";
        // Atomic stock update — prevents overselling
        String stockSql = "UPDATE product SET stock_quantity = stock_quantity - ? " +
                          "WHERE product_id = ? AND stock_quantity >= ?";
        

        int orderId = -1;
        Connection con = null;

        try {
            con = DBGroceryConfig.getConnection();
            con.setAutoCommit(false);

            // 1. Create order
            try (PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setDouble(2, totalAmount);
                ps.setString(3, shippingAddress);
                ps.setString(4, paymentMethod);
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) orderId = rs.getInt(1);
                }
            }

            if (orderId == -1) { con.rollback(); return -1; }

            // 2. Insert items + deduct stock
            try (PreparedStatement itemPs  = con.prepareStatement(itemSql);
                 PreparedStatement stockPs = con.prepareStatement(stockSql)) {

                for (CartItem item : cartItems) {
                    // Deduct stock (atomic)
                    stockPs.setInt(1, item.getQuantity());
                    stockPs.setInt(2, item.getId());
                    stockPs.setInt(3, item.getQuantity());
                    int updated = stockPs.executeUpdate();
                    if (updated == 0) {
                        throw new RuntimeException(item.getName() + " is out of stock or insufficient quantity.");
                    }

                    // Insert order item
                    itemPs.setInt(1, orderId);
                    itemPs.setInt(2, item.getId());
                    itemPs.setString(3, item.getName());
                    itemPs.setInt(4, item.getQuantity());
                    itemPs.setDouble(5, item.getPrice());
                    itemPs.addBatch();
                }
                itemPs.executeBatch();
            }

            con.commit();

        } catch (RuntimeException ex) {
            if (con != null) try { con.rollback(); } catch (SQLException e) { e.printStackTrace(); }
            throw ex;  // re-throw so CheckoutServlet can show message
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return -1;
        } finally {
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return orderId;
    }

    // ── Orders for a specific user (My Orders) ────────────────────────────────
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT order_id, total_amount, order_status, payment_method, order_date, delivery_address " +
                "FROM orders WHERE user_id = ? ORDER BY order_id DESC";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("order_id"));
                    o.setTotalAmount(rs.getDouble("total_amount"));
                    o.setOrderStatus(rs.getString("order_status"));
                    o.setPaymentMethod(rs.getString("payment_method"));
                    o.setShippingAddress(rs.getString("delivery_address"));
                    o.setCreatedAt(rs.getString("order_date"));
                    list.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
