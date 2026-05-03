package grocery_controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private static final String FROM_EMAIL = "yourgmail@gmail.com";
    private static final String PASSWORD = "your_app_password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	request.getRequestDispatcher("/pages/Contact.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String messageText = request.getParameter("message");

        try {
            sendEmail(name, email, subject, messageText);
            request.setAttribute("message", "Message sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Failed to send message.");
        }

        request.getRequestDispatcher("/pages/Contact.jsp").forward(request, response);
    }

    private void sendEmail(String name, String email, String subject, String messageText) throws Exception {

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
                    }
                });

        Message message = new MimeMessage(session);

        message.setFrom(new InternetAddress(FROM_EMAIL));
        message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(FROM_EMAIL)); // send to yourself

        message.setSubject("FreshMart Contact: " + subject);

        message.setText(
                "Name: " + name + "\n"
              + "Email: " + email + "\n\n"
              + "Message:\n" + messageText
        );

        Transport.send(message);
    }
}