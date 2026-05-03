package grocery_controller;

import grocery_dao.ProductDAO;
import grocery_dao.OrderDAO;
import grocery_model.Product;
import grocery_model.User;
import grocery_model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	   
	@Override    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Load your database stats (Sales, Orders, etc.)
        loadDashboardData(request);
        
        // 2. Forward to the actual JSP file
        
        request.getRequestDispatcher("/pages/Admin.jsp").forward(request, response);
    }

    private void loadDashboardData(HttpServletRequest request) {
        ProductDAO productDAO = new ProductDAO();
        OrderDAO orderDAO = new OrderDAO();

        request.setAttribute("totalProducts", productDAO.getTotalProductCount());
        request.setAttribute("totalOrders", orderDAO.getTotalOrderCount());
        request.setAttribute("totalSales", String.format("%.2f", orderDAO.getTotalSalesAmount()));

        request.setAttribute("productList", productDAO.getAllProducts());
        request.setAttribute("recentOrders", orderDAO.getRecentOrders(5));
    }
}