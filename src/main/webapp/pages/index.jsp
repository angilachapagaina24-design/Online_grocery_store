<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> - Home</title>
    <%-- Product.css le navbar ra footer ko exact same styling dinccha --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Product.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>

<!-- ======================= NAVBAR (exactly same as product.jsp) ======================= -->
<div class="navbar">

    <div class="Logo">
        <b>LOGO</b>
    </div>

    <div class="Nav-bar">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="#">Product</a>
        <a href="about.jsp">About Us</a>
        <a href="contact.jsp">Contact</a>
    </div>

    <div class="nav-right">
        <input type="text" placeholder="search" class="search-box">

        <a href="cart.jsp">
            <img src="${pageContext.request.contextPath}/Images/360_F_560176615_cUua21qgzxDiLiiyiVGYjUnLSGnVLIi6.jpg" width="30" alt="Cart">
        </a>

        <div class="Login"></div>

        <%-- Show name + logout if logged in, Sign in if not --%>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <span style="color:white; font-weight:600;">Hi, ${sessionScope.user.fullName}</span>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="login.jsp">Sign in</a>
            </c:otherwise>
        </c:choose>
    </div>

</div>
<!-- ======================= END NAVBAR ======================= -->


<!-- ======================= HERO SECTION ======================= -->
<header class="hero">
    <div class="hero-content">
        <h1>Fresh Fruits &amp; Vegetables</h1>
        <p>Quality organic products delivered to your doorstep in Pokhara.</p>
        <a href="${pageContext.request.contextPath}/home" class="btn-hero">Shop Now</a>
    </div>
</header>
<!-- ======================= END HERO ======================= -->


<!-- ======================= CATEGORY SECTION (same style as product.jsp) ======================= -->
<div class="section">
    <h2>Category</h2>
    <div class="category-container">

        <c:forEach var="cat" items="${categoryList}">
            <div class="cat-item">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/${cat.imageUrl}"
                         alt="${cat.categoryName}" width="90">
                </div>
                <p>${cat.categoryName}</p>
            </div>
        </c:forEach>

        <c:if test="${empty categoryList}">
            <p style="text-align:center; color:#888;">No categories found.</p>
        </c:if>

    </div>
</div>
<!-- ======================= END CATEGORY ======================= -->


<!-- ======================= PRODUCTS SECTION (same style as product.jsp) ======================= -->
<div class="section box">
    <div class="tabs">
        <h3>Best Selling</h3>
        <h3>Latest</h3>
    </div>

    <div class="product-list">

        <c:forEach var="product" items="${productList}">
            <div class="product-item">

                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/${product.imageUrl}"
                         alt="${product.name}" width="140">
                </div>

                <p>${product.name}</p>
                <span>Rs. ${product.price}</span>

                <%-- Add to Cart --%>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <input type="hidden" name="action" value="add">
                    <button type="submit" class="btn-sm">Add to Cart</button>
                </form>

            </div>
        </c:forEach>

        <c:if test="${empty productList}">
            <p style="text-align:center; color:#888; width:100%;">No products available.</p>
        </c:if>

    </div>
</div>
<!-- ======================= END PRODUCTS ======================= -->


<!-- ======================= FOOTER (exactly same as product.jsp) ======================= -->
<footer class="footer">
    <div class="footer-content">

        <div class="footer-col">
            <h4>Useful Links</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="#">product</a></li>
                <li><a href="#">blog</a></li>
                <li><a href="#">research</a></li>
                <li><a href="about.jsp">about us</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h4>Get Latest Updates</h4>
            <p>Subscribe to our newsletter</p>
            <button class="subscribe-btn">Subscribe Now</button>
        </div>

        <div class="footer-col">
            <h4>Connect With Us</h4>
            <p>ABCDEF</p>
            <p>Online Business</p>
            <p>Pokhara, Nepal</p>
        </div>

    </div>
</footer>
<!-- ======================= END FOOTER ======================= -->

</body>
</html>
