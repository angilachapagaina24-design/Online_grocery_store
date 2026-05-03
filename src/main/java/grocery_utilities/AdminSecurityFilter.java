package grocery_utilities;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import grocery_model.User;
import java.io.IOException;

@WebFilter(urlPatterns = {"/adminDashboard", "/inventory", "/addProduct", "/manageOrders", "/manageUsers"})
public class AdminSecurityFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            // Redirect to login if unauthorized
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
        } else {
            // User is admin, continue to the requested Servlet
            chain.doFilter(req, res);
        }
    }
}