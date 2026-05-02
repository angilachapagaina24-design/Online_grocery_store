<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        <a href="cart.jsp">
            <img src="${pageContext.request.contextPath}/Images/360_F_560176615_cUua21qgzxDiLiiyiVGYjUnLSGnVLIi6.jpg" width="30" alt="Cart">
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
                <a href="login.jsp">Sign in</a>
            </c:otherwise>
        </c:choose>

    </div>

</div>