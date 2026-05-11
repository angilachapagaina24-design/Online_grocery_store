package grocery_controller;

import grocery_dao.OrderDAO;
import grocery_model.CartItem;
import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Login check
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Cart empty check
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Calculate total
        double total = 0;
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }

        request.setAttribute("cart", cart);
        request.setAttribute("total", total);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/pages/Checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Read form fields
        String fullName       = request.getParameter("fullName");
        String phone          = request.getParameter("phone");
        String address        = request.getParameter("address");
        String city           = request.getParameter("city");
        String paymentMethod  = request.getParameter("paymentMethod");

        String shippingAddress = fullName + ", " + phone + ", " + address + ", " + city;

        // Calculate total
        double total = 0;
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }

        // Place order in DB
        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.placeOrder(
            user.getUserId(), total, shippingAddress, paymentMethod, cart
        );

        if (orderId != -1) {
            // Clear cart after successful order
            session.removeAttribute("cart");
            // Pass order id to confirmation page
            response.sendRedirect(request.getContextPath() + "/orderConfirmed?orderId=" + orderId);
        } else {
            request.setAttribute("errorMsg", "Order failed. Please try again.");
            request.setAttribute("cart", cart);
            request.setAttribute("total", total);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/pages/Checkout.jsp").forward(request, response);
        }
        
    }
}