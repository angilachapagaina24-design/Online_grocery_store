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
			<a href="#">About us</a>
			<a href="#">About us</a>
		
		</div>
		
		
		<div class="nav-right">
			<input type="text"
					placeholder="search"
					class="search-box">
					<a href="cart.jsp">
						<img src="${pageContext.request.contextPath}/Images/360_F_560176615_cUua21qgzxDiLiiyiVGYjUnLSGnVLIi6.jpg" width="30">
					</a>
					<div class="Login"></div>
					<a href ="login.jsp">Sign in</a>
		</div>
	</div>	
	
	
	

		
<!-- ------------------------------------------------- category ------------------------------->
	<div class="section">
    <h2>Category</h2>
    <div class="category-container">
        <div class="cat-item">
            <div class="circle-box">
                <img src="${pageContext.request.contextPath}/Images/fruits%201.png" width="90" alt="Fruits">
            </div>
            <p>Fruits</p>
        </div>
        
        <div class="cat-item">
            <div class="circle-box">
                	<img src="${pageContext.request.contextPath}/Images/vegetables%201.png" width="80"alt="Vegetables">
            </div>
            <p>Vegetables</p>
        </div>

        <div class="cat-item">
            <div class="circle-box">
                <img src="${pageContext.request.contextPath}/Images/dairy%201.png" width="90" alt="Dairy">
            </div>
            <p>Dairy</p>
        </div>

        
        <div class="cat-item">
            <div class="circle-box">
                <img src="${pageContext.request.contextPath}/Images/bakery.png" width="90" alt="Bakery">
            </div>
            <p>Bakery</p>
        </div>
        
        <div class="cat-item">
            <div class="circle-box">
                <img src="${pageContext.request.contextPath}/Images/spices%20and%20seasoning%201.png" width="90" alt="Spices & seasoning">
            </div>
            <p>Spices & seasoning</p>
        </div>
        
        <div class="cat-item">
            <div class="circle-box">
                <img src="${pageContext.request.contextPath}/Images/canned%20and%20packages%201.png" width="60" alt="canned & packaged">
            </div>
            <p>canned & packaged</p>
        </div>
        
        <div class="cat-item">
            <div class="circle-box">
                <img src="${pageContext.request.contextPath}/Images/beverages%201.png" width="90" alt="Beverages">
            </div>
            <p>Beverages</p>
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
            <div class="img-placeholder">
            	<img src="${pageContext.request.contextPath}/Images/Banana%201%201.png" width = "140">
            </div>
            <p>Organic Bananas</p>
            <span>Rs. 120</span>
        </div>
        
        <div class="product-item">
        	<div class="img-placeholder">
        		<img src="${pageContext.request.contextPath}/Images/milk%201.png" width = "120">
        	</div>
        	<p>Fresh Milk</p>
        	<span>Rs. 75</span>
        </div>
        
        <div class="product-item">
        	<div class="img-placeholder">
        		<img src="${pageContext.request.contextPath}/Images/bread%201.png" width = "80">
        	</div>
        	<p>Whole Bread</p>
        	<span>Rs. 75</span>
        </div>
        
        <div class="product-item">
        	<div class="img-placeholder">
        		<img src="${pageContext.request.contextPath}/Images/brown%20eggs%201.png" width = "180">
        	</div>
        	<p>Brown Eggs</p>
        	<span>Rs. 500</span>
        </div>
        
        <div class="product-item">
        	<div class="img-placeholder">
        		<img src="${pageContext.request.contextPath}/Images/buldak%201.png" width = "170">
        	</div>
        	<p>Buldak Ramen</p>
        	<span>Rs. 400</span>
        </div>	
        
        	
        <div class="product-item">
        	<div class="img-placeholder">
        		<img src="${pageContext.request.contextPath}/Images/juice%201.png" width = "135">
        	</div>
        	<p>Simply Tropical Juice</p>
        	<span>Rs. 150</span>
        </div>	
        
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