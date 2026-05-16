<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="navbar">

    <!-- Logo -->
    <div class="Logo">
        <a href="${pageContext.request.contextPath}/home" style="text-decoration:none; color:inherit;">
            <img src="${pageContext.request.contextPath}/Images/Logo1.png"
                 alt="FreshMart"
                 style="height:52px; width:auto; object-fit:contain; display:block;">
        </a>
    </div>

    <!-- Navigation -->
    <div class="Nav-bar">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/product">Products</a>
        <a href="${pageContext.request.contextPath}/about">About Us</a>
        <a href="${pageContext.request.contextPath}/contact">Contact</a>
    </div>

    <!-- Right side -->
    <div class="nav-right">

        <!-- Search -->
        <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">
            <input type="text" name="q" placeholder="Search products..."
                   class="search-box" value="${param.q}">
            <button type="submit" class="search-btn"></button>
        </form>

        <!-- Cart with badge -->
        <a href="${pageContext.request.contextPath}/cart" class="cart-link">
            <div style="position: relative; display: inline-block;">
                <img src="${pageContext.request.contextPath}/Images/shopping-cart.png" width="30" alt="Cart">

                <c:set var="cartSize" value="0"/>
                <c:if test="${not empty sessionScope.cart}">
                    <c:set var="cartSize" value="${fn:length(sessionScope.cart)}"/>
                </c:if>
                <c:if test="${cartSize > 0}">
                    <span style="position:absolute; top:-8px; right:-10px; background:red;
                                 color:white; border-radius:50%; padding:3px 7px; font-size:12px;
                                 font-weight:700; line-height:1;">
                        ${cartSize}
                    </span>
                </c:if>
            </div>
        </a>

        <!-- Login / My Orders + Profile -->
       
<c:choose>
    <%-- pahila --%>
    <c:when test="${not empty sessionScope.adminUser}">
        <a href="${pageContext.request.contextPath}/adminDashboard"
           style="color:white; text-decoration:none; font-size:14px; font-weight:600;">
            🛡️ Admin Dashboard
        </a>
    </c:when>

    <%-- Normal user --%>
    <c:when test="${not empty sessionScope.user}">
        <a href="${pageContext.request.contextPath}/profile" style="
            display: inline-flex; align-items: center; gap: 6px;
            text-decoration: none; color: white;">
            <span style="width:36px; height:36px; border-radius:50%; background:#1b5e20;
                         border:2px solid white; display:inline-flex; align-items:center;
                         justify-content:center; font-weight:700; font-size:15px; color:white;">
                ${fn:substring(sessionScope.user.fullName, 0, 1)}
            </span>
        </a>
        <a href="${pageContext.request.contextPath}/myOrders"
           style="color:white; text-decoration:none; margin-left:8px; font-size:14px;">
            My Orders
        </a>
    </c:when>

    <%-- Not logged in --%>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/login"
           style="color:white; text-decoration:none; font-size:14px;">
            Sign in
        </a>
    </c:otherwise>
</c:choose>

    </div>
</div>
