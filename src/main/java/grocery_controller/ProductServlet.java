package grocery_controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import grocery_dao.CategoryDAO;
import grocery_dao.ProductDAO;
import grocery_model.Category;
import grocery_model.Product;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Category param check
        String categoryParam = request.getParameter("category");

        List<Product> productList;
        int selectedCategory = 0;

        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                selectedCategory = Integer.parseInt(categoryParam);
                productList = productDAO.getProductsByCategory(selectedCategory);
            } catch (Exception e) {
                productList = productDAO.getAllProducts();
            }
        } else {
            productList = productDAO.getAllProducts();
        }

        List<Category> categoryList = categoryDAO.getAllCategories();

        request.setAttribute("productList", productList);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("selectedCategory", selectedCategory);

        request.getRequestDispatcher("/pages/Product.jsp").forward(request, response);
    }
}