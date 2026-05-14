package grocery_dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import grocery_model.Order;
import grocery_model.CartItem;
import grocery_utilities.DBGroceryConfig;

public class OrderDAO {

    // ── Dashboard: total order count ─────────────────────────────────────────
    public int getTotalOrderCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }

    // ── Dashboard: total sales (delivered orders only) ────────────────────────
    public double getTotalSalesAmount() {
        double total = 0;
        String sql = "SELECT COALESCE(SUM(total_amount),0) FROM orders WHERE order_status='delivered'";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return total;
    }

    // ── Dashboard: recent orders (last N) ─────────────────────────────────────
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
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ── Admin: get ALL orders with optional status/keyword filter ─────────────
    public List<Order> getAllOrdersFiltered(String statusFilter, String keyword) {
        List<Order> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT o.order_id, u.full_name, o.total_amount, o.order_status, " +
            "       o.payment_method, o.payment_status, o.delivery_address, o.order_date " +
            "FROM orders o " +
            "JOIN users u ON o.user_id = u.user_id " +
            "WHERE 1=1 "
        );

        if (statusFilter != null && !statusFilter.trim().isEmpty()) {
            sql.append("AND o.order_status = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR CAST(o.order_id AS CHAR) LIKE ?) ");
        }
        sql.append("ORDER BY o.order_id DESC");

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            int idx = 1;
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                ps.setString(idx++, statusFilter.trim());
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                String k = "%" + keyword.trim() + "%";
                ps.setString(idx++, k);
                ps.setString(idx++, k);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setOrderId(rs.getInt("order_id"));
                    o.setUserName(rs.getString("full_name"));
                    o.setTotalAmount(rs.getDouble("total_amount"));
                    o.setOrderStatus(rs.getString("order_status"));
                    o.setPaymentMethod(rs.getString("payment_method"));
                    o.setPaymentStatus(rs.getString("payment_status"));
                    o.setShippingAddress(rs.getString("delivery_address"));
                    o.setCreatedAt(rs.getString("order_date"));
                    list.add(o);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ── Admin: update order status ────────────────────────────────────────────
    public boolean updateOrderStatus(int orderId, String newStatus) {
        // Valid statuses: pending, confirmed, shipped, delivered, cancelled
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Customer: get orders by user ID ───────────────────────────────────────
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
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ── Place order with stock deduction (atomic transaction) ─────────────────
    public int placeOrder(int userId, double totalAmount, String shippingAddress,
                          String paymentMethod, List<CartItem> cartItems) {

        String orderSql = "INSERT INTO orders (user_id, total_amount, delivery_address, payment_method) " +
                "VALUES (?, ?, ?, ?)";
        String itemSql  = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price) " +
                          "VALUES (?, ?, ?, ?, ?)";
        String stockSql = "UPDATE product SET stock_quantity = stock_quantity - ? " +
                          "WHERE product_id = ? AND stock_quantity >= ?";

        int orderId = -1;
        Connection con = null;

        try {
            con = DBGroceryConfig.getConnection();
            con.setAutoCommit(false);

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

            try (PreparedStatement itemPs  = con.prepareStatement(itemSql);
                 PreparedStatement stockPs = con.prepareStatement(stockSql)) {

                for (CartItem item : cartItems) {
                    stockPs.setInt(1, item.getQuantity());
                    stockPs.setInt(2, item.getId());
                    stockPs.setInt(3, item.getQuantity());
                    int updated = stockPs.executeUpdate();
                    if (updated == 0) {
                        throw new RuntimeException(item.getName() + " is out of stock or insufficient quantity.");
                    }

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
            throw ex;
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return -1;
        } finally {
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return orderId;
    }
}
