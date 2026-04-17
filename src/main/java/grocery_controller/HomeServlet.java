package grocery_controller;

import java.io.IOException;
import grocery_dao.CategoryDAO;
import java.util.List;


import dao.ProductDAO;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.Category;
import model.Product;
import grocery_model.Category;
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)

            throws ServletException, IOException {

        CategoryDAO categoryDAO =
                new CategoryDAO();

        ProductDAO productDAO =
                new ProductDAO();

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        List<Product> productList =
                productDAO.getAllProducts();

        request.setAttribute(
                "categoryList",
                categoryList);

        request.setAttribute(
                "productList",
                productList);

        RequestDispatcher rd =
                request.getRequestDispatcher("index.jsp");

        rd.forward(request, response);
    }
}