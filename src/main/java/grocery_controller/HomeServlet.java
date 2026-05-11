package grocery_controller;
 
import java.io.IOException;
import java.util.List;
 
import grocery_dao.CategoryDAO;
import grocery_dao.ProductDAO;
import grocery_model.Category;
import grocery_model.Product;
 
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
 
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
 
    private static final long serialVersionUID = 1L;
 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO   = new ProductDAO();
 
        List<Category> categoryList    = categoryDAO.getAllCategories();
 
        // Best Selling: most ordered products (by order_items count)
        List<Product> bestSellingList  = productDAO.getBestSellingProducts();
 
        // Latest: newest products (by product_id DESC)
        List<Product> latestList       = productDAO.getLatestProducts();
 
        request.setAttribute("categoryList",    categoryList);
        request.setAttribute("bestSellingList", bestSellingList);
        request.setAttribute("latestList",      latestList);
 
        RequestDispatcher rd = request.getRequestDispatcher("/pages/Home.jsp");
        rd.forward(request, response);
    }
}