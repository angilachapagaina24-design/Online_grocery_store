package grocery_utilities;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import grocery_model.User;
import java.io.IOException;

@WebFilter(urlPatterns = {
	    "/adminDashboard",
	    "/inventory",
	    "/addProduct",
	    "/editProduct",
	    "/deleteProduct",
	    "/manageOrders",
	    "/manageUsers"
	})
	public class AdminSecurityFilter implements Filter {

	    @Override
	    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
	            throws IOException, ServletException {

	        HttpServletRequest  request  = (HttpServletRequest)  req;
	        HttpServletResponse response = (HttpServletResponse) res;

	        HttpSession session  = request.getSession(false);
	        // Check adminUser key, NOT "user"
	        User adminUser = (session != null) 
	                       ? (User) session.getAttribute("adminUser") 
	                       : null;

	        if (adminUser == null || !"admin".equalsIgnoreCase(adminUser.getRole())) {
	            // Not logged in as admin → send to login
	            response.sendRedirect(request.getContextPath() + "/login?error=admin_required");
	        } else {
	            // Logged in as admin → allow through, no re-login needed
	            chain.doFilter(req, res);
	        }
	    }

	    @Override public void init(FilterConfig fc) throws ServletException {}
	    @Override public void destroy() {}
	}