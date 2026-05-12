package grocery_controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name    = request.getParameter("name");
        String email   = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        boolean valid = name    != null && !name.trim().isEmpty()
                     && email   != null && !email.trim().isEmpty()
                     && message != null && !message.trim().isEmpty();

        if (valid) {
            System.out.println("===== New Contact Message =====");
            System.out.println("Name   : " + name.trim());
            System.out.println("Email  : " + email.trim());
            System.out.println("Subject: " + (subject != null ? subject.trim() : "N/A"));
            System.out.println("Message: " + message.trim());
            System.out.println("================================");
            request.setAttribute("showPopup", true);
        } else {
            request.setAttribute("showPopup", false);
        }

       
        request.getRequestDispatcher("/pages/contact.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("showPopup", false);
        request.getRequestDispatcher("/pages/contact.jsp").forward(request, response);
    }
}