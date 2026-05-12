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

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Admin check
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pidStr = request.getParameter("productId");
        if (pidStr == null) {
            response.sendRedirect(request.getContextPath() + "/inventory?errorMsg=Missing+product+ID");
            return;
        }

        try {
            int productId = Integer.parseInt(pidStr);
            ProductDAO dao = new ProductDAO();
            boolean ok = dao.deleteProduct(productId);

            if (ok) {
                response.sendRedirect(request.getContextPath() + "/inventory?successMsg=Product+Deleted!");
            } else {
                response.sendRedirect(request.getContextPath() + "/inventory?errorMsg=Delete+failed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/inventory?errorMsg=Invalid+product+ID");
        }
    }
}
