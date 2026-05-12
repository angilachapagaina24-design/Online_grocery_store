<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Product.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">

<style>
    .product-list {
        display: flex;
        flex-wrap: wrap;
        justify-content: flex-start;
        gap: 10px !important;
        margin-top: 25px;
    }
    .product-item {
        width: calc(25% - 8px) !important;
        min-width: 200px;
        padding: 20px;
        border: 1px solid #f0f0f0;
        background: #fff;
        text-align: center;
        border-radius: 12px;
        transition: 0.3s;
        box-sizing: border-box;
        overflow: hidden;
        position: relative;
    }

    /* ── REMOVE the square card from every cat-item ── */
    .cat-item {
        border: none !important;
        background: transparent !important;
        box-shadow: none !important;
        border-radius: 0 !important;
        padding: 10px !important;
    }
    .cat-item.active-cat {
        border: none !important;
        background: transparent !important;
        box-shadow: none !important;
    }

    /* ── Circle image styling ── */
    .circle-box {
        border: 2px solid #f0f0f0;
        border-radius: 50%;
        transition: 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        height: 90px;
        width: 90px;
        overflow: hidden;
        background: #fff;
    }
    .cat-item:hover .circle-box {
        border: 2px solid #2ecc71;
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        transform: scale(1.08);
    }
    .cat-item.active-cat .circle-box {
        border: 2px solid #27ae60 !important;
        box-shadow: 0 4px 16px rgba(39,174,96,0.25) !important;
    }
    
    .out-of-stock-btn {
    background-color: #ccc !important;
    color: #666 !important;
    cursor: not-allowed !important;
    border: none;
}

/* Optional: red "Out of Stock" badge on the card */
.product-item .oos-badge {
    position: absolute;
    top: 10px;
    right: 10px;
    background: #e74c3c;
    color: #fff;
    font-size: 11px;
    font-weight: bold;
    padding: 3px 8px;
    border-radius: 20px;
    z-index: 1;
}


.product-item.oos .img-placeholder img {
    opacity: 0.45;
    filter: grayscale(60%);
}
</style>
</head>

<body>

<jsp:include page="header.jsp"/>

<!-- ================= CATEGORY SECTION ================= -->
<div class="section">
    <h2>Category</h2>

    <div class="category-container">

        <!-- All Products -->
        <div class="cat-item ${empty param.category ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/all.png" width="80"
                         onerror="this.style.fontSize='30px';this.alt='🛒';this.style.lineHeight='90px';">
                </div>
            </a>
            <p>All</p>
        </div>

        <!-- Fruits -->
        <div class="cat-item ${param.category == 'Fruits' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Fruits">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/fruits 1.png" width="90">
                </div>
            </a>
            <p>Fruits</p>
        </div>

        <!-- Vegetables -->
        <div class="cat-item ${param.category == 'Vegetables' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Vegetables">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/vegetables 1.png" width="80">
                </div>
            </a>
            <p>Vegetables</p>
        </div>

        <!-- Dairy -->
        <div class="cat-item ${param.category == 'Dairy' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Dairy">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/dairy 1.png" width="90">
                </div>
            </a>
            <p>Dairy</p>
        </div>

        <!-- Bakery -->
        <div class="cat-item ${param.category == 'Bakery' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Bakery">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/bakery.png" width="90">
                </div>
            </a>
            <p>Bakery</p>
        </div>

        <!-- Beverages -->
        <div class="cat-item ${param.category == 'Beverages' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Beverages">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/beverages%201.png" width="90">
                </div>
            </a>
            <p>Beverages</p>
        </div>

        <!-- Spices -->
        <div class="cat-item ${param.category == 'Spices & Seasoning' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Spices+%26+Seasoning">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/spices%20and%20seasoning%201.png" width="90">
                </div>
            </a>
            <p>Spices & Seasoning</p>
        </div>

    </div>
</div>

<!-- ================= PRODUCT LIST SECTION ================= -->
<div class="section box">

    <div class="tabs">
        <h3 class="tab-active">${activeCategory}</h3>
    </div>

    <div class="product-list">

        <c:choose>

            <%-- Products found → render each one dynamically --%>
           <c:when test="${not empty productList}">
			    <c:forEach var="p" items="${productList}">
			
			        <%-- 1. Add 'oos' class conditionally --%>
			        <div class="product-item ${p.stockQuantity <= 0 ? 'oos' : ''}">
			
			            <%-- 2. Add the red badge right here, inside the card --%>
			            <c:if test="${p.stockQuantity <= 0}">
			                <span class="oos-badge">Out of Stock</span>
			            </c:if>
			
			            <div class="img-placeholder" style="width:100%; height:150px; overflow:hidden; border-radius:8px;">
			                <c:choose>
			                    <c:when test="${not empty p.imageUrl}">
			                        <img src="${pageContext.request.contextPath}/Images/${p.imageUrl}"
			                             alt="${p.name}"
			                             style="width:100%; height:100%; object-fit:cover;"
			                             onerror="this.parentNode.innerHTML='<span class=\'no-img\'>No Image</span>'">
			                    </c:when>
			                    <c:otherwise>
			                        <span class="no-img">No Image</span>
			                    </c:otherwise>
			                </c:choose>
			            </div>
			
			            <p>${p.name}</p>
			            <span>Rs. <fmt:formatNumber value="${p.price}" maxFractionDigits="0"/></span>
			
			            <c:if test="${p.stockQuantity > 0}">
			                <form action="${pageContext.request.contextPath}/cart" method="post">
			                    <input type="hidden" name="action" value="add">
			                    <input type="hidden" name="id"    value="${p.productId}">
			                    <input type="hidden" name="name"  value="${p.name}">
			                    <input type="hidden" name="price" value="${p.price}">
			                    <input type="hidden" name="image" value="${p.imageUrl}">
			                    <button type="submit" class="add-to-cart-btn">Add to Cart</button>
			                </form>
			            </c:if>
			
			            <c:if test="${p.stockQuantity <= 0}">
			                <button class="add-to-cart-btn out-of-stock-btn" disabled>Out of Stock</button>
			            </c:if>
			
			        </div>
			    </c:forEach>
			</c:when>
            <%-- No products found --%>
            <c:otherwise>
                <div class="no-products">
                    <p>No products found
                        <c:if test="${not empty param.category}">in <strong>${param.category}</strong></c:if>.
                    </p>
                </div>
            </c:otherwise>

        </c:choose>

    </div>
</div>

<jsp:include page="Footer.jsp"/>

</body>
</html>
