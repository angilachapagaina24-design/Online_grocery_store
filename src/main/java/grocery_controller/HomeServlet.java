package grocery_controller;

import java.io.IOException;
import java.util.List;

import grocery_dao.CategoryDAO;
import grocery_dao.ProductDAO;
import grocery_model.Category;
import grocery_model.Product;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();

        List<Category> categoryList = categoryDAO.getAllCategories();
        List<Product> productList = productDAO.getAllProducts();

        request.setAttribute("categoryList", categoryList);
        request.setAttribute("productList", productList);

        // UPDATED: Changed "/pages/home.jsp" to "/pages/Home.jsp" 
        // This must match the exact filename shown in image_c0a29e.png
        RequestDispatcher rd = request.getRequestDispatcher("/pages/Home.jsp");
        rd.forward(request, response);
    }
}