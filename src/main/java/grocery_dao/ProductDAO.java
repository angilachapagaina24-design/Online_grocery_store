package grocery_dao;
 
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import grocery_model.Product;
import grocery_utilities.DBGroceryConfig;
 
public class ProductDAO {

    // ── Fetch ALL products (initial page load) ────────────────────────────────
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ── Fetch by category NAME via JOIN with category table ───────────────────
    public List<Product> getProductsByCategoryName(String categoryName) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.* FROM product p " +
                     "JOIN category c ON p.category_id = c.category_id " +
                     "WHERE LOWER(c.category_name) = LOWER(?)";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, categoryName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ── Fetch by category ID ──────────────────────────────────────────────────
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE category_id = ?";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ── Search by keyword ─────────────────────────────────────────────────────
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE " +
                     "LOWER(name) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?)";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String k = "%" + keyword + "%";
            ps.setString(1, k);
            ps.setString(2, k);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ── CRUD ──────────────────────────────────────────────────────────────────
    public boolean addProduct(Product p) {
        String sql = "INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand, expiry_date, status) " +
                     "VALUES (?,?,?,?,?,?,?,?,?,?)";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, p.getCategoryId());
            ps.setString(2, p.getName());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getStockQuantity());
            ps.setString(6, p.getUnit());
            ps.setString(7, p.getImageUrl());
            ps.setString(8, p.getBrand());
            ps.setString(9, p.getExpiryDate());
            ps.setString(10, p.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product p) {
        String sql = "UPDATE product SET category_id=?, name=?, description=?, price=?, " +
                     "stock_quantity=?, unit=?, image_url=?, brand=?, expiry_date=?, status=? " +
                     "WHERE product_id=?";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, p.getCategoryId());
            ps.setString(2, p.getName());
            ps.setString(3, p.getDescription());
            ps.setDouble(4, p.getPrice());
            ps.setInt(5, p.getStockQuantity());
            ps.setString(6, p.getUnit());
            ps.setString(7, p.getImageUrl());
            ps.setString(8, p.getBrand());
            ps.setString(9, p.getExpiryDate());
            ps.setString(10, p.getStatus());
            ps.setInt(11, p.getProductId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM product WHERE product_id = ?";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Row mapper ────────────────────────────────────────────────────────────
    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setName(rs.getString("name"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setStockQuantity(rs.getInt("stock_quantity"));
        p.setUnit(rs.getString("unit"));
        p.setImageUrl(rs.getString("image_url"));
        p.setBrand(rs.getString("brand"));
        p.setExpiryDate(rs.getString("expiry_date"));
        p.setStatus(rs.getString("status"));
        return p;
    }

    public Object getTotalProductCount() {
        // TODO Auto-generated method stub
        return null;
    }
}