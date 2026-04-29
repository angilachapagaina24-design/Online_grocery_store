package grocery_dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import grocery_model.Category;
import grocery_utilities.DBGroceryConfig;

public class CategoryDAO {
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();

        try {
            Connection con = DBGroceryConfig.getConnection();
            String sql = "SELECT * FROM category WHERE status='active'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Category c = new Category();

                c.setCategoryId(
                        rs.getInt("category_id"));

                c.setCategoryName(
                        rs.getString("category_name"));

                c.setDescription(
                        rs.getString("description"));

                c.setImageUrl(
                        rs.getString("image_url"));

                list.add(c);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }
}