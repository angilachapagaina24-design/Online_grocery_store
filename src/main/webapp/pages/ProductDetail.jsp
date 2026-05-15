<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="grocery_model.Product" %>
<%@ page import="grocery_model.User" %>

<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/product");
        return;
    }

    // Login check for cart button
    User loggedInUser = null;
    jakarta.servlet.http.HttpSession sess = request.getSession(false);
    if (sess != null) {
        loggedInUser = (User) sess.getAttribute("user");
    }

    boolean inStock = product.getStockQuantity() > 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getName() %> - FreshMart</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Footer.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/productDetail.css">
</head>
<body>

<%@ include file="header.jsp" %>

<div class="pd-page">

    <!-- Breadcrumb -->
    <div class="pd-breadcrumb">
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <span>›</span>
        <a href="<%= request.getContextPath() %>/product">Products</a>
        <span>›</span>
        <span><%= product.getName() %></span>
    </div>

    <div class="pd-container">

        <!-- LEFT: Product Image -->
        <div class="pd-image-col">
            <div class="pd-image-wrap">
                <img
                    src="<%= request.getContextPath() %>/<%= product.getImageUrl() != null ? product.getImageUrl() : "Images/placeholder.png" %>"
                    alt="<%= product.getName() %>"
                    class="pd-main-img"
                    onerror="this.src='<%= request.getContextPath() %>/Images/placeholder.png'"
                />
            </div>

            <!-- Stock badge on image -->
            <% if (!inStock) { %>
                <div class="pd-oos-banner">Out of Stock</div>
            <% } %>
        </div>

        <!-- RIGHT: Product Info -->
        <div class="pd-info-col">

            <!-- Brand -->
            <% if (product.getBrand() != null && !product.getBrand().isEmpty()) { %>
                <div class="pd-brand"><%= product.getBrand() %></div>
            <% } %>

            <!-- Name -->
            <h1 class="pd-name"><%= product.getName() %></h1>

            <!-- Price -->
            <div class="pd-price">
                Rs. <%= String.format("%.0f", product.getPrice()) %>
                <span class="pd-unit">/ <%= product.getUnit() != null ? product.getUnit() : "piece" %></span>
            </div>

            <!-- Stock status -->
            <div class="pd-stock-row">
                <% if (inStock) { %>
                    <span class="pd-badge pd-badge-green">&#10003; In Stock
                        (<%= product.getStockQuantity() %> available)
                    </span>
                <% } else { %>
                    <span class="pd-badge pd-badge-red">&#10007; Out of Stock</span>
                <% } %>
            </div>

            <!-- Description -->
            <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                <div class="pd-section">
                    <div class="pd-section-title">📋 Description</div>
                    <p class="pd-description"><%= product.getDescription() %></p>
                </div>
            <% } %>

            <!-- Product Details Table -->
            <div class="pd-section">
                <div class="pd-section-title">📦 Product Details</div>
                <table class="pd-details-table">
                    <% if (product.getBrand() != null && !product.getBrand().isEmpty()) { %>
                    <tr>
                        <td class="pd-detail-label">Brand</td>
                        <td><%= product.getBrand() %></td>
                    </tr>
                    <% } %>
                    <tr>
                        <td class="pd-detail-label">Unit</td>
                        <td><%= product.getUnit() != null ? product.getUnit() : "—" %></td>
                    </tr>
                    <% if (product.getExpiryDate() != null && !product.getExpiryDate().isEmpty()) { %>
                    <tr>
                        <td class="pd-detail-label">Expiry Date</td>
                        <td><%= product.getExpiryDate() %></td>
                    </tr>
                    <% } %>
                    <tr>
                        <td class="pd-detail-label">Availability</td>
                        <td><%= inStock ? "In Stock" : "Out of Stock" %></td>
                    </tr>
                </table>
            </div>

            <!-- Add to Cart Button -->
            <div class="pd-action-row">
                <% if (inStock) { %>
                    <% if (loggedInUser != null) { %>
                        <!-- Logged in: direct add to cart -->
                        <form action="<%= request.getContextPath() %>/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id"    value="<%= product.getProductId() %>">
                            <input type="hidden" name="name"  value="<%= product.getName() %>">
                            <input type="hidden" name="price" value="<%= product.getPrice() %>">
                            <input type="hidden" name="image" value="<%= product.getImageUrl() %>">
                            <button type="submit" class="pd-btn-cart">🛒 Add to Cart</button>
                        </form>
                    <% } else { %>
                        <!-- Not logged in: redirect to login -->
                        <button class="pd-btn-cart"
                            onclick="window.location.href='<%= request.getContextPath() %>/login'">
                            🛒 Add to Cart
                        </button>
                    <% } %>
                <% } else { %>
                    <button class="pd-btn-cart pd-btn-disabled" disabled>Out of Stock</button>
                <% } %>

                <a href="<%= request.getContextPath() %>/product" class="pd-btn-back">
                    ← Back to Products
                </a>
            </div>

        </div><!-- pd-info-col -->
    </div><!-- pd-container -->
</div><!-- pd-page -->

<%@ include file="Footer.jsp" %>

</body>
</html>
