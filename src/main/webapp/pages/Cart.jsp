<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, grocery_model.CartItem"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart - FreshMart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Cart.css">
</head>

<body>

<div class="container">

    <h2>Your Cart</h2>

    <% 
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        double total = 0; 
    %>

    <% if (cart != null && !cart.isEmpty()) { %>

        <% for (CartItem item : cart) { 
            total += item.getPrice() * item.getQuantity(); %>

        <div class="cart-row">

            <%-- Image --%>
            <div class="img-box">
                <img src="${pageContext.request.contextPath}/Images/<%= item.getImage() %>"
                     alt="<%= item.getName() %>"
                     onerror="this.src='${pageContext.request.contextPath}/Images/placeholder.jpg'">
            </div>

            <%-- Name + Price --%>
            <div class="details">
                <p class="name"><%= item.getName() %></p>
                <p class="item-price">Rs. <%= item.getPrice() %></p>
            </div>

            <%-- Qty Update Form --%>
            <form action="${pageContext.request.contextPath}/cart" method="post" class="qty-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <input type="number" name="qty" value="<%= item.getQuantity() %>" min="1">
                <button type="submit" class="update-btn">Update</button>
            </form>

            <%-- Remove Form --%>
            <form action="${pageContext.request.contextPath}/cart" method="post">
                <input type="hidden" name="action" value="remove">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <button type="submit" class="remove-btn">Remove</button>
            </form>

        </div><%-- cart-row end --%>

        <% } %>

        <div class="total">Total: Rs <%= String.format("%.2f", total) %></div>

    <% } else { %>
        <p class="empty">Your cart is empty</p>
    <% } %>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/home" class="btn view">Continue Shopping</a>
       <a href="<%= request.getContextPath() %>/checkout" class="btn checkout">Checkout</a>
    </div>

</div><%-- container end --%>

</body>
</html>