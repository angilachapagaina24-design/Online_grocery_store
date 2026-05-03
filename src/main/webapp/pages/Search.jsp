<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Product.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="section box" style="margin-top: 30px;">

    <h2>Search Results for: "<c:out value="${keyword}"/>"</h2>

    <c:choose>

        <c:when test="${empty keyword}">
            <p style="text-align:center; color:gray; padding:40px;">
                Please enter a search keyword.
            </p>
        </c:when>

        <c:when test="${empty results}">
            <p style="text-align:center; color:gray; padding:40px;">
                No products found for "<c:out value="${keyword}"/>"
            </p>
        </c:when>

        <c:otherwise>
            <p style="text-align:center; color:#555; margin-bottom:20px;">
                ${results.size()} product(s) found
            </p>

            <div class="product-list">
                <c:forEach var="p" items="${results}">
                    <div class="product-item">
                        <div class="img-placeholder">
                            <img src="${pageContext.request.contextPath}/Images/${p.imageUrl}"
                                 width="130" alt="${p.name}"
                                 onerror="this.src='${pageContext.request.contextPath}/Images/placeholder.jpg'">
                        </div>
                        <p><strong>${p.name}</strong></p>
                        <span>Rs. ${p.price} / ${p.unit}</span>

                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="id"    value="${p.productId}">
                            <input type="hidden" name="name"  value="${p.name}">
                            <input type="hidden" name="price" value="${p.price}">
                            <input type="hidden" name="image" value="${p.imageUrl}">
                            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>

    </c:choose>

</div>

<jsp:include page="Footer.jsp"/>
</body>
</html>