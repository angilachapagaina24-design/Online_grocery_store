package grocery_controller;
 
import grocery_dao.CategoryDAO;
import grocery_dao.ProductDAO;
import grocery_model.Product;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
 
import java.io.File;
import java.io.IOException;
import java.util.List;
import grocery_model.Category;
 
/**
 * AddProductServlet
 * URL: /admin/addProduct
 * GET  → loads category list and shows addProduct.jsp form
 * POST → saves new product to DB, then redirects to inventory
 */
@WebServlet("/admin/addProduct") // ✅ FIXED (lowercase)
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 10,
    maxRequestSize    = 1024 * 1024 * 15
)
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);

        // ✅ FIXED PATH
        request.getRequestDispatcher("/pages/addProduct.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // (NO CHANGE in your logic)

        // SUCCESS REDIRECT (already correct)
        response.sendRedirect(request.getContextPath()
                + "/admin/inventory?successMsg=Product+added+successfully!");
    
 
        // =========================
        // 1. Get form values
        // =========================
        String name          = request.getParameter("name");
        String brand         = request.getParameter("brand");
        String description   = request.getParameter("description");
        String priceStr      = request.getParameter("price");
        String stockStr      = request.getParameter("stockQuantity");
        String unit          = request.getParameter("unit");
        String categoryIdStr = request.getParameter("categoryId");
        String expiryDate    = request.getParameter("expiryDate");
 
        // =========================
        // 2. Basic validation
        // =========================
        if (name == null || name.isBlank() ||
            priceStr == null || priceStr.isBlank() ||
            stockStr == null || stockStr.isBlank() ||
            categoryIdStr == null || categoryIdStr.isBlank()) {
 
            request.setAttribute("errorMsg", "Please fill in all required fields.");
 
            // Reload category list for the form
            CategoryDAO categoryDAO = new CategoryDAO();
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/admin/addProduct.jsp").forward(request, response);
            return;
        }
 
        // =========================
        // 3. Parse numbers
        // =========================
        double price;
        int stockQuantity;
        int categoryId;
 
        try {
            price         = Double.parseDouble(priceStr);
            stockQuantity = Integer.parseInt(stockStr);
            categoryId    = Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "Invalid price, stock, or category value.");
            CategoryDAO categoryDAO = new CategoryDAO();
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/admin/addProduct.jsp").forward(request, response);
            return;
        }
 
        // =========================
        // 4. Handle image file upload
        // =========================
        String imageUrl = "Images/placeholder.png"; // default image
 
        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
 
            // Get original filename
            String fileName = filePart.getSubmittedFileName();
 
            // Save to WebContent/Images/ folder on server
            String uploadPath = getServletContext().getRealPath("") + File.separator + "Images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
 
            filePart.write(uploadPath + File.separator + fileName);
            imageUrl = "Images/" + fileName;
        }
 
        // =========================
        // 5. Build Product object
        // =========================
        Product product = new Product();
        product.setName(name);
        product.setBrand(brand);
        product.setDescription(description);
        product.setPrice(price);
        product.setStockQuantity(stockQuantity);
        product.setUnit(unit);
        product.setCategoryId(categoryId);
        product.setExpiryDate((expiryDate != null && !expiryDate.isBlank()) ? expiryDate : null);
        product.setImageUrl(imageUrl);
        product.setStatus("available");
 
        // =========================
        // 6. Save to DB
        // =========================
        ProductDAO productDAO = new ProductDAO();
        boolean saved = productDAO.addProduct(product);
 
        // =========================
        // 7. Redirect based on result
        // =========================
        if (saved) {
            // Success → go to inventory with success message
            response.sendRedirect(request.getContextPath()
                    + "/admin/inventory?successMsg=Product+added+successfully!");
        } else {
            request.setAttribute("errorMsg", "Failed to add product. Please try again.");
            CategoryDAO categoryDAO = new CategoryDAO();
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/admin/addProduct.jsp").forward(request, response);
        }
    }
}