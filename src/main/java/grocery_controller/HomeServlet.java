package grocery_controller;
import java.io.IOException;
import java.util.List;
import grocery_dao.CategoryDAO;
import grocery_dao.ProductDAO;
import grocery_model.Category;
import grocery_model.Product;
import grocery_model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //  Admin session xa bhane adminDashboard pathaucha
        HttpSession session = request.getSession(false);
        if (session != null) {
            User adminUser = (User) session.getAttribute("adminUser");
            if (adminUser != null && "admin".equalsIgnoreCase(adminUser.getRole())) {
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
                return;
            }
        }

        // Normal user lai — home page dekhaucha
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();
        request.setAttribute("categoryList", categoryDAO.getAllCategories());
        request.setAttribute("productList", productDAO.getAllProducts());
        RequestDispatcher rd = request.getRequestDispatcher("/pages/Home.jsp");
        rd.forward(request, response);
    }
}