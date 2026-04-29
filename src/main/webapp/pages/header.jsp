<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Online Grocery Store</title>

    <!-- Main CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/index.css">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<div class="navbar">
    <div class="logo">
        Grocery
    </div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">
            Home
        </a>
        <a href="${pageContext.request.contextPath}/products.jsp">
            Products
        </a>
        <a href="${pageContext.request.contextPath}/cart.jsp">
            Cart
        </a>
    </div>

    <!-- Login / User Section -->

    <div class="auth">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <span>
                    Hi, ${sessionScope.user.fullName}
                </span>
                <a href="${pageContext.request.contextPath}/logout">
                    Logout
                </a>

            </c:when>
            <c:otherwise>

                <a href="${pageContext.request.contextPath}/login.jsp">
                    Login
                </a>
                <a href="${pageContext.request.contextPath}/register.jsp">
                    Register
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</div>