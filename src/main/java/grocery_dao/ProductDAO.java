package grocery_dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import grocery_model.Product;
import grocery_utilities.DBGroceryConfig;

public class ProductDAO {

    // ── Fetch ALL products ────────────────────────────────────────────────────
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

    // ── Total product count for dashboard ────────────────────────────────────
    public int getTotalProductCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM product";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // ── Best Selling Products ─────────────────────────────────────────────────
    public List<Product> getBestSellingProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, COALESCE(SUM(oi.quantity),0) AS total_sold " +
                     "FROM product p " +
                     "LEFT JOIN order_items oi ON p.product_id = oi.product_id " +
                     "GROUP BY p.product_id " +
                     "ORDER BY total_sold DESC " +
                     "LIMIT 8";

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = mapRow(rs);
                p.setTotalSold(rs.getInt("total_sold")); // ✅ THAPNU
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── Latest Products ───────────────────────────────────────────────────────
    public List<Product> getLatestProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM product ORDER BY product_id DESC LIMIT 8";

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

    // ── Fetch by category NAME ────────────────────────────────────────────────
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
        
        String sql = "SELECT p.* FROM product p " +
                     "JOIN category c ON p.category_id = c.category_id " +
                     "WHERE LOWER(p.name) LIKE LOWER(?) " +           // name: start-with
                     "OR LOWER(c.category_name) = LOWER(?)";          // category: exact match only

        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String kName = keyword.toLowerCase() + "%";   // "b%" → Banana, Broccoli, Butter, Bread
            String kCat  = keyword.toLowerCase();          // "bakery" exact match matra

            ps.setString(1, kName);
            ps.setString(2, kCat);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── Get single product by ID ──────────────────────────────────────────────
    public Product getProductById(int productId) {
        String sql = "SELECT * FROM product WHERE product_id = ?";
        try (Connection con = DBGroceryConfig.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── Add product ───────────────────────────────────────────────────────────
    public boolean addProduct(Product p) {
        String sql = "INSERT INTO product (category_id, name, description, price, stock_quantity, " +
                     "unit, image_url, brand, expiry_date, status) VALUES (?,?,?,?,?,?,?,?,?,?)";

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

    // ── Update product ────────────────────────────────────────────────────────
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

    // ── Delete product ────────────────────────────────────────────────────────
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
    private Product mapRow(ResultSet rs) throws Exception {
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
        Date expiry = rs.getDate("expiry_date");
        p.setExpiryDate(expiry != null ? expiry.toString() : null);
        p.setStatus(rs.getString("status"));
        return p;
    }
}
