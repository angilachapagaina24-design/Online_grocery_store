package grocery_controller;

import java.io.IOException;
import grocery_dao.CategoryDAO;
import java.util.List;


import grocery_dao.ProductDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import grocery_model.Product;
import grocery_model.Category;
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)

            throws ServletException, IOException {

        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();

        // Get categories
        List<Category> categoryList =
                categoryDAO.getAllCategories();

        // Get products
        List<Product> productList =
                productDAO.getAllProducts();

        // Send to JSP
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("productList", productList);

        RequestDispatcher rd =
                request.getRequestDispatcher("index.jsp");

        rd.forward(request, response);
    }
}