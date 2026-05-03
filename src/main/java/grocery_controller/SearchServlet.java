package grocery_controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import grocery_dao.ProductDAO;
import grocery_model.Product;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("q");
        if (keyword == null) keyword = "";
        keyword = keyword.trim();

        List<Product> results = new ArrayList<>();

        try {
            if (!keyword.isEmpty()) {
                ProductDAO dao = new ProductDAO();
                results = dao.searchProducts(keyword);
            }
        } catch (Exception e) {   // ← ClassNotFoundException पनि catch हुन्छ
            e.printStackTrace();
        }

        request.setAttribute("results", results);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/pages/Search.jsp").forward(request, response);
    }
}