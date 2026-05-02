<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> - Home</title>
    <%-- Product.css le navbar ra footer ko exact same styling dinccha --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Product.css">
     
   
</head>
<body>


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
<!-- ================= HERO ================= -->
<div class="hero">
    <div class="hero-content">
    <img src="${pageContext.request.contextPath}/Images/main1.jpg" width="1400" height="500" alt="Home">
        <h1>Fresh Fruits & Vegetables</h1>
        
        <p>Healthy and organic groceries at your doorstep</p>
        <a href="#" class="btn">Shop Now</a>
    </div>
</div>

<!-- ================= CATEGORY ================= -->
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
                    <button>Add to Cart</button>
                </form>

            </div>
        </c:forEach>
    </div>
</div>

<!-- ================= SERVICES ================= -->
<div class="section">
    <h2>Our Services</h2>
    <div class="section service-section">

        <div class="service-box">
        <p>Explore</p>
            <img src="${pageContext.request.contextPath}/Images/explore.gif">
            
        </div>

        <div class="service-box">
        <p>Cart</p>
            <img src="${pageContext.request.contextPath}/Images/cart.gif">
            
        </div>

        <div class="service-box">
        <p>Payment</p>
            <img src="${pageContext.request.contextPath}/Images/payment.gif">
            
        </div>

        <div class="service-box">
        <p>Delivery</p>
            <img src="${pageContext.request.contextPath}/Images/delivery.gif">
            
        </div>

    </div>
</div>


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
