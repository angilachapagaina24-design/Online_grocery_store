package grocery_controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

import grocery_dao.UserDAO;
import grocery_model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fix 1: Added /pages/ so Tomcat can find your JSP
        request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName       = request.getParameter("firstName");
        String lastName        = request.getParameter("lastName");
        String mobile          = request.getParameter("mobile");
        String email           = request.getParameter("email");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Password match check
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        // User object build gareko
        User user = new User();
        user.setFullName(firstName + " " + lastName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(mobile);
        user.setAddress("");       
        
     // yo chai test garna ko lagi temporarily use gareko ho admin ma register garna
       // user.setRole("admin");
        
        user.setRole("customer");
        user.setStatus("active");

        // UserDAO use gara — direct DB connection chaidaina
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.registerUser(user);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Email may already exist.");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
        }
    }
    
}