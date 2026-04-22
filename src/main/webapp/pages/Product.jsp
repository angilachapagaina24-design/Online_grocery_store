<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Product.css">
</head>
<body>
<!-- --------------------------------------------------header ----------------------------------------------->
	<div class ="navbar">
	
		<div class = "Logo">
			<b>LOGO</b>
		</div>
		
		<div class= "Nav-bar">
			<a href="#">Home</a>
			<a href="#">Product</a>
			<a href="#">About</a>
		
		</div>
		
		
		<div class="nav-right">
			<input type="text"
					placeholder="search"
					class="search-box">
					<a href="cart.jsp">
						<img src="${pageContext.request.contextPath}/Images/360_F_560176615_cUua21qgzxDiLiiyiVGYjUnLSGnVLIi6.jpg" width="30">
					</a>
		</div>
	</div>	
	
	
	

		
<!-- ------------------------------------------------- category ------------------------------->
	<div class="section">
    <h2>Category</h2>
    <div class="category-container">
        <div class="cat-item">
            <div class="circle-box">
                <img src="path/to/fruits.png" alt="Fruits">
            </div>
            <p>Fruits</p>
        </div>
        
        <div class="cat-item">
            <div class="circle-box">
                <img src="path/to/vegies.png" alt="Vegetables">
            </div>
            <p>Vegetables</p>
        </div>

        <div class="cat-item">
            <div class="circle-box">
                <img src="path/to/dairy.png" alt="Dairy">
            </div>
            <p>Foodgrains</p>
        </div>

        </div>
</div>
	
<!---------------------------------------------------------Best Selling----------------------------------------->

<div class="section box">
    <div class="tabs">
        <h3>Best Selling</h3>
        <h3>Latest</h3>
    </div>
    
    <div class="product-list">
        <div class="product-item">
            <div class="img-placeholder"></div>
            <p>Organic Bananas</p>
            <span>$3.50</span>
        </div>
        <div class="product-item"><div class="img-placeholder"></div><p>Fresh Milk</p><span>$4.00</span></div>
        <div class="product-item"><div class="img-placeholder"></div><p>Whole Bread</p><span>$2.20</span></div>
        <div class="product-item"><div class="img-placeholder"></div><p>Brown Eggs</p><span>$5.10</span></div>
    </div>
</div>
<!---------------------------------------------------------special products----------------------------------------->

<div class="section box">
    <h3>Special Products</h3>
    <div class="product-list">
        <div class="product-item">
            <div class="img-placeholder"></div>
            <p>Gift Hamper</p>
            <i class="fab fa-whatsapp"></i> </div>
        <div class="product-item"><div class="img-placeholder"></div><p>Olive Oil Set</p></div>
        <div class="product-item"><div class="img-placeholder"></div><p>Cheese Box</p></div>
    </div>
</div>
<!---------------------------------------------------------Footer----------------------------------------->
<footer class="footer">
    <div class="footer-content"> <div class="footer-col">
            <h4>Useful Links</h4>
            <ul>
                <li><a href="#">Home</a></li>
                <li><a href="#">product</a></li>
                <li><a href="#">blog</a></li>
                <li><a href="#">research</a></li>
                <li><a href="#">about us</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h4>Get Latest Updates</h4>
            <p>Subscribe to our newsletter</p>
            <button class="subscribe-btn">Subscribe Now</button>
        </div>

        <div class="footer-col">
            <h4>Connect With Us</h4>
            <p>ABCDEF</p>
            <p>Online Business</p>
            <p>Pokhara, Nepal</p>
        </div>

    </div>
</footer>
</body>
</html>