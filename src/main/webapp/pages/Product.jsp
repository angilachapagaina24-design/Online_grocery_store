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
			<a href="home.jsp">Home</a>
			<a href="Product.jsp">Product</a>
			<a href="About us.jsp">About</a>
		
		</div>
		
		
		<div>
			<input type="text"
					placeholder="search"
					class="search-box">
			<a href="cart.jsp"><img src="/Images/360_F_560176615_cUua21qgzxDiLiiyiVGYjUnLSGnVLIi6.jpg" width="120" height="120"></a>
		</div>
	</div>	
	
	
	
	<h2>Category</h2>
		
<!-- ------------------------------------------------- category ------------------------------->
	<h2>Category</h2>
	<div class="Product-list"/>
		<div class="product-img"></div> 
		<div class="product-img"></div> 
		<div class="product-img"></div> 
		<div class="product-img"></div> 
	</div>
</body>
</html>