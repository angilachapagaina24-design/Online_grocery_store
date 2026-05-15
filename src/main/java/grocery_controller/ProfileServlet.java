package grocery_controller;

import grocery_dao.UserDAO;
import grocery_model.User;
import grocery_utilities.PasswordUtil;
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
        String action = request.getParameter("action");

        // --- CHANGE PASSWORD ---
        if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword     = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (currentPassword == null || newPassword == null || confirmPassword == null
                    || currentPassword.isBlank() || newPassword.isBlank()) {
                request.setAttribute("passError", "Sabai fields bharnu parcha!");
                request.setAttribute("user", sessionUser);
                request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
                return;
            }
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("passError", "New password ra confirm password match bhayena!");
                request.setAttribute("user", sessionUser);
                request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
                return;
            }
            if (newPassword.length() < 6) {
                request.setAttribute("passError", "Password kam se kam 6 characters ko hunu parcha!");
                request.setAttribute("user", sessionUser);
                request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
                return;
            }

            UserDAO userDAO = new UserDAO();
            User dbUser = userDAO.getUserById(sessionUser.getUserId());

            if (!PasswordUtil.checkPassword(currentPassword, dbUser.getPassword())) {
                request.setAttribute("passError", "Haalko password milena!");
                request.setAttribute("user", dbUser);
                request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
                return;
            }

            boolean success = userDAO.changePassword(sessionUser.getUserId(), newPassword);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/profile?successMsg=Password+changed+successfully!");
            } else {
                request.setAttribute("passError", "Password change garna sakiena, pheri try garnus!");
                request.setAttribute("user", dbUser);
                request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
            }
            return;  // ← important
        }

        // --- PROFILE UPDATE ---
        String fullName = request.getParameter("fullName");  // ✅ yaha define hunu parcha
        String phone    = request.getParameter("phone");
        String address  = request.getParameter("address");

        if (fullName == null || fullName.isBlank()) {
            request.setAttribute("errorMsg", "Name cannot be empty.");
            request.setAttribute("user", sessionUser);
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
            sessionUser.setFullName(fullName);
            sessionUser.setPhone(phone);
            sessionUser.setAddress(address);
            session.setAttribute("user", sessionUser);
            response.sendRedirect(request.getContextPath() + "/profile?successMsg=Profile+Updated!");
        } else {
            request.setAttribute("errorMsg", "Failed to update profile. Please try again.");
            request.setAttribute("user", sessionUser);
            request.getRequestDispatcher("/pages/Profile.jsp").forward(request, response);
        }
    }
}