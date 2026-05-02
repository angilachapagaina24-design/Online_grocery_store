<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Home.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">

</head>
<body>
<jsp:include page="header.jsp"/>
<div class="hero">
    <div class="hero-content">
        <h1>Fresh Fruits &amp; Vegetables</h1>
        <p>Healthy and organic groceries at your doorstep</p>
        <a href="#" class="btn">Shop Now</a>
    </div>
</div>
 
<!-- ===== CATEGORIES ===== -->
<div class="section">
    <h2>Featured Categories</h2>
    <div class="category-container">
        <div class="cat-item">
            <img src="Images/fruits.jpg" alt="Fruits">
            <p>Fruits</p>
        </div>
        <div class="cat-item">
            <img src="Images/vegetables.jpg" alt="Vegetables">
            <p>Vegetables</p>
        </div>
        <div class="cat-item">
            <img src="Images/dairy.jpg" alt="Dairy">
            <p>Dairy</p>
        </div>
        <div class="cat-item">
            <img src="Images/bakery.jpg" alt="Bakery">
            <p>Bakery</p>
        </div>
        <div class="cat-item">
            <img src="Images/beverages.jpg" alt="Beverages">
            <p>Beverages</p>
        </div>
    </div>
</div>
 
<!-- ===== PRODUCTS ===== -->
<div class="section" style="background: white;">
    <h2>Our Products</h2>
    <div class="product-container">
        <div class="product-card">
            <img src="Images/apple.jpg" alt="Apple">
            <h4>Fresh Apple</h4>
            <p class="price">Rs. 120</p>
            <button>Add to Cart</button>
        </div>
        <div class="product-card">
            <img src="Images/banana.jpg" alt="Banana">
            <h4>Banana</h4>
            <p class="price">Rs. 60</p>
            <button>Add to Cart</button>
        </div>
        <div class="product-card">
            <img src="Images/tomato.jpg" alt="Tomato">
            <h4>Tomato</h4>
            <p class="price">Rs. 80</p>
            <button>Add to Cart</button>
        </div>
        <div class="product-card">
            <img src="Images/carrot.jpg" alt="Carrot">
            <h4>Carrot</h4>
            <p class="price">Rs. 50</p>
            <button>Add to Cart</button>
        </div>
        <div class="product-card">
            <img src="Images/milk.jpg" alt="Milk">
            <h4>Fresh Milk</h4>
            <p class="price">Rs. 90</p>
            <button>Add to Cart</button>
        </div>
    </div>
</div>
 
<!-- ===== SERVICES ===== -->
<div class="section">
    <h2>Our Services</h2>
    <div class="service-section">
        <div class="service-box">
            <p>Explore</p>
            <img src="Images/explore.gif" width="90" height="90" alt="Explore">
        </div>
        <div class="service-box">
            <p>Cart</p>
            <img src="Images/cart.gif" width="90" height="90" alt="Cart">
        </div>
        <div class="service-box">
            <p>Payment</p>
            <img src="Images/payment.gif" width="90" height="90" alt="Payment">
        </div>
        <div class="service-box">
            <p>Delivery</p>
            <img src="Images/delivery.gif" width="90" height="90" alt="Delivery">
        </div>
    </div>
</div>
 
<jsp:include page="Footer.jsp" />
</body>
</html>