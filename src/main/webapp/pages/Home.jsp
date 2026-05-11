<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html> 

<html> 
<head> 
<meta charset="UTF-8"> 
<title>Home</title> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Home.css"> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css"> 
 </head> 
 <body>
  <jsp:include page="header.jsp"/>
   <div class="hero"> <div class="hero-content">
    <h1>Fresh Fruits &amp; Vegetables</h1>
     <p>Healthy and organic groceries at your doorstep</p> 
     <a href="${pageContext.request.contextPath}/product" class="btn">Shop Now</a> 
     </div> 
     </div> 
     <!-- ===== CATEGORIES ===== --> 
     <div class="section"> 
     <h2>Featured Categories</h2> 
     <div class="category-container"> 
     <div class="cat-item"> 
     
     <img src="${pageContext.request.contextPath}/Images/fruits 1.png" width="90"> 
     <p>Fruits</p> </div> <div class="cat-item"> 
     <img src="${pageContext.request.contextPath}/Images/vegetables 1.png" width="90"> 
     <p>Vegetables</p> </div> <div class="cat-item"> 
     <img src="${pageContext.request.contextPath}/Images/dairy 1.png" width="90"> 
     
     <p>Dairy</p> 
     </div> <div class="cat-item"> 
     <img src="${pageContext.request.contextPath}/Images/bakery.png" width="90"> 
     <p>Bakery</p> 
     </div> 
     <div class="cat-item"> 
     <img src="${pageContext.request.contextPath}/Images/beverages.jpg" width="90"> 
     <p>Beverages</p> 
     </div> 
     </div> 
     </div> 
     
     <!-- ===== PRODUCTS ===== --> 
     <div class="section" style="background: white;"> 
     <h2>Our Products</h2>
      <div class="product-container">
       <div class="product-card">
        <img src="${pageContext.request.contextPath}/Images/apple.png">
         <h4>Fresh Apple</h4> 
         <p class="price">Rs. 320</p> 
         <form action="${pageContext.request.contextPath}/cart" method="post"> 
         <input type="hidden" name="action" value="add"> <input type="hidden" name="id" value="1"> 
         <input type="hidden" name="name" value="Fresh Apple"> <input type="hidden" name="price" value="320"> 
         <input type="hidden" name="image" value="apple.png"> 
         <button type="submit">Add to Cart</button> 
         </form> </div> <div class="product-card"> 
         <img src="${pageContext.request.contextPath}/Images/MoongDal.png"> 
         
         <h4>Mung Dal</h4>
          <p class="price">Rs. 280 per kilo</p> 
          <form action="${pageContext.request.contextPath}/cart" method="post"> 
          <input type="hidden" name="action" value="add"> <input type="hidden" name="id" value="2"> 
          <input type="hidden" name="name" value="Moong Dal"> <input type="hidden" name="price" value="280"> 
          <input type="hidden" name="image" value="MoongDal.png"> 
          <button type="submit">Add to Cart</button>
           </form> 
           </div> 
           
           <div class="product-card"> 
           <img src="${pageContext.request.contextPath}/Images/Dairymilk.png"> 
           <h4>Dairy Milk Silk Combo</h4> 
           <p class="price">Rs. 1600</p> 
           <form action="${pageContext.request.contextPath}/cart" method="post"> 
           <input type="hidden" name="action" value="add"> 
           <input type="hidden" name="id" value="3"> 
           <input type="hidden" name="name" value="Dairy Milk Silk Combo"> 
           <input type="hidden" name="price" value="1600"> 
           <input type="hidden" name="image" value="Dairymilk.png"> 
           <button type="submit">Add to Cart</button>
            </form> 
            </div> 
            <div class="product-card"> 
            <img src="${pageContext.request.contextPath}/Images/cauli.png"> 
            <h4>Cauli flower</h4> 
            <p class="price">Rs. 80/kg</p> 
            <form action="${pageContext.request.contextPath}/cart" method="post"> 
            <input type="hidden" name="action" value="add"> 
            <input type="hidden" name="id" value="4"> 
            <input type="hidden" name="name" value="Cauliflower"> 
            <input type="hidden" name="price" value="80"> 
            <input type="hidden" name="image" value="cauli.png"> 
            <button type="submit">Add to Cart</button> 
            </form>
             </div>
<div class="product-card"> 
		<img src="${pageContext.request.contextPath}/Images/milk2.png"> 
		<h4>Milk</h4> 
		<p class="price">Rs. 100/ltr</p> 
		<form action="${pageContext.request.contextPath}/cart" method="post"> 
		<input type="hidden" name="action" value="add">
		 <input type="hidden" name="id" value="5"> 
		 <input type="hidden" name="name" value="Milk"> 
		 <input type="hidden" name="price" value="100"> 
		 <input type="hidden" name="image" value="milk2.png">
		  <button type="submit">Add to Cart</button> 
		  </form>
		   </div>
		    <div class="product-card">
		     <img src="${pageContext.request.contextPath}/Images/jam.png"> 
		     <h4>Jam</h4>
		      <p class="price">Rs. 450</p> 
		      <form action="${pageContext.request.contextPath}/cart" method="post"> 
		      <input type="hidden" name="action" value="add"> <input type="hidden" name="id" value="6">
		       <input type="hidden" name="name" value="Jam"> <input type="hidden" name="price" value="450"> 
		       <input type="hidden" name="image" value="jam.png"> 
		       <button type="submit">Add to Cart</button> 
		       </form> 
		       </div> 
		       </div> 
		       </div> 
		       
	  <!-- ===== SERVICES ===== --> 
	  <div class="section"> 
	  <h2>Our Services</h2> 
	  <div class="service-section"> 
	  <div class="service-box"> 
	  <p>Explore</p> <img src="${pageContext.request.contextPath}/Images/explore.gif" width="90" height="90"> 
	  </div> 
	  
	  <div class="service-box"> 
	  <p>Cart</p> 
	  <img src="${pageContext.request.contextPath}/Images/cart.gif" width="90" height="90"> 
	  
	  </div>
	   <div class="service-box">
	    <p>Payment</p>
	     <img src="${pageContext.request.contextPath}/Images/payment.gif" width="90" height="90">
	      </div>
	       <div class="service-box"> 
	       <p>Delivery</p> 
	       <img src="${pageContext.request.contextPath}/Images/delivery.gif" width="90" height="90">
	        </div>
	         </div>
	          </div> 
	          
	          
	          <script> function addToCart(id, name, price) {
	        	  fetch('${pageContext.request.contextPath}/cart',
	        			  {
	        		  method: 'POST', headers: {
	        			  'Content-Type': 'application/x-www-form-urlencoded', }, 
	        			  body: action=add&id=${id}&name=${name}&price=${price} }) .then(() => 
	        			  { 
	        				  location.reload(); // reload to update cart count }); } 
	          </script> 
	          
<jsp:include page="Footer.jsp" />

 </body> 
 
 </html>