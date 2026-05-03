	package grocery_controller;
	
	import jakarta.servlet.ServletException;
	import jakarta.servlet.annotation.WebServlet;
	import jakarta.servlet.http.*;
	
	import java.io.IOException;
	import java.sql.*;

import grocery_model.User;
	
	@WebServlet("/login")
	public class LoginServlet extends HttpServlet {
	
	    private static final String DB_URL = "jdbc:mysql://localhost:3306/freshmart_db";
	    private static final String DB_USER = "root";
	    private static final String DB_PASSWORD = "YOUR_PASSWORD"; // 🔥 change this
	
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
	        
	        // If the user is already logged in, don't show the login page, just go home
	        if (session != null && session.getAttribute("user") != null) {
	            response.sendRedirect(request.getContextPath() + "/home");
	        } else {
	            // Correct path to your login JSP file
	            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
	        }
	    }
	    
	
	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	
	    	String email = request.getParameter("email");
	        String password = request.getParameter("password");
	
	        if (email == null || password == null ||
	            email.isEmpty() || password.isEmpty()) {
	
	            request.setAttribute("error", "All fields are required!");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	            return;
	        }
	
	        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
	
	            String sql = "SELECT * FROM users WHERE email=? AND password=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	
	            ps.setString(1, email);
	            ps.setString(2, password);
	
	            ResultSet rs = ps.executeQuery();
	
	            if (rs.next()) {
	            	User user = new User();
	                user.setFullName(rs.getString("full_name"));
	                user.setEmail(rs.getString("email"));
	                user.setRole(rs.getString("role"));

	                HttpSession session = request.getSession();
	                session.setAttribute("user", user);
	                
	                if ("admin".equalsIgnoreCase(user.getRole())) {
	                    response.sendRedirect("admin/dashboard");
	                } else {
	                    response.sendRedirect("home");
	                }

	            } else {
	                request.setAttribute("error", "Invalid login!");
	                request.getRequestDispatcher("login.jsp").forward(request, response);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            request.setAttribute("error", "Server error!");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	        }
	    }
	}