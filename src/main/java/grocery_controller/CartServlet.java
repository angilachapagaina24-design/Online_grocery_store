package grocery_controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

import grocery_model.CartItem;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");

        // ADD ITEM
        if ("add".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));

            boolean found = false;

            for (CartItem item : cart) {
                if (item.getId() == id) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }

            if (!found) {
                cart.add(new CartItem(id, name, price, 1));
            }
        }

        // REMOVE ITEM
        else if ("remove".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            cart.removeIf(item -> item.getId() == id);
        }

        // UPDATE QTY
        else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int qty = Integer.parseInt(request.getParameter("qty"));

            for (CartItem item : cart) {
                if (item.getId() == id) {
                    item.setQuantity(qty);
                }
            }
        }

        session.setAttribute("cart", cart);

        response.sendRedirect("cart.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}