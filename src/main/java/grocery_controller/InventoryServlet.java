package grocery_controller;

import grocery_dao.ProductDAO;
import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import grocery_model.Product;

@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> productList;

        String keyword = request.getParameter("keyword");
        if (keyword != null && !keyword.trim().isEmpty()) {
            productList = productDAO.searchProducts(keyword.trim());
        } else {
            productList = productDAO.getAllProducts();
        }

        // Pass URL success/error messages through to JSP
        String successMsg = request.getParameter("successMsg");
        String errorMsg   = request.getParameter("errorMsg");
        if (successMsg != null) request.setAttribute("successMsg", successMsg);
        if (errorMsg   != null) request.setAttribute("errorMsg",   errorMsg);

        request.setAttribute("productList", productList);
        request.getRequestDispatcher("/pages/inventory.jsp").forward(request, response);
    }
}
