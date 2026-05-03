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
 
/**
 * AddProductServlet
 * URL: /admin/addProduct
 * GET  → loads category list and shows addProduct.jsp form
 * POST → saves new product to DB, then redirects to inventory
 */
@WebServlet("/addProduct")
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
        request.setAttribute("categoryList", categoryDAO.getAllCategories());
        request.getRequestDispatcher("/pages/addProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDAO categoryDAO = new CategoryDAO();
        
        // 1. Get form values
        String name          = request.getParameter("name");
        String brand         = request.getParameter("brand");
        String description   = request.getParameter("description");
        String priceStr      = request.getParameter("price");
        String stockStr      = request.getParameter("stockQuantity");
        String unit          = request.getParameter("unit");
        String categoryIdStr = request.getParameter("categoryId");
        String expiryDate    = request.getParameter("expiryDate");

        // 2. Simple Validation
        if (name == null || name.isBlank() || priceStr == null || stockStr == null) {
            request.setAttribute("errorMsg", "Required fields are missing.");
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/pages/addProduct.jsp").forward(request, response);
            return;
        }

        // 3. Parse and Image Upload
        String imageUrl = "Images/placeholder.png";
        try {
            double price = Double.parseDouble(priceStr);
            int stockQuantity = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                // Ensure Images folder exists in webapp
                String uploadPath = getServletContext().getRealPath("") + File.separator + "Images";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                filePart.write(uploadPath + File.separator + fileName);
                imageUrl = "Images/" + fileName;
            }

            // 4. Create and Save Product
            Product product = new Product();
            product.setName(name);
            product.setBrand(brand);
            product.setDescription(description);
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setUnit(unit);
            product.setCategoryId(categoryId);
            product.setExpiryDate(expiryDate);
            product.setImageUrl(imageUrl);
            product.setStatus("available");

            ProductDAO productDAO = new ProductDAO();
            if (productDAO.addProduct(product)) {
                // REDIRECT TO CORRECT SERVLET PATH
                response.sendRedirect(request.getContextPath() + "/inventory?successMsg=Product+Added!");
            } else {
                throw new Exception("Database insert failed");
            }

        } catch (Exception e) {
            request.setAttribute("errorMsg", "Error: " + e.getMessage());
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/pages/addProduct.jsp").forward(request, response);
        }
    }
}