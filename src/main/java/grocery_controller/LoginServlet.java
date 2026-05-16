	package grocery_controller;
	
	import jakarta.servlet.ServletException;
	import jakarta.servlet.annotation.WebServlet;
	import jakarta.servlet.http.*;
	
	import java.io.IOException;
	import java.sql.*;

import grocery_dao.UserDAO;
import grocery_model.User;
	
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    HttpSession session = request.getSession(false);

	    if (session != null) {
	        // Customer session check
	        User user = (User) session.getAttribute("user");
	        if (user != null) {
	            response.sendRedirect(request.getContextPath() + "/home");
	            return;
	        }
	    }

	    // No session — show login page
	    request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
	}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(email, password);

        if (user != null) {
            HttpSession session = request.getSession(true);

            if ("admin".equalsIgnoreCase(user.getRole())) {
                session.setAttribute("adminUser", user);
            } else {
                session.setAttribute("user", user);
            }

            session.setMaxInactiveInterval(30 * 60);

            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
}
