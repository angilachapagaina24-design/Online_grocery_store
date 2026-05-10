<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- ================= HEADER ================= -->
<div class="navbar">

    <!-- Logo -->
    <div class="Logo">
        <b>LOGO</b>
    </div>

    <!-- Navigation -->
    <div class="Nav-bar">
        <a href="${pageContext.request.contextPath}/home">Home</a>
		<a href="${pageContext.request.contextPath}/product">Product</a>
        <a href="${pageContext.request.contextPath}/about">About Us</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
    </div>

    <!-- Right side -->
    <div class="nav-right">

        <!-- ===== SEARCH FORM — यो मात्र नयाँ ===== -->
        <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">
            <input type="text" name="q" placeholder="Search products..."
                   class="search-box" value="${param.q}">
            <button type="submit" class="search-btn"></button>
        </form>

        <!-- Cart -->
        <a href="${pageContext.request.contextPath}/cart" class="cart-link">
   		 <div style="position: relative; display: inline-block;">
        <img src="${pageContext.request.contextPath}/Images/shopping-cart.png" width="30" alt="Cart">
        
        <!-- CART COUNT -->
        <c:set var="cartSize" value="0" />
        
        <c:if test="${not empty sessionScope.cart}">
            <c:set var="cartSize" value="${fn:length(sessionScope.cart)}" />
        </c:if>

        <c:if test="${cartSize > 0}">
            <span style="
                position:absolute;
                top:-8px;
                right:-10px;
                background:red;
                color:white;
                border-radius:50%;
                padding:3px 7px;
                font-size:12px;">
                ${cartSize}
            </span>
        </c:if>

    </div>

</a>

        <!-- Login -->
        <c:choose>
    <c:when test="${not empty sessionScope.user}">

        <!-- Profile Avatar Circle + Name — click garda profile jaos -->
        <a href="${pageContext.request.contextPath}/profile" style="
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: white;">

 
            <span style="
                width: 36px;
                height: 36px;
                border-radius: 50%;
                background: #1b5e20;
                border: 2px solid white;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 15px;
                color: white;
                flex-shrink: 0;">
                ${fn:substring(sessionScope.user.fullName, 0, 1)}
            </span>

           
            
        </a>

        <!-- Logout -->
        <a href="${pageContext.request.contextPath}/logout"
           style="color:white; text-decoration:none; margin-left:8px;">
            Logout
        </a>

    </c:when>

    <c:otherwise>
        <a href="${pageContext.request.contextPath}/login"
           style="color:white; text-decoration:none;">
            Sign in
        </a>
    </c:otherwise>
</c:choose>

    </div>

</div>