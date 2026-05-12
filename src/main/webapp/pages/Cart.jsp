<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, grocery_model.CartItem"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
    <style>
        body { padding-top: 70px; }
        .item-price { color: #2e7d32; font-weight: 600; }
        .qty-form input[type="number"] { border: 1px solid #ddd; border-radius: 6px; text-align: center; }
        .update-btn { background: #2e7d32; color: white; border: none; padding: 6px 14px;
            border-radius: 6px; cursor: pointer; margin-left: 8px; }
        .update-btn:hover { background: #1b5e20; }
        .subtotal { text-align: right; font-size: 14px; color: #777; margin-top: 4px; }
        .cart-header { display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 24px; border-bottom: 2px solid #f0f0f0; padding-bottom: 12px; }
        .item-count { font-size: 14px; color: #888; }
    </style>
</head>

<body>
<jsp:include page="header.jsp"/>

<div class="container">

    <%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    double total = 0;
    int itemCount = (cart != null) ? cart.size() : 0;
    %>

    <div class="cart-header">
        <h2>Your Cart</h2>
        <span class="item-count"><%= itemCount %> item<%= itemCount != 1 ? "s" : "" %></span>
    </div>

    <% if (cart != null && !cart.isEmpty()) { %>

        <% for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity(); %>

        <div class="cart-row">

            <!-- Image -->
            <div class="img-box">
                <img src="${pageContext.request.contextPath}/Images/<%= item.getImage() %>"
                     alt="<%= item.getName() %>"
                     onerror="this.src='${pageContext.request.contextPath}/Images/placeholder.png'">
            </div>

            <!-- Name + Price -->
            <div class="details">
                <p class="name"><%= item.getName() %></p>
                <p class="item-price">Rs. <%= String.format("%.0f", item.getPrice()) %> each</p>
                <p class="subtotal">Subtotal: Rs. <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></p>
            </div>

            <!-- Qty Update -->
            <form action="${pageContext.request.contextPath}/cart" method="post" class="qty-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <input type="number" name="qty" value="<%= item.getQuantity() %>" min="1" max="99">
                <button type="submit" class="update-btn">Update</button>
            </form>

            <!-- Remove -->
            <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="action" value="remove">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <button type="submit" class="remove-btn">✕ Remove</button>
            </form>

        </div>
        <% } %>

        <div class="total">Total: Rs <%= String.format("%.2f", total) %></div>

    <% } else { %>
        <div style="text-align:center; padding: 60px 0;">
            <p style="font-size:48px;">🛒</p>
            <p class="empty" style="font-size:18px;">Your cart is empty</p>
            <a href="${pageContext.request.contextPath}/product"
               style="display:inline-block; margin-top:16px; background:#2e7d32; color:white;
                      padding:12px 28px; border-radius:8px; text-decoration:none; font-weight:600;">
                Start Shopping
            </a>
        </div>
    <% } %>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/product" class="btn view">← Continue Shopping</a>
        <% if (cart != null && !cart.isEmpty()) { %>
            <a href="${pageContext.request.contextPath}/checkout" class="btn checkout">Proceed to Checkout →</a>
        <% } %>
    </div>

</div>

<jsp:include page="Footer.jsp"/>
</body>
</html>
