package grocery_controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/freshmart_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "YOUR_PASSWORD"; // Ensure this matches your DB
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fix 1: Added /pages/ so Tomcat can find your JSP
        request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            // Fix 2: Point back to the correct folder
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        // Use try-with-resources to ensure the connection closes automatically
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                
                // Note: Ensure your table has these exact column names
                String sql = "INSERT INTO users(first_name, last_name, mobile, email, password, role) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);

                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, mobile);
                ps.setString(4, email);
                ps.setString(5, password);
                ps.setString(6, "customer"); // Default role so they can login later

                ps.executeUpdate();

                // Fix 3: Redirect to the /login SERVLET, not the JSP file
                response.sendRedirect(request.getContextPath() + "/login");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
        }
    }
}