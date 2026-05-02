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
 
        String uri = request.getRequestURI();
        String context = request.getContextPath();
 
        // ---- public pages ----
        if (uri.equals(context + "/") ||
                uri.equals(context + "/home") ||
                uri.equals(context + "/login.jsp") ||
                uri.equals(context + "/login") ||
                uri.equals(context + "/register.jsp") ||
                uri.equals(context + "/register") ||
                uri.startsWith(context + "/css/") ||
                uri.startsWith(context + "/js/") ||
                uri.startsWith(context + "/images/")) {

                chain.doFilter(req, res);
                return;
            }
 
        // ------------ADMIN PAGES-----------------
        if (uri.startsWith(context + "/admin/")) {

            if (user == null) {
                response.sendRedirect(context + "/login.jsp?error=login_required");
                return;
            }

            if (!"admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(context + "/error/unauthorized.jsp");
                return;
            }

            chain.doFilter(req, res);
            return;
        }

        // -----------------USER PAGES---------
        if (uri.startsWith(context + "/user/")) {

            if (user == null) {
                response.sendRedirect(context + "/login.jsp?error=login_required");
                return;
            }

            chain.doFilter(req, res);
            return;
        }
        
        chain.doFilter(req, res);
    }
 
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}