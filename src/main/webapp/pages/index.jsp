<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Online Grocery Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">Grocery</div>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Products</a>
        <a href="cart.jsp">Cart</a>
    </div>

    <div class="auth">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <span>Hi, ${sessionScope.user.fullName}</span>
                <a href="logout">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- HERO SECTION -->
<div class="hero">
    <div class="hero-text">
        <h1>Green Basket</h1>
        <p>Fresh fruits & vegetables delivered to your door</p>
        <a href="products.jsp" class="btn">Shop Now</a>
           </div>

    <div class="hero-img">
        <img src="${pageContext.request.contextPath}/Images/111.jpg" alt="Cupcake">
    </div>
</div>

<!-- CATEGORIES -->
<div class="categories">
    <h2>Categories</h2>

    <div class="category-container">
        <div class="category">Fruits</div>
        <div class="category">Vegetables</div>
        <div class="category">Dairy</div>
        <div class="category">Bakery</div>
    </div>
</div>

<!-- FEATURED PRODUCTS -->
<div class="products">
    <h2>Featured Products</h2>

    <div class="product-container">

        <%-- Add this inside the .product-container div --%>
<div class="product-container">
    <c:forEach var="product" items="${productList}">
        <div class="card">
            <%-- Use a default image if image_url is empty --%>
            <img src="${not empty product.imageUrl ? product.imageUrl : 'images/default-product.png'}" alt="${product.name}">
            <h3>${product.name}</h3>
            <p>Rs. ${product.price} / ${product.unit}</p>
            <p class="brand">${product.brand}</p>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <form action="AddToCartServlet" method="POST">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <button type="submit" class="btn">Add to Cart</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <a href="login.jsp" class="btn">Login to Buy</a>
                </c:otherwise>
            </c:choose>
        </div>
    </c:forEach>
</div>

    </div>
</div>

<!-- FOOTER -->
<div class="footer">
    <p>© 2026 Online Grocery Store</p>
</div>

</body>
</html>