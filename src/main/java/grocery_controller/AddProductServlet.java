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
        List<Category> categoryList = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", categoryList);

        // ✅ FIXED PATH
        request.getRequestDispatcher("/pages/addProduct.jsp")
               .forward(request, response);
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


        // 2. Validation
    
        if (name == null || name.isBlank() ||
            priceStr == null || priceStr.isBlank() ||
            stockStr == null || stockStr.isBlank() ||
            categoryIdStr == null || categoryIdStr.isBlank()) {

            request.setAttribute("errorMsg", "Please fill in all required fields.");
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/pages/addProduct.jsp").forward(request, response);
            return;
        }

   
        // 3. Parse values
  
        double price;
        int stockQuantity;
        int categoryId;

        try {
            price = Double.parseDouble(priceStr);
            stockQuantity = Integer.parseInt(stockStr);
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "Invalid numeric values.");
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/pages/addProduct.jsp").forward(request, response);
            return;
        }

      
        // 4. Image upload
       
        String imageUrl = "Images/placeholder.png";

        Part filePart = request.getPart("imageFile");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("") + File.separator + "Images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(uploadPath + File.separator + fileName);
            imageUrl = "Images/" + fileName;
        }

      
        // 5. Create Product object
       
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

    
        // 6. Save to DB
      
        ProductDAO productDAO = new ProductDAO();
        boolean saved = productDAO.addProduct(product);

        
        // 7. RESULT HANDLING
    
        if (saved) {
            response.sendRedirect(request.getContextPath()
                    + "/admin/inventory?successMsg=Product+added+successfully!");
        } else {
            request.setAttribute("errorMsg", "Failed to add product.");
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/pages/addProduct.jsp").forward(request, response);
        }
    }
    
}