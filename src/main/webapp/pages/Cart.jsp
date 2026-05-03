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
            total += item.getPrice() * item.getQuantity();
        %>

        <div class="cart-row">

            <div class="img-box"></div>

            <div class="details">
                <p class="name"><%= item.getName() %></p>

                <form action="cart" method="post" class="qty-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= item.getId() %>">

                    Qty:
                    <input type="number" name="qty" value="<%= item.getQuantity() %>" min="1">
                    <button class="update-btn">Update</button>
                </form>
            </div>

            <form action="cart" method="post">
                <input type="hidden" name="action" value="remove">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <button class="remove-btn">Remove</button>
            </form>

        </div>

        <% } %>

        <div class="total">
            Total: Rs <%= total %>
        </div>

    <% } else { %>

        <p class="empty">Your cart is empty</p>

    <% } %>

    <div class="actions">
        <a href="home.jsp" class="btn view">View Cart</a>
        <a href="#" class="btn checkout">Checkout</a>
    </div>

</div>

</body>
</html>