package grocery_controller;

import java.io.IOException;

import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check who is logging out
        boolean isAdmin = false;
        if (session != null) {
            User user = (User) session.getAttribute("user");  // ✅ "user" भनेर हेर्नुहोस्
            
            if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
                isAdmin = true;
            }
            
            session.invalidate();  // Session clear गर्नुहोस्
        }
        
        // Cache headers - back button issue रोक्न
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        
        // Role-based redirect
        if (isAdmin) {
            response.sendRedirect(request.getContextPath() + "/adminLogin?message=loggedout");
        } else {
            response.sendRedirect(request.getContextPath() + "/login?message=loggedout");
        }
    }
}