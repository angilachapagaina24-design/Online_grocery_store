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
import java.sql.SQLException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

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

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String paymentMethod = request.getParameter("paymentMethod");

        String shippingAddress = fullName + ", " + phone + ", " + address + ", " + city;

        double total = 0;
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }

        OrderDAO dao = new OrderDAO();

        // ONLY ONE STOCK CHECK (inside DAO is enough)
        try {

            int orderId = dao.placeOrder(
                    user.getUserId(),
                    total,
                    shippingAddress,
                    paymentMethod,
                    cart
            );

            if (orderId != -1) {

                session.removeAttribute("cart");

                response.sendRedirect(
                        request.getContextPath()
                                + "/orderConfirmed?orderId="
                                + orderId
                );

            } else {

                request.setAttribute(
                        "errorMsg",
                        "Order failed. Please try again."
                );

                request.setAttribute("cart", cart);
                request.setAttribute("total", total);
                request.setAttribute("user", user);

                request.getRequestDispatcher(
                        "/pages/Checkout.jsp"
                ).forward(request, response);
            }

        } catch (RuntimeException ex) {

            request.setAttribute("errorMsg", ex.getMessage());
            request.setAttribute("cart", cart);
            request.setAttribute("total", total);
            request.setAttribute("user", user);

            request.getRequestDispatcher("/pages/Checkout.jsp")
                    .forward(request, response);
        }
    }
}