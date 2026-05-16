package grocery_controller;

import grocery_dao.OrderDAO;
import grocery_dao.ProductDAO;
import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        //  adminUser session bata lina parxa
        HttpSession session = request.getSession(false);
        User adminUser = (session != null)
                       ? (User) session.getAttribute("adminUser")
                       : null;

        //  Null check — login nagari access block
        if (adminUser == null || 
        		   !"admin".equalsIgnoreCase(adminUser.getRole())) {

        		    response.sendRedirect(request.getContextPath() + "/login");
        		    return;
        		}

        request.setAttribute("adminUser", adminUser);

        ProductDAO productDAO = new ProductDAO();
        OrderDAO orderDAO = new OrderDAO();

        request.setAttribute("totalProducts", productDAO.getTotalProductCount());
        request.setAttribute("totalOrders",   orderDAO.getTotalOrderCount());
        request.setAttribute("totalSales",    String.format("%.2f", orderDAO.getTotalSalesAmount()));
        request.setAttribute("monthlySales", orderDAO.getMonthlySalesCurrentYear()); 
        request.setAttribute("productList",   productDAO.getBestSellingProducts());
        request.setAttribute("recentOrders",  orderDAO.getRecentOrders(5));
        

        request.getRequestDispatcher("/pages/Admin.jsp").forward(request, response);
    }
}