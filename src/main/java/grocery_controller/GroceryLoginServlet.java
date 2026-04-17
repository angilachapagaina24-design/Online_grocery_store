package grocery_controller;

import grocery_dao.UserDAO;
import grocery_model.User;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "GroceryLoginServlet", urlPatterns = {"/login"})
public class GroceryLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // =========================
        // 1. Get form data
        // =========================
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // =========================
        // 2. Basic validation
        // =========================
        String error = "";

        if (email == null || email.isBlank()) {
            error += "Email is required! ";
        }

        if (password == null || password.isBlank()) {
            error += "Password is required! ";
        }

        // If validation fails
        if (!error.isBlank()) {
            request.setAttribute("error", error);
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
            return;
        }

        // =========================
        // 3. Check user from DB
        // =========================
        UserDAO userDao = new UserDAO();
        User user = userDao.login(email, password);

        // =========================
        // 4. If user not found
        // =========================
        if (user == null) {
            request.setAttribute("error", "Invalid email or password!");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        } else {

            // =========================
            // 5. Create session
            // =========================
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // =========================
            // 6. Role-based redirect (IMPORTANT)
            // =========================
            if (user.getRole().equals("admin")) {
                response.sendRedirect("admin/dashboard.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        }
    }
}