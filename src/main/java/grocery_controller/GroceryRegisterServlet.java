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

@WebServlet(name = "GroceryRegisterServlet", urlPatterns = {"/register"})
public class GroceryRegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // =========================
        // 1. Get form data
        // =========================
        final String fullName = request.getParameter("fullName");
        final String email = request.getParameter("email");
        final String password = request.getParameter("password");
        final String confirmPassword = request.getParameter("cpassword");
        final String phone = request.getParameter("phone");
        final String address = request.getParameter("address");

        // =========================
        // 2. Validation
        // =========================

        // Full Name validation
        final boolean isValidName = fullName != null && fullName.length() >= 3;
        String errorName = isValidName ? "" : "Name must be at least 3 characters! ";

        // Email validation
        final boolean isValidEmail = email != null && email.contains("@");
        String errorEmail = isValidEmail ? "" : "Invalid email! ";

        // Password validation
        final boolean isValidPass = password != null && password.length() >= 6;
        String errorPass = isValidPass ? "" : "Password must be at least 6 characters! ";

        // Confirm password
        final boolean isValidConfirm = password != null && password.equals(confirmPassword);
        String errorConfirm = isValidConfirm ? "" : "Passwords do not match! ";

        // Phone validation
        final boolean isValidPhone = phone != null && phone.length() >= 10;
        String errorPhone = isValidPhone ? "" : "Invalid phone number! ";

        // Combine all errors
        String error = errorName + errorEmail + errorPass + errorConfirm + errorPhone;

        request.setAttribute("error", error);

        // =========================
        // 3. If validation fails
        // =========================
        if (!error.isBlank()) {
            RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
            rd.forward(request, response);
            return;
        }

        // =========================
        // 4. Create User object
        // =========================
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password); // (later you can hash)
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("customer");
        user.setStatus("active");

        // =========================
        // 5. Call DAO
        // =========================
        UserDAO userDAO = new UserDAO();
        boolean isInserted = userDAO.registerUser(user);

        // =========================
        // 6. Response handling
        // =========================
        if (isInserted) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            request.setAttribute("error", "Registration failed! Try again.");
            RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
            rd.forward(request, response);
        }
    }
}