<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, grocery_model.*, grocery_model.CartItem" %>
<%
    String successParam = request.getParameter("success");
    String orderIdParam = request.getParameter("orderId");
    String errorMsg     = (String) request.getAttribute("errorMsg");

    List<CartItem> cart = (List<CartItem>) request.getAttribute("cart");
    User user           = (User) request.getAttribute("user");
    Double total        = (Double) request.getAttribute("total");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - FreshMart</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/checkout.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar">
    <a href="<%= request.getContextPath() %>/cart">&#8592; Back to Cart</a>
    <h1>FreshMart</h1>
    <span></span>
</nav>

<div class="page-wrapper">

<!-- ══════════ SUCCESS SCREEN ══════════ -->
<% if ("true".equals(successParam)) { %>

    <div class="success-screen">
        <div class="success-icon">&#10003;</div>
        <h2 class="success-title">Order Placed!</h2>
        <p class="success-sub">Thank you for shopping with FreshMart.</p>
        <p class="success-sub">Your order has been received and is being processed.</p>
        <div class="order-id-badge">Order #<%= orderIdParam %></div>
        <br>
        <a href="<%= request.getContextPath() %>/home" class="btn-continue">
            Continue Shopping
        </a>
    </div>

<% } else { %>

<!-- ══════════ CHECKOUT FORM ══════════ -->
<h2 class="page-title">Checkout</h2>

<% if (errorMsg != null && !errorMsg.isEmpty()) { %>
    <div class="alert-error">&#10007; <%= errorMsg %></div>
<% } %>

<form action="<%= request.getContextPath() %>/checkout" method="post">
<div class="checkout-grid">

    <!-- ── LEFT: Shipping + Payment ── -->
    <div>

        <!-- Shipping Info -->
        <div class="card">
            <div class="card-title">&#128666; Shipping Information</div>

            <div class="form-row">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName"
                           value="<%= user != null && user.getFullName() != null ? user.getFullName() : "" %>"
                           placeholder="Your full name" required/>
                </div>
                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" name="phone"
                           value="<%= user != null && user.getPhone() != null ? user.getPhone() : "" %>"
                           placeholder="Your phone number" required/>
                </div>
            </div>

            <div class="form-group">
                <label>Delivery Address</label>
                <input type="text" name="address"
                       value="<%= user != null && user.getAddress() != null ? user.getAddress() : "" %>"
                       placeholder="Street address" required/>
            </div>

            <div class="form-group">
                <label>City</label>
                <input type="text" name="city"
                       placeholder="City" required/>
            </div>
        </div>

        <!-- Payment Method -->
        <div class="card">
            <div class="card-title">&#128179; Payment Method</div>

            <div class="payment-options">

                <label class="payment-option">
                    <input type="radio" name="paymentMethod"
                           value="Cash on Delivery" checked/>
                    <span class="pay-icon">&#128181;</span>
                    <span>Cash on Delivery</span>
                </label>

                <label class="payment-option">
                    <input type="radio" name="paymentMethod"
                           value="eSewa"/>
                    <span class="pay-icon">&#128242;</span>
                    <span>eSewa</span>
                </label>

                <label class="payment-option">
                    <input type="radio" name="paymentMethod"
                           value="Khalti"/>
                    <span class="pay-icon">&#128242;</span>
                    <span>Khalti</span>
                </label>

            </div>
        </div>

    </div>

    <!-- ── RIGHT: Order Summary ── -->
    <div>
        <div class="card">
            <div class="card-title">&#128722; Order Summary</div>

            <!-- Items -->
            <% if (cart != null) {
                for (CartItem item : cart) { %>
                <div class="summary-item">
                    <img src="<%= request.getContextPath() %>/Images/<%= item.getImage() %>"
                         alt="<%= item.getName() %>"
                         onerror="this.src='<%= request.getContextPath() %>/Images/placeholder.png'"/>
                    <div class="summary-item-info">
                        <div class="summary-item-name"><%= item.getName() %></div>
                        <div class="summary-item-qty">Qty: <%= item.getQuantity() %></div>
                    </div>
                    <div class="summary-item-price">
                        Rs. <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %>
                    </div>
                </div>
            <% } } %>

            <!-- Totals -->
            <div class="summary-totals">
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>Rs. <%= total != null ? String.format("%.2f", total) : "0.00" %></span>
                </div>
                <div class="summary-row">
                    <span>Delivery</span>
                    <span style="color:#2e7d32;">FREE</span>
                </div>
                <div class="summary-row total">
                    <span>Total</span>
                    <span>Rs. <%= total != null ? String.format("%.2f", total) : "0.00" %></span>
                </div>
            </div>

            <button type="submit" class="btn-place-order">
                Place Order &#8594;
            </button>

        </div>
    </div>

</div>
</form>

<% } %>
</div>

</body>
</html>