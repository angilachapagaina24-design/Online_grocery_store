package grocery_controller;

import java.io.IOException;

import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    HttpSession session = request.getSession(false);
	    
	    // Check who is logging out
	    boolean isAdmin = false;
	    if (session != null) {
	        User adminUser = (User) session.getAttribute("adminUser");
	        isAdmin = (adminUser != null);
	        session.invalidate();
	    }

	    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    response.setHeader("Pragma", "no-cache");
	    response.setDateHeader("Expires", 0);

	    // Send admin to login, customer to home
	    if (isAdmin) {
	        response.sendRedirect(request.getContextPath() + "/login");
	    } else {
	        response.sendRedirect(request.getContextPath() + "/home");
	    }
	}
}