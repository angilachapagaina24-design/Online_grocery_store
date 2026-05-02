package grocery_dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import grocery_model.Order;
import grocery_utilities.DBGroceryConfig;

public class OrderDAO {

    // -------------------------------
    // Total number of orders
    // -------------------------------
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

    // -------------------------------
    // Total sales amount
    // -------------------------------
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

    // -------------------------------
    // Get recent orders (LIMIT)
    // -------------------------------
    public List<Order> getRecentOrders(int limit) {
        List<Order> list = new ArrayList<>();

        String sql = "SELECT o.order_id, u.full_name, o.total_amount, o.order_status " +
                     "FROM orders o JOIN users u ON o.user_id = u.user_id " +
                     "ORDER BY o.order_id DESC LIMIT ?";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setUserName(rs.getString("full_name"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setOrderStatus(rs.getString("order_status"));

                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}