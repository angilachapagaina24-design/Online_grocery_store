package grocery_controller;

import grocery_dao.UserDAO;
import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // Fetch fresh data from DB
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(sessionUser.getUserId());

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");
        String address  = request.getParameter("address");

        // Basic validation
        if (fullName == null || fullName.isBlank()) {
            request.setAttribute("errorMsg", "Name cannot be empty.");
            request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
            return;
        }

        User updatedUser = new User();
        updatedUser.setUserId(sessionUser.getUserId());
        updatedUser.setFullName(fullName);
        updatedUser.setPhone(phone);
        updatedUser.setAddress(address);
        updatedUser.setEmail(sessionUser.getEmail());
        updatedUser.setRole(sessionUser.getRole());
        updatedUser.setStatus("active");

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateUser(updatedUser);

        if (success) {
            // Update session with new name
            sessionUser.setFullName(fullName);
            sessionUser.setPhone(phone);
            sessionUser.setAddress(address);
            session.setAttribute("user", sessionUser);
            response.sendRedirect(request.getContextPath() + "/profile?successMsg=Profile+Updated!");
        } else {
            request.setAttribute("errorMsg", "Failed to update profile. Please try again.");
            request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
        }
    }
}