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
        <a href="${pageContext.request.contextPath}/product" class="btn">Shop Now</a>
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
      <form action="${pageContext.request.contextPath}/cart" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="id"    value="1">
        <input type="hidden" name="name"  value="Fresh Apple">
        <input type="hidden" name="price" value="120">
        <button type="submit">Add to Cart</button>
      </form>
    </div>
    
    
    
       <div class="product-card">
      <img src="Images/banana.jpg" alt="Banana">
      <h4>Banana</h4>
      <p class="price">Rs. 60</p>
      <form action="${pageContext.request.contextPath}/cart" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="id"    value="2">
        <input type="hidden" name="name"  value="Banana">
        <input type="hidden" name="price" value="60">
        <button type="submit">Add to Cart</button>
      </form>
    </div>
    
    
    	<div class="product-card">
      <img src="Images/tomato.jpg" alt="Tomato">
      <h4>Tomato</h4>
      <p class="price">Rs. 80</p>
      <form action="${pageContext.request.contextPath}/cart" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="id"    value="3">
        <input type="hidden" name="name"  value="Tomato">
        <input type="hidden" name="price" value="80">
        <button type="submit">Add to Cart</button>
      </form>
    </div>
    
    	<div class="product-card">
      <img src="Images/carrot.jpg" alt="Carrot">
      <h4>Carrot</h4>
      <p class="price">Rs. 80</p>
      <form action="${pageContext.request.contextPath}/cart" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="id"    value="4">
        <input type="hidden" name="name"  value="Carrot">
        <input type="hidden" name="price" value="50">
        <button type="submit">Add to Cart</button>
      </form>
    </div>
    
    
    	 <div class="product-card">
      <img src="Images/milk.jpg" alt="Milk">
      <h4>Milk</h4>
      <p class="price">Rs. 80</p>
      <form action="${pageContext.request.contextPath}/cart" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="id"    value="3">
        <input type="hidden" name="name"  value="Milk">
        <input type="hidden" name="price" value="100">
        <button type="submit">Add to Cart</button>
      </form>
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