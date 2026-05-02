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

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        ProductDAO productDAO = new ProductDAO();
        OrderDAO orderDAO     = new OrderDAO();

        int totalProducts = productDAO.getTotalProductCount();
        int totalOrders   = orderDAO.getTotalOrderCount();
        double totalSales = orderDAO.getTotalSalesAmount();

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalSales", String.format("%.2f", totalSales));

        List<Product> productList  = productDAO.getAllProducts();
        List<Order>   recentOrders = orderDAO.getRecentOrders(5);

        request.setAttribute("productList", productList);
        request.setAttribute("recentOrders", recentOrders);

        //
        request.getRequestDispatcher("/pages/dashboard.jsp")
               .forward(request, response);
    }
}