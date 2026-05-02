package grocery_controller;
 
import grocery_dao.ProductDAO;
import grocery_model.Product;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
 
import java.io.IOException;
import java.util.List;
 
/**
 * InventoryServlet
 * URL: /admin/inventory
 * GET  → shows all products (or search results)
 */
@WebServlet("/admin/inventory")
public class InventoryServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        ProductDAO productDAO = new ProductDAO();
        String keyword = request.getParameter("keyword");
 
        List<Product> productList;
 
        // If search keyword given → search, else → get all
        if (keyword != null && !keyword.trim().isEmpty()) {
            productList = productDAO.searchProducts(keyword.trim());
        } else {
            productList = productDAO.getAllProducts();
        }
 
        request.setAttribute("productList", productList);
 
        // Forward to inventory.jsp inside admin folder
        request.getRequestDispatcher("/pages/inventory.jsp")
               .forward(request, response);
    }
}