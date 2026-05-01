package grocery_controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null ||
            username.isEmpty() || password.isEmpty()) {

            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user", username);

                response.sendRedirect("dashboard.jsp");
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