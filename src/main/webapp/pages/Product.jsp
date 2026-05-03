<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Product.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">

<body>

<jsp:include page="header.jsp"/>

<!-- ONLY PRODUCT CONTENT WRAPPED -->

    <!-- ================= CATEGORY ================= -->
    <div class="section">
        <h2>Category</h2>

        <div class="category-container">

            <div class="cat-item">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/fruits 1.png" width="90">
                </div>
                <p>Fruits</p>
            </div>

            <div class="cat-item">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/vegetables 1.png" width="80">
                </div>
                <p>Vegetables</p>
            </div>

            <div class="cat-item">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/dairy 1.png" width="90">
                </div>
                <p>Dairy</p>
            </div>

            <div class="cat-item">
                <div class="circle-box">
                    <img src="${pageContext.request.contextPath}/Images/bakery.png" width="90">
                </div>
                <p>Bakery</p>
            </div>

        </div>
    </div>

    <!-- ================= BEST SELLING ================= -->
    <div class="section box">

        <div class="tabs">
            <h3>Best Selling</h3>
            <h3>Latest</h3>
        </div>

        <div class="product-list">

            <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/Banana 1 1.png" width="140">
                </div>
                <p>Organic Bananas</p>
                <span>Rs. 120</span>
                <button class="add-to-cart-btn">Add to Cart</button>
            </div>

            <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/milk 1.png" width="120">
                </div>
                <p>Fresh Milk</p>
                <span>Rs. 75</span>
                <button class="add-to-cart-btn">Add to Cart</button>
            </div>

            <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/bread 1.png" width="80">
                </div>
                <p>Whole Bread</p>
                <span>Rs. 75</span>
                <button class="add-to-cart-btn">Add to Cart</button>
            </div>

        </div>
    </div>

    <!-- ================= SPECIAL PRODUCTS ================= -->
    <div class="section box">

        <h3>Special Products</h3>

        <div class="product-list">

            <div class="product-item">
                <div class="img-placeholder"></div>
                <p>Gift Hamper</p>
            </div>

            <div class="product-item">
                <div class="img-placeholder"></div>
                <p>Olive Oil Set</p>
            </div>

            <div class="product-item">
                <div class="img-placeholder"></div>
                <p>Cheese Box</p>
            </div>

        </div>
    </div>



<jsp:include page="Footer.jsp"/>

</body>
</html>

