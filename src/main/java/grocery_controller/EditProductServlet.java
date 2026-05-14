package grocery_controller;

import grocery_dao.CategoryDAO;
import grocery_dao.ProductDAO;
import grocery_model.Product;
import grocery_model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/editProduct")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize       = 1024 * 1024 * 10,
    maxRequestSize    = 1024 * 1024 * 15
)
public class EditProductServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        String pidStr = request.getParameter("productId");
        if (pidStr == null) {
            response.sendRedirect(request.getContextPath() + "/inventory");
            return;
        }
 
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        Product product = productDAO.getProductById(Integer.parseInt(pidStr));
 
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/inventory?errorMsg=Product+not+found");
            return;
        }
 
        request.setAttribute("product", product);
        request.setAttribute("categoryList", categoryDAO.getAllCategories());
        request.getRequestDispatcher("/pages/editProduct.jsp").forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        CategoryDAO categoryDAO = new CategoryDAO();
 
        try {
            int productId     = Integer.parseInt(request.getParameter("productId"));
            int categoryId    = Integer.parseInt(request.getParameter("categoryId"));
            String name       = request.getParameter("name");
            String brand      = request.getParameter("brand");
            String desc       = request.getParameter("description");
            double price      = Double.parseDouble(request.getParameter("price"));
            int stock         = Integer.parseInt(request.getParameter("stockQuantity"));
            String unit       = request.getParameter("unit");
            String expiryDate = request.getParameter("expiryDate");
            String status     = request.getParameter("status");
 
            // Retain old image if no new one uploaded
            ProductDAO productDAO = new ProductDAO();
            Product existing = productDAO.getProductById(productId);
            String imageUrl = (existing != null) ? existing.getImageUrl() : "Images/placeholder.png";
 
            // Handle image upload
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "Images";
                new File(uploadPath).mkdirs();
                filePart.write(uploadPath + File.separator + fileName);
                imageUrl = "Images/" + fileName;
            }
 
            Product p = new Product();
            p.setProductId(productId);
            p.setCategoryId(categoryId);
            p.setName(name);
            p.setBrand(brand);
            p.setDescription(desc);
            p.setPrice(price);
            p.setStockQuantity(stock);
            p.setUnit(unit);
            p.setExpiryDate(expiryDate);
            p.setStatus(status != null ? status : "available");
            p.setImageUrl(imageUrl);
 
            boolean ok = productDAO.updateProduct(p);
            if (ok) {
                response.sendRedirect(request.getContextPath() + "/inventory?successMsg=Product+Updated!");
            } else {
                request.setAttribute("errorMsg", "Update failed. Please try again.");
                request.setAttribute("product", p);
                request.setAttribute("categoryList", categoryDAO.getAllCategories());
                request.getRequestDispatcher("/pages/editProduct.jsp").forward(request, response);
            }
 
        } catch (Exception e) {
            request.setAttribute("errorMsg", "Error: " + e.getMessage());
            request.setAttribute("categoryList", categoryDAO.getAllCategories());
            request.getRequestDispatcher("/pages/editProduct.jsp").forward(request, response);
        }
    }
}