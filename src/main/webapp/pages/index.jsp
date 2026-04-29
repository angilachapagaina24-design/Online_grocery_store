<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<body>


<!-- HERO SECTION -->
<header class="hero">
    <div class="hero-content">
        <h1>Fresh Fruits & Vegetables</h1>
        <p>Quality organic products delivered to your doorstep in Pokhara.</p>
        <a href="111.jsp" class="btn">Shop Now</a>
    </div>
</header>

<!-- FEATURED CATEGORIES -->
<!-- 2. Category Section (Add your code here) -->
<div class="section">
    <h2 class="section-title">Shop by Category</h2>
    <div class="category-container">
        <c:forEach var="cat" items="${categoryList}">
            <div class="cat-item">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/${cat.imageUrl}" alt="${cat.categoryName}">
                </div>
                <p>${cat.categoryName}</p>
            </div>
        </c:forEach>
    </div>
</div>

<!-- OUR PRODUCTS -->
<!-- OUR PRODUCTS -->
<section class="section gray-bg">

    <h2 class="section-title">
        Our Products
    </h2>
    <div class="product-grid">
        <c:forEach var="product" items="${productList}">
            <div class="product-card">
                <!-- Product Image -->
                <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                     alt="${product.name}">
                <!-- Product Name -->
                <h3>
                    ${product.name}
                </h3>
                <!-- Brand (Optional but good UI) -->
                <p class="brand">
                    ${product.brand}
                </p>
                <!-- Price -->
                <p class="price">
                    Rs. ${product.price}
                    / ${product.unit}
                </p>

                <!-- Add to Cart Button -->
                <button class="btn-sm"> Add to Cart </button>
            </div>
        </c:forEach>
    </div>
</section>
<!-- FOOTER -->

<div class="footer">
    <p>© 2026 Online Grocery Store</p>
</div>

</body>
</html>