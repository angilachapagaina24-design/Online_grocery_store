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
            
            <div class="cat-item">
                <div class="circle-box">
                <img src="${pageContext.request.contextPath}/Images/beverages%201.png" width="90">
                </div>
                <p>beverages</p>
            </div>
            
            <div class="cat-item">
                <div class="circle-box">
                <img src="${pageContext.request.contextPath}/Images/spices%20and%20seasoning%201.png" width="90">
                </div>
                <p>Spices & Seasoning</p>
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
                <form action="${pageContext.request.contextPath}/cart" method="post">
            	<input type="hidden" name="action" value="add">
            	<input type="hidden" name="id"    value="101">
            	<input type="hidden" name="name"  value="Organic Bananas">
            	<input type="hidden" name="price" value="120">
            	<input type="hidden" name="image" value="/Images/Banana 1 1.png">
            	<button type="submit" class="add-to-cart-btn">Add to Cart</button>
       			</form>
            </div>

            <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/milk 1.png" width="120">
                </div>
                <p>Fresh Milk</p>
                <span>Rs. 75</span>
                <form action="${pageContext.request.contextPath}/cart" method="post">
            	<input type="hidden" name="action" value="add">
            	<input type="hidden" name="id"    value="102">
            	<input type="hidden" name="name"  value="Fresh Milk">
            	<input type="hidden" name="price" value="75">
            	<input type="hidden" name="image" value="/Images/milk 1.png">
            	<button type="submit" class="add-to-cart-btn">Add to Cart</button>
        		</form>
            </div>

            <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/bread 1.png" width="80">
                </div>
                <p>Whole Bread</p>
                <span>Rs. 75</span>
                <form action="${pageContext.request.contextPath}/cart" method="post">
            	<input type="hidden" name="action" value="add">
            	<input type="hidden" name="id"    value="103">
            	<input type="hidden" name="name"  value="Whole Bread">
            	<input type="hidden" name="price" value="75">
            	<input type="hidden" name="image" value="/Images/bread 1.png">
            	<button type="submit" class="add-to-cart-btn">Add to Cart</button>
        		</form>
            </div>


			<div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/juice%201.png" width="140">
                </div>
                <p>Tropical Drinks</p>
                <span>Rs. 100</span>
                <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="id"    value="103">
            <input type="hidden" name="name"  value="Tropical Drinks">
            <input type="hidden" name="price" value="75">
            <input type="hidden" name="image" value="/Images/juice%201.png">
            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
        </form>
            </div>
            
            
            <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/buldak%201.png" width="130">
                </div>
                <p>Buldak Ramen</p>
                <span>Rs. 250</span>
                <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="id"    value="103">
            <input type="hidden" name="name"  value="uldak Ramen">
            <input type="hidden" name="price" value="75">
            <input type="hidden" name="image" value="/Images/buldak%201.png">
            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
        </form>
            </div>
            
            
            <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/brown%20eggs%201.png" width="140">
                </div>
                <p>Brown Egg</p>
                <span>Rs. 500</span>
                <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="id"    value="103">
            <input type="hidden" name="name"  value="Brown Egg">
            <input type="hidden" name="price" value="75">
            <input type="hidden" name="image" value="/Images/brown%20eggs%201.png">
            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
        </form>
            </div>
            
            
             <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/mapel%20syrup.png" width="80">
                </div>
                <p>Mapel Syrup</p>
                <span>Rs. 380</span>
                <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="id"    value="103">
            <input type="hidden" name="name"  value="Mapel Syrup">
            <input type="hidden" name="price" value="75">
            <input type="hidden" name="image" value="/Images/mapel%20syrup.png">
            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
        </form>
            </div>
            
             <div class="product-item">
                <div class="img-placeholder">
                    <img src="${pageContext.request.contextPath}/Images/strawberrymilk%201.png" width="105">
                </div>
                <p>Strawberry Milk</p>
                <span>Rs. 250</span>
                <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="id"    value="103">
            <input type="hidden" name="name"  value="Strawberry Milk">
            <input type="hidden" name="price" value="75">
            <input type="hidden" name="image" value="/Images/strawberrymilk%201.png">
            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
        </form>
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

