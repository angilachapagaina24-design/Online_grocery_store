<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="grocery_model.Product, grocery_model.Category, java.util.List" %>
<%
    Product p = (Product) request.getAttribute("product");
    if (p == null) {
        response.sendRedirect(request.getContextPath() + "/inventory");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product - FreshMart Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .form-card { background:#fff; border-radius:12px; padding:30px; box-shadow:0 2px 12px rgba(0,0,0,0.08); max-width:700px; }
        .form-group { margin-bottom:18px; }
        .form-group label { display:block; font-weight:600; margin-bottom:6px; color:#333; }
        .form-group input, .form-group select, .form-group textarea {
            width:100%; padding:10px 14px; border:1px solid #ddd; border-radius:8px;
            font-size:14px; box-sizing:border-box;
        }
        .form-row { display:grid; grid-template-columns:1fr 1fr; gap:16px; }
        .btn-primary { background:#2e7d32; color:#fff; border:none; padding:12px 28px;
            border-radius:8px; font-size:15px; cursor:pointer; font-weight:600; }
        .btn-primary:hover { background:#1b5e20; }
        .btn-cancel { background:#f5f5f5; color:#333; border:1px solid #ddd; padding:12px 24px;
            border-radius:8px; font-size:15px; cursor:pointer; text-decoration:none; margin-left:10px; }
        .current-img { width:80px; height:80px; object-fit:cover; border-radius:8px;
            border:1px solid #eee; margin-bottom:8px; }
        .alert { padding:12px 18px; border-radius:8px; margin-bottom:20px; font-weight:500; }
        .alert-error { background:#ffebee; color:#c62828; border-left:4px solid #c62828; }
        .alert-success { background:#e8f5e9; color:#2e7d32; border-left:4px solid #2e7d32; }
    </style>
</head>
<body>

<div class="admin-wrapper">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-logo"><span>🛒</span><p>FreshMart</p></div>
        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/adminDashboard" class="nav-item"><span class="nav-icon">🏠</span><span>Dashboard</span></a>
            <a href="${pageContext.request.contextPath}/inventory" class="nav-item active"><span class="nav-icon">📦</span><span>Inventory</span></a>
            <a href="${pageContext.request.contextPath}/addProduct" class="nav-item"><span class="nav-icon">➕</span><span>Add Product</span></a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-item logout"><span class="nav-icon">🚪</span><span>Logout</span></a>
        </nav>
    </div>

    <div class="main-content">
        <div class="topbar">
            <div class="topbar-left">
                <h2>Edit Product</h2>
                <p class="breadcrumb">Update product details below.</p>
            </div>
        </div>

        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error">⚠ ${errorMsg}</div>
        </c:if>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/editProduct" method="post" enctype="multipart/form-data">
                <input type="hidden" name="productId" value="<%= p.getProductId() %>">

                <!-- Current image preview -->
                <div class="form-group">
                    <label>Current Image</label>
                    <br>
                    <img src="${pageContext.request.contextPath}/Images/<%= p.getImageUrl() %>"
                         alt="Current" class="current-img"
                         onerror="this.src='${pageContext.request.contextPath}/Images/placeholder.png'">
                    <br>
                    <label>Upload New Image (optional)</label>
                    <input type="file" name="imageFile" accept="image/*">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Product Name *</label>
                        <input type="text" name="name" value="<%= p.getName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Brand</label>
                        <input type="text" name="brand" value="<%= p.getBrand() != null ? p.getBrand() : "" %>">
                    </div>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="3"><%= p.getDescription() != null ? p.getDescription() : "" %></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Category *</label>
                        <select name="categoryId" required>
                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.categoryId}"
                                    <%= p.getCategoryId() == Integer.parseInt("${cat.categoryId}") ? "selected" : "" %>>
                                    ${cat.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Unit</label>
                        <input type="text" name="unit" value="<%= p.getUnit() != null ? p.getUnit() : "" %>" placeholder="kg, litre, piece...">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Price (Rs.) *</label>
                        <input type="number" name="price" step="0.01" min="0" value="<%= p.getPrice() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Stock Quantity *</label>
                        <input type="number" name="stockQuantity" min="0" value="<%= p.getStockQuantity() %>" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Expiry Date</label>
                        <input type="date" name="expiryDate" value="<%= p.getExpiryDate() != null ? p.getExpiryDate() : "" %>">
                    </div>
                    <div class="form-group">
                        <label>Status</label>
                        <select name="status">
                            <option value="available" <%= "available".equals(p.getStatus()) ? "selected" : "" %>>Available</option>
                            <option value="unavailable" <%= "unavailable".equals(p.getStatus()) ? "selected" : "" %>>Unavailable</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn-primary">💾 Save Changes</button>
                <a href="${pageContext.request.contextPath}/inventory" class="btn-cancel">Cancel</a>
            </form>
        </div>
    </div>
</div>

</body>
</html>
