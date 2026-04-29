package grocery_controller;
 
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
 
/**
 * LogoutServlet - invalidates the user session and redirects to login page.
 * URL: /logout
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        // Get existing session (don't create a new one)
        HttpSession session = request.getSession(false);
 
        // Invalidate session if it exists
        if (session != null) {
            session.invalidate();
        }
 
        // Redirect to login page with logout message
        response.sendRedirect("login.jsp?logout=true");
    }
}