package grocery_controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
import grocery_model.CartItem;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        String action = request.getParameter("action");

        // ADD ITEM
        if ("add".equals(action)) {

            String idParam    = request.getParameter("id");
            String nameParam  = request.getParameter("name");
            String priceParam = request.getParameter("price");

            // Guard against missing parameters
            if (idParam != null && nameParam != null && priceParam != null) {

                int    id    = Integer.parseInt(idParam);
                String name  = nameParam;
                double price = Double.parseDouble(priceParam);

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
        }

        // REMOVE ITEM
        else if ("remove".equals(action)) {

            String idParam = request.getParameter("id");

            if (idParam != null) {
                int id = Integer.parseInt(idParam);
                cart.removeIf(item -> item.getId() == id);
            }
        }

        // UPDATE QTY
        else if ("update".equals(action)) {

            String idParam  = request.getParameter("id");
            String qtyParam = request.getParameter("qty");

            if (idParam != null && qtyParam != null) {

                int id  = Integer.parseInt(idParam);
                int qty = Integer.parseInt(qtyParam);

                // Remove item if qty drops to 0 or below
                if (qty <= 0) {
                    cart.removeIf(item -> item.getId() == id);
                } else {
                    for (CartItem item : cart) {
                        if (item.getId() == id) {
                            item.setQuantity(qty);
                            break;
                        }
                    }
                }
            }
        }

        session.setAttribute("cart", cart);

        // FIX: redirect through the servlet, not directly to cart.jsp
       // response.sendRedirect(request.getContextPath() + "/cart");
        //response.sendRedirect(request.getHeader("referer"));
        
        String referer = request.getHeader("referer");
        if (referer != null) {
            response.sendRedirect(referer.split("#")[0]); // remove anchor
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
        
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // FIX: use context-relative path so it works from any URL depth
        request.getRequestDispatcher("/pages/Cart.jsp").forward(request, response);
    }
}