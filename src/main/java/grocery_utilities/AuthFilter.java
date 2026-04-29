package grocery_utilities;
 
import java.io.IOException;
import grocery_model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
 
/**
 * AuthFilter - Role-based access control filter.
 *
 * - /admin/*  → Only accessible by users with role="admin"
 * - /user/*   → Only accessible by logged-in users (any role)
 *
 * Unauthorized users are redirected to the login page.
 */
@WebFilter(urlPatterns = {"/admin/*", "/user/*"})
public class AuthFilter implements Filter {
 
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }
 
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
 
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
 
        // Get session WITHOUT creating a new one
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
 
        String requestURI = request.getRequestURI();
 
        // ---- Check: Admin pages ----
        if (requestURI.contains("/admin/")) {
            if (user == null) {
                // Not logged in → redirect to login
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=login_required");
            } else if (!"admin".equals(user.getRole())) {
                // Logged in but not admin → redirect to unauthorized page
                response.sendRedirect(request.getContextPath() + "/error/unauthorized.jsp");
            } else {
                // Admin user → allow through
                chain.doFilter(req, res);
            }
 
        // ---- Check: User pages ----
        } else if (requestURI.contains("/user/")) {
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=login_required");
            } else {
                chain.doFilter(req, res);
            }
 
        } else {
            // Not a protected URL → allow through
            chain.doFilter(req, res);
        }
    }
 
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}