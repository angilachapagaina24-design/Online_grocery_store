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
import grocery_model.Product;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        request.setAttribute("categoryList", categoryDAO.getAllCategories());

        String category = request.getParameter("category");
        String search   = request.getParameter("search");

        List<Product> productList;

        if (search != null && !search.trim().isEmpty()) {
            productList = productDAO.searchProducts(search.trim());
            request.setAttribute("activeCategory", "Search: " + search.trim());
        } else if (category != null && !category.trim().isEmpty()) {
            productList = productDAO.getProductsByCategoryName(category.trim()); // ← FIXED
            System.out.println("Category: " + category + " | Results: " + productList.size());
            request.setAttribute("activeCategory", category.trim());
        } else {
            productList = productDAO.getAllProducts();
            System.out.println(">>> PRODUCT LIST SIZE: " + productList.size());
            request.setAttribute("activeCategory", "All Products");
        }

        request.setAttribute("productList", productList);
        request.setAttribute("selectedCategory", category);
        request.getRequestDispatcher("/pages/Product.jsp").forward(request, response);
    }
}