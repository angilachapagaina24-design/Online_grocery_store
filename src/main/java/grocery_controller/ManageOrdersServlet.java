package grocery_controller;

import grocery_dao.OrderDAO;
import grocery_model.Order;
import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/manageOrders")
public class ManageOrdersServlet extends HttpServlet {
 
    private static final long serialVersionUID = 1L;
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("adminUser") : null;
        if (adminUser == null || !"admin".equalsIgnoreCase(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
 
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
 
        OrderDAO orderDAO = new OrderDAO();
 
        String statusFilter = request.getParameter("status");
        String keyword      = request.getParameter("keyword");
 
        List<Order> orderList = orderDAO.getAllOrdersFiltered(statusFilter, keyword);
 
        String successMsg = request.getParameter("successMsg");
        String errorMsg   = request.getParameter("errorMsg");
        if (successMsg != null) request.setAttribute("successMsg", successMsg);
        if (errorMsg   != null) request.setAttribute("errorMsg",   errorMsg);
 
        request.setAttribute("orderList",    orderList);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("keyword",      keyword);
        request.getRequestDispatcher("/pages/ManageOrders.jsp").forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String action     = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
 
        if ("updateStatus".equals(action) && orderIdStr != null) {
            try {
                int    orderId   = Integer.parseInt(orderIdStr);
                String newStatus = request.getParameter("newStatus");
 
                OrderDAO orderDAO = new OrderDAO();
                boolean ok = orderDAO.updateOrderStatus(orderId, newStatus);
 
                String msg = ok
                    ? "successMsg=Order+%23" + orderId + "+updated+to+" + newStatus
                    : "errorMsg=Failed+to+update+order";
                response.sendRedirect(request.getContextPath() + "/manageOrders?" + msg);
 
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/manageOrders?errorMsg=Invalid+order+ID");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/manageOrders");
        }
    }
}