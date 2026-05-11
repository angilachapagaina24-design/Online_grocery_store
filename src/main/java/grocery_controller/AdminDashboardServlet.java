package grocery_controller;
import grocery_dao.OrderDAO;
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

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Prevent browser caching (IMPORTANT)
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Load fresh data from database
        loadDashboardData(request);

        ProductDAO productDAO = null;
		// Send to JSP page
        request.setAttribute("totalProducts", productDAO.getTotalProductCount());
    }

    private void loadDashboardData(HttpServletRequest request) {

    	ProductDAO productDAO = new ProductDAO();
        OrderDAO orderDAO = new OrderDAO();

        // dashboard stats
        request.setAttribute("totalProducts", productDAO.getTotalProductCount());
        request.setAttribute("totalOrders", orderDAO.getTotalOrderCount());
        request.setAttribute("totalSales",
                String.format("%.2f", orderDAO.getTotalSalesAmount()));

        // data lists
        request.setAttribute("productList", productDAO.getBestSellingProducts());
        request.setAttribute("recentOrders", orderDAO.getRecentOrders(5));
    }
}