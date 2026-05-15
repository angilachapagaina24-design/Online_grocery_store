package grocery_controller;
 
import grocery_dao.ProductDAO;
import grocery_model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
 
import java.io.IOException;
 
@WebServlet("/productDetail")
public class ProductDetailServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String idStr = request.getParameter("id");
 
        // ID nabhae product page ma pathau
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }
 
        try {
            int productId = Integer.parseInt(idStr);
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById(productId);
 
            // Product nabhae product page ma pathau
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/product");
                return;
            }
 
            request.setAttribute("product", product);
            request.getRequestDispatcher("/pages/ProductDetail.jsp").forward(request, response);
 
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/product");
        }
    }
}