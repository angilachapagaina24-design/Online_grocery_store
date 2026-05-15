package grocery_controller;

import grocery_dao.UserDAO;
import grocery_model.User;
import grocery_utilities.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/adminProfile")
public class AdminProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("adminUser") : null;

        if (adminUser == null || !"admin".equalsIgnoreCase(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User admin = userDAO.getUserById(adminUser.getUserId());

        request.setAttribute("adminUser", admin);
        request.getRequestDispatcher("/pages/AdminProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User adminUser = (session != null) ? (User) session.getAttribute("adminUser") : null;

        if (adminUser == null || !"admin".equalsIgnoreCase(adminUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        // ── CHANGE PASSWORD ──
        if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword     = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            UserDAO userDAO = new UserDAO();
            User dbAdmin = userDAO.getUserById(adminUser.getUserId());

            if (!PasswordUtil.checkPassword(currentPassword, dbAdmin.getPassword())) {
                request.setAttribute("passError", "Haalko password milena!");
                request.setAttribute("adminUser", dbAdmin);
                request.getRequestDispatcher("/pages/AdminProfile.jsp").forward(request, response);
                return;
            }
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("passError", "New password match bhayena!");
                request.setAttribute("adminUser", dbAdmin);
                request.getRequestDispatcher("/pages/AdminProfile.jsp").forward(request, response);
                return;
            }
            if (newPassword.length() < 6) {
                request.setAttribute("passError", "Password kam se kam 6 characters hunu parcha!");
                request.setAttribute("adminUser", dbAdmin);
                request.getRequestDispatcher("/pages/AdminProfile.jsp").forward(request, response);
                return;
            }

            boolean ok = userDAO.changePassword(adminUser.getUserId(), newPassword);
            if (ok) {
                response.sendRedirect(request.getContextPath() + "/adminProfile?successMsg=Password+changed!");
            } else {
                request.setAttribute("passError", "Password change garna sakiena!");
                request.setAttribute("adminUser", dbAdmin);
                request.getRequestDispatcher("/pages/AdminProfile.jsp").forward(request, response);
            }
            return;
        }

        // ── UPDATE PROFILE ──
        String fullName = request.getParameter("fullName");
        String phone    = request.getParameter("phone");

        UserDAO userDAO = new UserDAO();
        User updated = new User();
        updated.setUserId(adminUser.getUserId());
        updated.setFullName(fullName);
        updated.setPhone(phone);
        updated.setEmail(adminUser.getEmail());
        updated.setRole("admin");
        updated.setStatus("active");

        boolean ok = userDAO.updateUser(updated);
        if (ok) {
            adminUser.setFullName(fullName);
            adminUser.setPhone(phone);
            session.setAttribute("adminUser", adminUser);
            response.sendRedirect(request.getContextPath() + "/adminProfile?successMsg=Profile+Updated!");
        } else {
            request.setAttribute("errorMsg", "Update garna sakiena!");
            request.setAttribute("adminUser", adminUser);
            request.getRequestDispatcher("/pages/AdminProfile.jsp").forward(request, response);
        }
    }
}