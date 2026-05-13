<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products - FreshMart</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Product.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">


</head>

<body>
<jsp:include page="header.jsp"/>

<!-- ================= CATEGORY SECTION ================= -->
<div class="section">
    <h2>Category</h2>
    <div class="category-container">

        <div class="cat-item ${empty param.category ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/all.png" width="70"
                         onerror="this.style.fontSize='32px';this.textContent='🛒';">
                </div>
            </a>
            <p>All</p>
        </div>

        <div class="cat-item ${param.category == 'Fruits' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Fruits">
                <div class="circle-box"><img src="${pageContext.request.contextPath}/Images/fruits 1.png" width="80"></div>
            </a>
            <p>Fruits</p>
        </div>

        <div class="cat-item ${param.category == 'Vegetables' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Vegetables">
                <div class="circle-box"><img src="${pageContext.request.contextPath}/Images/vegetables 1.png" width="80"></div>
            </a>
            <p>Vegetables</p>
        </div>

        <div class="cat-item ${param.category == 'Dairy' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Dairy">
                <div class="circle-box"><img src="${pageContext.request.contextPath}/Images/dairy 1.png" width="80"></div>
            </a>
            <p>Dairy</p>
        </div>

        <div class="cat-item ${param.category == 'Bakery' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Bakery">
                <div class="circle-box"><img src="${pageContext.request.contextPath}/Images/bakery.png" width="80"></div>
            </a>
            <p>Bakery</p>
        </div>

        <div class="cat-item ${param.category == 'Beverages' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Beverages">
                <div class="circle-box"><img src="${pageContext.request.contextPath}/Images/beverages 1.png" width="80"></div>
            </a>
            <p>Beverages</p>
        </div>

        <div class="cat-item ${param.category == 'Spices & Seasoning' ? 'active-cat' : ''}">
            <a href="${pageContext.request.contextPath}/product?category=Spices+%26+Seasoning">
                <div class="circle-box"><img src="${pageContext.request.contextPath}/Images/spices and seasoning 1.png" width="80"></div>
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

            <c:when test="${not empty productList}">
                <c:forEach var="p" items="${productList}">

                    <%-- Add 'oos' class when out of stock --%>
                    <div class="product-item ${p.stockQuantity <= 0 ? 'oos' : ''}">

                        <%-- Red Out of Stock badge --%>
                        <c:if test="${p.stockQuantity <= 0}">
                            <span class="oos-badge">Out of Stock</span>
                        </c:if>

                        <div class="img-placeholder" style="width:100%; height:150px; overflow:hidden; border-radius:8px;">
                            <c:choose>
                                <c:when test="${not empty p.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/Images/${p.imageUrl}"
                                         alt="${p.name}"
                                         style="width:100%; height:100%; object-fit:cover;"
                                         onerror="this.parentNode.innerHTML='<span style=\'line-height:150px;color:#ccc;\'>No Image</span>'">
                                </c:when>
                                <c:otherwise>
                                    <span style="line-height:150px; color:#ccc;">No Image</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <p style="font-weight:600; margin:12px 0 4px;">${p.name}</p>
                        <span style="color:#2e7d32; font-size:15px; font-weight:700;">
                            Rs. <fmt:formatNumber value="${p.price}" maxFractionDigits="0"/>
                        </span>

                        <c:if test="${not empty p.unit}">
                            <span style="color:#999; font-size:12px;">/ ${p.unit}</span>
                        </c:if>

                        <%-- Add to Cart (only when in stock) --%>
                        <c:if test="${p.stockQuantity > 0}">
		    				<button type="button" class="add-to-cart-btn"
   							 onclick="addToCart('${p.productId}', '${p.name}', '${p.price}', '${p.imageUrl}')">
   							 Add to Cart
							</button>
						</c:if>

                        <%-- Disabled button when out of stock --%>
                        <c:if test="${p.stockQuantity <= 0}">
                            <button class="add-to-cart-btn out-of-stock-btn" disabled>Out of Stock</button>
                        </c:if>

                    </div>

                </c:forEach>
            </c:when>

            <c:otherwise>
                <div style="padding: 40px; text-align:center; width:100%; color:#888;">
                    <p style="font-size:18px;">No products found
                        <c:if test="${not empty param.category}"> in <strong>${param.category}</strong></c:if>.
                    </p>
                </div>
            </c:otherwise>

        </c:choose>

    </div>
</div>

<jsp:include page="Footer.jsp"/>


<script>

function addToCart(id, name, price, image) {

    const params = new URLSearchParams();
    params.append('action', 'add');
    params.append('id', id);
    params.append('name', name);
    params.append('price', price);
    params.append('image', image);

    // Save scroll position
    localStorage.setItem('scrollpos', window.scrollY);

    fetch('${pageContext.request.contextPath}/cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: params.toString()
    })
    .then(response => {
        if (response.ok) {
            location.reload();
        }
    })
    .catch(err => console.error("Error:", err));
}


// Restore scroll position
document.addEventListener("DOMContentLoaded", function() {

    var scrollpos = localStorage.getItem('scrollpos');

    if (scrollpos) {
        window.scrollTo(0, scrollpos);
        localStorage.removeItem('scrollpos');
    }
});

</script>
</script>

</body>
</html>
