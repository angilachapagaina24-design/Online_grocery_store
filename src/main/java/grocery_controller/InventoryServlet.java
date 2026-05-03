package grocery_controller;
 
import grocery_dao.ProductDAO;
import grocery_model.Product;
import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
 
/**
 * InventoryServlet
 * URL: /admin/inventory
 * GET  → shows all products (or search results)
 */
@WebServlet("/inventory")
public class InventoryServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	
    	// SESSION CHECK 
    	HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        ProductDAO productDAO = new ProductDAO();
        
     // SEARCH FUNCTION 
        String keyword = request.getParameter("keyword");
 
        List<Product> productList;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            productList = productDAO.searchProducts(keyword);
        } else {
            productList = productDAO.getAllProducts();
        }

        request.setAttribute("productList", productList);
        
        // LOAD DASHBOARD DATA 
        loadDashboardData(request);
 
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

	private void loadDashboardData(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
	}
}
