package grocery_dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import grocery_model.Order;
import grocery_model.OrderItem;
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
    
    	
 // ── Dashboard: total sales (confirmed/delivered orders) ──────────────────
    public double getTotalSalesAmount() {
        // ✅ delivered matra hoina, confirmed pani count garnu
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders " +
                     "WHERE order_status IN ('delivered', 'confirmed', 'shipped')";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── Dashboard: sales per month for current year ───────────────────────────
    public java.util.Map<String, Double> getMonthlySalesCurrentYear() {
        java.util.Map<String, Double> map = new java.util.LinkedHashMap<>();
        // Sabai 12 months default 0 rakhu
        String[] months = {"Jan","Feb","Mar","Apr","May","Jun",
                           "Jul","Aug","Sep","Oct","Nov","Dec"};
        for (String m : months) map.put(m, 0.0);

        String sql = "SELECT MONTHNAME(order_date) as mon, " +
                     "       MONTH(order_date) as mon_num, " +
                     "       SUM(total_amount) as total " +
                     "FROM orders " +
                     "WHERE YEAR(order_date) = YEAR(CURDATE()) " +
                     "  AND order_status IN ('delivered', 'confirmed', 'shipped') " +
                     "GROUP BY mon_num, mon " +
                     "ORDER BY mon_num";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                // First 3 letters of month name
                String mon = rs.getString("mon").substring(0, 3);
                map.put(mon, rs.getDouble("total"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
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
                    o.setItems(getItemsByOrderId(o.getOrderId()));
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
    
    
    public List<OrderItem> getItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("product_name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                items.add(item);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return items;
    }
    
    

    // ── Customer: get orders by user ID ───────────────────────────────────────
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT order_id, total_amount, order_status, payment_method, order_date, delivery_address " +
                     "FROM orders WHERE user_id = ? ORDER BY order_id DESC";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setShippingAddress(rs.getString("delivery_address"));
                o.setCreatedAt(rs.getString("order_date"));
                o.setItems(getItemsByOrderId(o.getOrderId())); // ✅ items load
                list.add(o);
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
