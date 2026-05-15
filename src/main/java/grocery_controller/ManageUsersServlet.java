package grocery_controller;

import grocery_dao.UserDAO;
import grocery_model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/manageUsers")
public class ManageUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("user") == null){
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDAO userDAO = new UserDAO();

        String keyword = request.getParameter("keyword");
        String role = request.getParameter("role");

        List<User> userList = userDAO.getAllUsersFiltered(keyword, role);

        request.setAttribute("userList", userList);

        request.getRequestDispatcher("/pages/manageUsers.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO userDAO = new UserDAO();

        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));

        if ("deleteUser".equals(action)) {

            userDAO.deleteUser(userId);

        } else if ("toggleStatus".equals(action)) {

            String currentStatus = request.getParameter("currentStatus");

            String newStatus =
                    currentStatus.equals("active")
                    ? "inactive"
                    : "active";

            userDAO.updateUserStatus(userId, newStatus);
        }

        response.sendRedirect(request.getContextPath() + "/manageUsers");
    }
}