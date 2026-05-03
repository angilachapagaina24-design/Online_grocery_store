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
        <a href="contact.jsp">Contact</a>
    </div>

    <!-- Right side -->
    <div class="nav-right">

        <input type="text" placeholder="Search products..." class="search-box">

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
                <span style="color:white; font-weight:600;">
                    Hi, ${sessionScope.user.fullName}
                </span>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Sign in</a>
            </c:otherwise>
        </c:choose>

    </div>

</div>