package grocery_dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import grocery_model.User;
import grocery_utilities.DBGroceryConfig;
import grocery_utilities.PasswordUtil; // Ensure this is imported

public class UserDAO {

    // ── Register new user ─────────────────────────────────────────────────────
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password, phone, address, role, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, PasswordUtil.getHashPassword(user.getPassword()));
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());
            ps.setString(7, user.getStatus());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ── Login ─────────────────────────────────────────────────────────────────
    public User login(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email=? AND status='active'";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedHash = rs.getString("password");
                if (PasswordUtil.checkPassword(password, storedHash)) {
                    user = mapRow(rs);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return user;
    }

    // ── Get user by ID ────────────────────────────────────────────────────────
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id=? AND status='active'";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ── Update user profile ───────────────────────────────────────────────────
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET full_name=?, phone=?, address=? WHERE user_id=?";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getUserId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ── Admin: get all users with optional keyword + role filter ──────────────
    public List<User> getAllUsersFiltered(String keyword, String roleFilter) {
        List<User> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT user_id, full_name, email, phone, address, role, status, created_at " +
            "FROM users WHERE 1=1 "
        );
        if (roleFilter != null && !roleFilter.trim().isEmpty()) {
            sql.append("AND role = ? ");
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (full_name LIKE ? OR email LIKE ? OR phone LIKE ?) ");
        }
        sql.append("ORDER BY user_id DESC");

        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            if (roleFilter != null && !roleFilter.trim().isEmpty()) {
                ps.setString(idx++, roleFilter.trim());
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                String k = "%" + keyword.trim() + "%";
                ps.setString(idx++, k);
                ps.setString(idx++, k);
                ps.setString(idx++, k);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getString("status"));
                list.add(u);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ── Admin: update user active/inactive status ─────────────────────────────
    public boolean updateUserStatus(int userId, String newStatus) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ── Admin: delete user ────────────────────────────────────────────────────
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
    
    
 //   Change Password
    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, PasswordUtil.getHashPassword(newPassword)); // BCrypt hash
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── Admin: count stats ────────────────────────────────────────────────────
    public int getTotalUserCount() {
        return countWhere(null);
    }

    public int getUserCountByStatus(String status) {
        return countWhere(status);
    }

    private int countWhere(String status) {
        String sql = status == null
            ? "SELECT COUNT(*) FROM users"
            : "SELECT COUNT(*) FROM users WHERE status = ?";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (status != null) ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

   
    private User mapRow(ResultSet rs) throws Exception {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));  
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getString("status"));
        return u;
    }
}