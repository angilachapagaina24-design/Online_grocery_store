<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
    
</head>

<body>

<jsp:include page="header.jsp"/>
	
<!-- ================= HERO ================= -->
<div class="hero">
    <div class="hero-content">
        <h1>Fresh Fruits & Vegetables</h1>
        <p>Healthy and organic groceries at your doorstep</p>
        <a href="#" class="btn">Shop Now</a>
    </div>
</div>

<!-- ================= CATEGORIES ================= -->
<div class="section">
    <h2>Featured Categories</h2>

    <div class="category-container">
        <c:forEach var="cat" items="${categoryList}">
            <div class="cat-item">
                <img src="${pageContext.request.contextPath}/Images/${cat.imageUrl}">
                <p>${cat.categoryName}</p>
            </div>
        </c:forEach>
    </div>
</div>

<!-- ================= PRODUCTS ================= -->
<div class="section">
    <h2>Our Products</h2>

    <div class="product-container">
        <c:forEach var="product" items="${productList}">
            <div class="product-card">

                <img src="${pageContext.request.contextPath}/Images/${product.imageUrl}">

                <h4>${product.name}</h4>
                <p>Rs. ${product.price}</p>

                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <button type="submit">Add to Cart</button>
                </form>

            </div>
        </c:forEach>
    </div>
</div>

<!-- ================= SERVICES ================= -->
<div class="section">
    <h2>Our Services</h2>

    <div class="service-section">

        <div class="service-box">
            <p>Explore</p>
            <img src="${pageContext.request.contextPath}/Images/explore.gif" width = "90" height ="90">
        </div>

        <div class="service-box">
            <p>Cart</p>
            <img src="${pageContext.request.contextPath}/Images/cart.gif" width = "90" height ="90">
        </div>

        <div class="service-box">
            <p>Payment</p>
            <img src="${pageContext.request.contextPath}/Images/payment.gif" width = "90" height ="90">
        </div>

        <div class="service-box">
            <p>Delivery</p>
            <img src="${pageContext.request.contextPath}/Images/delivery.gif" width = "90" height ="90">
        </div>

    </div>
</div>

<!-- ================= FOOTER ================= -->
<jsp:include page="Footer.jsp" />

</body>
</html>