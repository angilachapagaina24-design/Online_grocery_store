	package grocery_controller;
	import grocery_dao.OrderDAO;
	import grocery_dao.OrderDAO;
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
import java.util.ArrayList;
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

		    HttpSession session = request.getSession(false);
		    User user = (session != null) ? (User) session.getAttribute("user") : null;

		    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
		        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
		        return;
		    }

		    // Existing logic to load products...
		    ProductDAO productDAO = new ProductDAO();
		    request.setAttribute("productList", productDAO.getAllProducts());
		    request.getRequestDispatcher("/pages/inventory.jsp").forward(request, response);
		}
	}
