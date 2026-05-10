package grocery_dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import grocery_model.User;
import grocery_utilities.DBGroceryConfig;
import grocery_utilities.PasswordUtil; // Ensure this is imported

public class UserDAO {

    public boolean registerUser(User user) {
        boolean isRegistered = false;
        String sql = "INSERT INTO users (full_name, email, password, phone, address, role, status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            // Correctly calling your utility method
            ps.setString(3, PasswordUtil.getHashPassword(user.getPassword()));
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());
            ps.setString(7, user.getStatus());

            isRegistered = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isRegistered;
    }

    public User login(String email, String password) {
        User user = null;
        // Step 1: Search ONLY by email and status
        String sql = "SELECT * FROM users WHERE email=? AND status='active'";

        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHashedPassword = rs.getString("password");

                // Step 2: Use BCrypt to compare plain text password with hashed password
                if (PasswordUtil.checkPassword(password, storedHashedPassword)) {
                    user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    public User getUserById(int userId) {
        User user = null;
        String sql = "SELECT * FROM users WHERE user_id=? AND status='active'";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET full_name=?, phone=?, address=? WHERE user_id=?";
        try (Connection conn = DBGroceryConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getUserId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}