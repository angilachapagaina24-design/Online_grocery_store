	package grocery_controller;
	
	import jakarta.servlet.ServletException;
	import jakarta.servlet.annotation.WebServlet;
	import jakarta.servlet.http.*;
	
	import java.io.IOException;
	import java.sql.*;

import grocery_model.User;
	
	@WebServlet("/login")
	public class LoginServlet extends HttpServlet {
	
		private static final String DB_URL = "jdbc:mysql://localhost:3306/grocery_store?useSSL=false&allowPublicKeyRetrieval=true";
	    private static final String DB_USER = "root";
	    private static final String DB_PASSWORD = "";
	
	    @Override
	    public void init() throws ServletException {
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	        } catch (ClassNotFoundException e) {
	            throw new ServletException("Driver not found", e);
	        }
	    }
	    
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        
	        HttpSession session = request.getSession(false);
	        
	        // Auto-login check: If session exists, skip login page
	        if (session != null && session.getAttribute("user") != null) {
	            User user = (User) session.getAttribute("user");
	            if ("admin".equalsIgnoreCase(user.getRole())) {
	                response.sendRedirect(request.getContextPath() + "/adminDashboard");
	            } else {
	                response.sendRedirect(request.getContextPath() + "/home");
	            }
	        } else {
	            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
	        }
	    }

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        // Basic validation
	        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
	            request.setAttribute("error", "All fields are required!");
	            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
	            return;
	        }

	        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

	            String sql = "SELECT * FROM users WHERE email=? AND password=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, email);
	            ps.setString(2, password);

	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                // ================= CREATE USER OBJECT =================
	                User user = new User();
	                // Matches 'full_name' column in your SQL
	                user.setFullName(rs.getString("full_name")); 
	                user.setEmail(rs.getString("email"));
	                user.setRole(rs.getString("role"));

	                // ================= SESSION HANDLING =================
	                HttpSession session = request.getSession(true);
	                session.setAttribute("user", user);
	                session.setMaxInactiveInterval(30 * 60); // 30 minutes

	                // ================= REDIRECT BASED ON ROLE =================
	                if ("admin".equalsIgnoreCase(user.getRole())) {
	                    // Redirects to AdminDashboardServlet mapping
	                    response.sendRedirect(request.getContextPath() + "/adminDashboard"); 
	                } else {
	                    //  FIXED: Redirects regular customers to home page
	                    response.sendRedirect(request.getContextPath() + "/home");
	                }

	            } else {
	                // Wrong credentials
	                request.setAttribute("error", "Invalid email or password!");
	                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	            // This triggers if DB_URL or DB_PASSWORD is wrong
	            request.setAttribute("error", "Database Connection Error: " + e.getMessage());
	            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
	        } catch (Exception e) {
	            e.printStackTrace();
	            request.setAttribute("error", "An unexpected server error occurred.");
	            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
	        }
	    }
	}