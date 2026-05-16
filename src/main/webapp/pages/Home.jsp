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

<!-- ===== HERO ===== -->
<div class="hero">
    <div class="hero-content">
        <h1>Fresh Fruits &amp; Vegetables</h1>
        <p>Healthy and organic groceries at your doorstep</p>
        <a href="${pageContext.request.contextPath}/product" class="btn">Shop Now</a>
    </div>
</div>

<!-- ===== BEST SELLING / LATEST TABS ===== -->
<div class="product-tabs-wrapper">
    <div class="tabs">
        <button class="tab-btn active" onclick="showTab('bestSelling', this)">Best Selling</button>
        <button class="tab-btn" onclick="showTab('latest', this)">Latest</button>
    </div>

    <!-- Best Selling Tab -->
    <div id="bestSelling" class="tab-content active">
        <div class="product-container">

            <!-- Banana -->
            <div class="product-card">
                <div class="product-img-wrap">
                    <a href="${pageContext.request.contextPath}/productDetail?id=2">
                        <img src="${pageContext.request.contextPath}/Images/banana.png" alt="Banana">
                    </a>
                </div>
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/productDetail?id=2" style="text-decoration:none; color:inherit;">
                        <h4>Organic Bananas</h4>
                    </a>
                    <p class="price">Rs. 120</p>
                    <button class="add-btn" onclick="addToCart(2, 'Banana', 120, 'banana.png')">Add to Cart</button>
                </div>
            </div>

            <!-- Milk -->
            <div class="product-card">
                <div class="product-img-wrap">
                    <a href="${pageContext.request.contextPath}/productDetail?id=25">
                        <img src="${pageContext.request.contextPath}/Images/milk.png" alt="Milk">
                    </a>
                </div>
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/productDetail?id=25" style="text-decoration:none; color:inherit;">
                        <h4>Fresh Milk</h4>
                    </a>
                    <p class="price">Rs. 75</p>
                    <button class="add-btn" onclick="addToCart(25, 'Milk', 75, 'milk.png')">Add to Cart</button>
                </div>
            </div>

            <!-- Bread -->
            <div class="product-card">
                <div class="product-img-wrap">
                    <a href="${pageContext.request.contextPath}/productDetail?id=31">
                        <img src="${pageContext.request.contextPath}/Images/bread.png" alt="Bread">
                    </a>
                </div>
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/productDetail?id=31" style="text-decoration:none; color:inherit;">
                        <h4>Whole Bread</h4>
                    </a>
                    <p class="price">Rs. 75</p>
                    <button class="add-btn" onclick="addToCart(31, 'Bread', 75, 'bread.png')">Add to Cart</button>
                </div>
            </div>

            <!-- Orange Juice -->
            <div class="product-card">
                <div class="product-img-wrap">
                    <a href="${pageContext.request.contextPath}/productDetail?id=8">
                        <img src="${pageContext.request.contextPath}/Images/orangejuice.png" alt="Orange Juice">
                    </a>
                </div>
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/productDetail?id=8" style="text-decoration:none; color:inherit;">
                        <h4>Orange Juice</h4>
                    </a>
                    <p class="price">Rs. 180</p>
                    <button class="add-btn" onclick="addToCart(8, 'Orange Juice', 180, 'orangejuice.png')">Add to Cart</button>
                </div>
            </div>

        </div>
    </div>

    <!-- Latest Tab -->
    <div id="latest" class="tab-content">
        <div class="product-container">

            <!-- Mango -->
            <div class="product-card">
                <div class="product-img-wrap">
                    <a href="${pageContext.request.contextPath}/productDetail?id=5">
                        <img src="${pageContext.request.contextPath}/Images/mango.png" alt="Mango">
                    </a>
                </div>
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/productDetail?id=5" style="text-decoration:none; color:inherit;">
                        <h4>Sweet Mango</h4>
                    </a>
                    <p class="price">Rs. 200</p>
                    <button class="add-btn" onclick="addToCart(5, 'Mango', 200, 'mango.png')">Add to Cart</button>
                </div>
            </div>

            <!-- Paneer -->
            <div class="product-card">
                <div class="product-img-wrap">
                    <a href="${pageContext.request.contextPath}/productDetail?id=30">
                        <img src="${pageContext.request.contextPath}/Images/paneer.png" alt="Paneer">
                    </a>
                </div>
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/productDetail?id=30" style="text-decoration:none; color:inherit;">
                        <h4>Fresh Paneer</h4>
                    </a>
                    <p class="price">Rs. 300</p>
                    <button class="add-btn" onclick="addToCart(30, 'Paneer', 300, 'paneer.png')">Add to Cart</button>
                </div>
            </div>

            <!-- Cake -->
            <div class="product-card">
                <div class="product-img-wrap">
                    <a href="${pageContext.request.contextPath}/productDetail?id=32">
                        <img src="${pageContext.request.contextPath}/Images/cake.png" alt="Cake">
                    </a>
                </div>
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/productDetail?id=32" style="text-decoration:none; color:inherit;">
                        <h4>Chocolate Cake</h4>
                    </a>
                    <p class="price">Rs. 550</p>
                    <button class="add-btn" onclick="addToCart(32, 'Cake', 550, 'cake.png')">Add to Cart</button>
                </div>
            </div>

            <!-- Curry Powder -->
            <div class="product-card">
                <div class="product-img-wrap">
                    <a href="${pageContext.request.contextPath}/productDetail?id=42">
                        <img src="${pageContext.request.contextPath}/Images/curry.png" alt="Curry Powder">
                    </a>
                </div>
                <div class="product-info">
                    <a href="${pageContext.request.contextPath}/productDetail?id=42" style="text-decoration:none; color:inherit;">
                        <h4>Curry Powder</h4>
                    </a>
                    <p class="price">Rs. 180</p>
                    <button class="add-btn" onclick="addToCart(42, 'Curry Powder', 180, 'curry.png')">Add to Cart</button>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- ===== OUR PRODUCTS ===== -->
<div class="section" style="background: white;">
    <h2>Our Products</h2>
    <div class="product-container">

        <!-- Fresh Apple -->
        <div class="product-card">
            <div class="product-img-wrap">
                <a href="${pageContext.request.contextPath}/productDetail?id=1">
                    <img src="${pageContext.request.contextPath}/Images/apple.png" alt="Fresh Apple">
                </a>
            </div>
            <div class="product-info">
                <a href="${pageContext.request.contextPath}/productDetail?id=1" style="text-decoration:none; color:inherit;">
                    <h4>Fresh Apple</h4>
                </a>
                <p class="price">Rs. 320</p>
                <button type="button" class="add-btn" onclick="addToCart(1, 'Fresh Apple', 320, 'apple.png')">Add to Cart</button>
            </div>
        </div>

        <!-- carrot -->
        <div class="product-card">
            <div class="product-img-wrap">
                <a href="${pageContext.request.contextPath}/productDetail?id=17">
                    <img src="${pageContext.request.contextPath}/Images/carrot.png" alt="Carrot">
                </a>
            </div>
            <div class="product-info">
                <a href="${pageContext.request.contextPath}/productDetail?id=17" style="text-decoration:none; color:inherit;">
                    <h4>Carrot</h4>
                </a>
                <p class="price">Rs. 280 per kilo</p>
                <button type="button" class="add-btn" onclick="addToCart(17, 'Carrot', 80, 'carrot.png')">Add to Cart</button>
            </div>
        </div>

        

        <!-- Croissant -->
        <div class="product-card">
            <div class="product-img-wrap">
                <a href="${pageContext.request.contextPath}/productDetail?id=29">
                    <img src="${pageContext.request.contextPath}/Images/croissant.png" alt="Croissant">
                </a>
            </div>
            <div class="product-info">
                <a href="${pageContext.request.contextPath}/productDetail?id=4" style="text-decoration:none; color:inherit;">
                    <h4>Croissant</h4>
                </a>
                <p class="price">Rs. 150</p>
                <button type="button" class="add-btn" onclick="addToCart(29, 'Croissant', 150, 'croissant.png')">Add to Cart</button>
            </div>
        </div>

        <!-- Apple Juice -->
        <div class="product-card">
            <div class="product-img-wrap">
                <a href="${pageContext.request.contextPath}/productDetail?id=11">
                    <img src="${pageContext.request.contextPath}/Images/applejuice.png" alt="Apple Juice">
                </a>
            </div>
            <div class="product-info">
                <a href="${pageContext.request.contextPath}/productDetail?id=11" style="text-decoration:none; color:inherit;">
                    <h4>Apple Juice</h4>
                </a>
                <p class="price">Rs. 170</p>
                <button type="button" class="add-btn" onclick="addToCart(11, 'Apple Juice', 170, 'applejuice.png')">Add to Cart</button>
            </div>
        </div>

        <!-- Grapes -->
        <div class="product-card">
            <div class="product-img-wrap">
                <a href="${pageContext.request.contextPath}/productDetail?id=4">
                    <img src="${pageContext.request.contextPath}/Images/grapes.png" alt="Jam">
                </a>
            </div>
            <div class="product-info">
                <a href="${pageContext.request.contextPath}/productDetail?id=4" style="text-decoration:none; color:inherit;">
                    <h4>Grapes</h4>
                </a>
                <p class="price">Rs. 240</p>
                <button type="button" class="add-btn" onclick="addToCart(4, 'Grapes', 240, 'grapes.png')">Add to Cart</button>
            </div>
        </div>
        
        
        
        <!-- Mango -->
         <div class="product-card">
            <div class="product-img-wrap">
                <a href="${pageContext.request.contextPath}/productDetail?id=5">
                    <img src="${pageContext.request.contextPath}/Images/mango.png" alt="Mango">
                </a>
            </div>
            <div class="product-info">
                <a href="${pageContext.request.contextPath}/productDetail?id=5" style="text-decoration:none; color:inherit;">
                    <h4>mango</h4>
                </a>
                <p class="price">Rs. 200</p>
                <button type="button" class="add-btn" onclick="addToCart(5, 'Mango', 200, 'mango.png')">Add to Cart</button>
            </div>
        </div>

    </div>
</div>

<!-- ===== SERVICES ===== -->
<div class="section">
    <h2>Our Services</h2>
    <div class="service-section">
        <div class="service-box">
            <p>Explore</p>
            <img src="${pageContext.request.contextPath}/Images/explore.gif" width="90" height="90">
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

<!-- ===== SCRIPT ===== -->
<script>

function showTab(tabId, btn) {
    document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    btn.classList.add('active');
}

function addToCart(id, name, price, image) {
    const params = new URLSearchParams();
    params.append('action', 'add');
    params.append('id', id);
    params.append('name', name);
    params.append('price', price);
    params.append('image', image);

    localStorage.setItem('scrollpos', window.scrollY);

    fetch('${pageContext.request.contextPath}/cart', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params.toString()
    })
    .then(response => {
        if (response.status === 401) {
            return response.json().then(data => {
                window.location.href = data.redirect;
            });
        }
        if (response.ok) {
            location.reload();
        }
    })
    .catch(err => console.error("Error:", err));
}

document.addEventListener("DOMContentLoaded", function() {
    var scrollpos = localStorage.getItem('scrollpos');
    if (scrollpos) {
        window.scrollTo(0, scrollpos);
        localStorage.removeItem('scrollpos');
    }
});

</script>

<jsp:include page="Footer.jsp" />

</body>
</html>
