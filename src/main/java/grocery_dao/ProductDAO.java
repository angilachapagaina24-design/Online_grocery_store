package grocery_dao;
 
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import grocery_model.Product;
import grocery_utilities.DBGroceryConfig;
 
/**
 * Data Access Object for Product.
 * Handles all DB operations related to the 'product' table.
 */
public class ProductDAO {
 
    // -------------------------------------------------------
    // Get all available products (for homepage / product page)
    // -------------------------------------------------------
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE status='available'";
 
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
 
    // -------------------------------------------------------
    // Get products by category (for category filter)
    // -------------------------------------------------------
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE category_id=? AND status='available'";
 
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
 
    // -------------------------------------------------------
    // Search products by name (for search bar)
    // -------------------------------------------------------
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product WHERE name LIKE ? AND status='available'";
 
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
 
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
 
    // -------------------------------------------------------
    // Get single product by ID
    // -------------------------------------------------------
    public Product getProductById(int productId) {
        Product product = null;
        String sql = "SELECT * FROM product WHERE product_id=?";
 
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
 
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = mapRow(rs);
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
 
    // -------------------------------------------------------
    // ADMIN: Add new product
    // -------------------------------------------------------
    public boolean addProduct(Product p) {
        String sql = "INSERT INTO product (category_id, name, description, price, stock_quantity, unit, image_url, brand, expiry_date, status) VALUES (?,?,?,?,?,?,?,?,?,?)";
 
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
 
    // -------------------------------------------------------
    // ADMIN: Update existing product
    // -------------------------------------------------------
    public boolean updateProduct(Product p) {
        String sql = "UPDATE product SET category_id=?, name=?, description=?, price=?, stock_quantity=?, unit=?, image_url=?, brand=?, expiry_date=?, status=? WHERE product_id=?";
 
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
 
    // -------------------------------------------------------
    // ADMIN: Delete product by ID
    // -------------------------------------------------------
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM product WHERE product_id=?";
 
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
 
            ps.setInt(1, productId);
            return ps.executeUpdate() > 0;
 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
 
    // -------------------------------------------------------
    // Helper: Map ResultSet row to Product object
    // -------------------------------------------------------
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
        p.setStatus(rs.getString("status"));
        return p;
    }
}