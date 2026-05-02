package grocery_controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/about") 
public class AboutusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public AboutusServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Match the path from image_c0a29e.png: Folder 'pages', File 'Aboutus.jsp'
        request.getRequestDispatcher("/pages/Aboutus.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}