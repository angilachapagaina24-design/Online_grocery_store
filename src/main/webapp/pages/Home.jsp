<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fresh Grocery</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Home.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
</head>
<body>
<jsp:include page="header.jsp"/>

<!-- ===== HERO ===== -->
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
            <img src="${pageContext.request.contextPath}/Images/fruits 1.png" alt="Fruits">
            <p>Fruits</p>
        </div>
        <div class="cat-item">
            <img src="${pageContext.request.contextPath}/Images/vegetables 1.png" alt="Vegetables">
            <p>Vegetables</p>
        </div>
        <div class="cat-item">
            <img src="${pageContext.request.contextPath}/Images/dairy 1.png" alt="Dairy">
            <p>Dairy</p>
        </div>
        <div class="cat-item">
            <img src="${pageContext.request.contextPath}/Images/bakery.png" alt="Bakery">
            <p>Bakery</p>
        </div>
        <div class="cat-item">
            <img src="${pageContext.request.contextPath}/Images/beverages.jpg" alt="Beverages">
            <p>Beverages</p>
        </div>
    </div>
</div>

<!-- ===== PRODUCT TABS ===== -->
<div class="product-tabs-wrapper">

    <!-- Tab Buttons -->
    <div class="tabs">
        <button class="tab-btn active" onclick="showTab('bestSelling', this)">Best Selling</button>
        <button class="tab-btn"        onclick="showTab('latest', this)">Latest</button>
    </div>

    <!-- BEST SELLING -->
    <div id="bestSelling" class="tab-content active">
        <div class="product-container">
            <c:forEach var="p" items="${bestSellingList}">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <img src="${pageContext.request.contextPath}/Images/${p.imageUrl}" alt="${p.name}">
                    </div>
                    <div class="product-info">
                        <h4>${p.name}</h4>
                        <p class="price">Rs. ${p.price}</p>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id"     value="${p.id}">
                            <input type="hidden" name="name"   value="${p.name}">
                            <input type="hidden" name="price"  value="${p.price}">
                            <input type="hidden" name="image"  value="${p.imageUrl}">
                            <button type="submit" class="add-btn">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty bestSellingList}">
                <p class="empty-msg">No products available.</p>
            </c:if>
        </div>
    </div>

    <!-- LATEST -->
    <div id="latest" class="tab-content">
        <div class="product-container">
            <c:forEach var="p" items="${latestList}">
                <div class="product-card">
                    <div class="product-img-wrap">
                        <img src="${pageContext.request.contextPath}/Images/${p.imageUrl}" alt="${p.name}">
                    </div>
                    <div class="product-info">
                        <h4>${p.name}</h4>
                        <p class="price">Rs. ${p.price}</p>
                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id"     value="${p.id}">
                            <input type="hidden" name="name"   value="${p.name}">
                            <input type="hidden" name="price"  value="${p.price}">
                            <input type="hidden" name="image"  value="${p.imageUrl}">
                            <button type="submit" class="add-btn">Add to Cart</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty latestList}">
                <p class="empty-msg">No products available.</p>
            </c:if>
        </div>
    </div>

</div>

<!-- ===== SERVICES ===== -->
<div class="section">
    <h2>Our Services</h2>
    <div class="service-section">
        <div class="service-box">
            <p>Explore</p>
            <img src="${pageContext.request.contextPath}/Images/explore.gif" width="90" height="90" alt="Explore">
        </div>
        <div class="service-box">
            <p>Cart</p>
            <img src="${pageContext.request.contextPath}/Images/cart.gif" width="90" height="90" alt="Cart">
        </div>
        <div class="service-box">
            <p>Payment</p>
            <img src="${pageContext.request.contextPath}/Images/payment.gif" width="90" height="90" alt="Payment">
        </div>
        <div class="service-box">
            <p>Delivery</p>
            <img src="${pageContext.request.contextPath}/Images/delivery.gif" width="90" height="90" alt="Delivery">
        </div>
    </div>
</div>

<script>
function showTab(tabId, btn) {
    document.querySelectorAll('.tab-content').forEach(function(tab) {
        tab.classList.remove('active');
    });
    document.querySelectorAll('.tab-btn').forEach(function(b) {
        b.classList.remove('active');
    });
    document.getElementById(tabId).classList.add('active');
    btn.classList.add('active');
}
</script>

<jsp:include page="Footer.jsp"/>
</body>
</html>
