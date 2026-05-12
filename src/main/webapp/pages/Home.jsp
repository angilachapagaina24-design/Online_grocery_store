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
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${pageContext.request.contextPath}/Images/banana.png" alt="Banana">
                </div>
                <div class="product-info">
                    <h4>Organic Bananas</h4>
                    <p class="price">Rs. 120</p>
                    <button class="add-btn" onclick="addToCart(2, 'Banana', 120, 'banana.png')">Add to Cart</button>
                </div>
            </div>
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${pageContext.request.contextPath}/Images/milk.png" alt="Milk">
                </div>
                <div class="product-info">
                    <h4>Fresh Milk</h4>
                    <p class="price">Rs. 75</p>
                    <button class="add-btn" onclick="addToCart(25, 'Milk', 75, 'milk.png')">Add to Cart</button>
                </div>
            </div>
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${pageContext.request.contextPath}/Images/bread.png" alt="Bread">
                </div>
                <div class="product-info">
                    <h4>Whole Bread</h4>
                    <p class="price">Rs. 75</p>
                    <button class="add-btn" onclick="addToCart(31, 'Bread', 75, 'bread.png')">Add to Cart</button>
                </div>
            </div>
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${pageContext.request.contextPath}/Images/orangejuice.png" alt="Orange Juice">
                </div>
                <div class="product-info">
                    <h4>Orange Juice</h4>
                    <p class="price">Rs. 180</p>
                    <button class="add-btn" onclick="addToCart(8, 'Orange Juice', 180, 'orangejuice.png')">Add to Cart</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Latest Tab -->
    <div id="latest" class="tab-content">
        <div class="product-container">
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${pageContext.request.contextPath}/Images/mango.png" alt="Mango">
                </div>
                <div class="product-info">
                    <h4>Sweet Mango</h4>
                    <p class="price">Rs. 200</p>
                    <button class="add-btn" onclick="addToCart(5, 'Mango', 200, 'mango.png')">Add to Cart</button>
                </div>
            </div>
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${pageContext.request.contextPath}/Images/paneer.png" alt="Paneer">
                </div>
                <div class="product-info">
                    <h4>Fresh Paneer</h4>
                    <p class="price">Rs. 300</p>
                    <button class="add-btn" onclick="addToCart(30, 'Paneer', 300, 'paneer.png')">Add to Cart</button>
                </div>
            </div>
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${pageContext.request.contextPath}/Images/cake.png" alt="Cake">
                </div>
                <div class="product-info">
                    <h4>Chocolate Cake</h4>
                    <p class="price">Rs. 550</p>
                    <button class="add-btn" onclick="addToCart(32, 'Cake', 550, 'cake.png')">Add to Cart</button>
                </div>
            </div>
            <div class="product-card">
                <div class="product-img-wrap">
                    <img src="${pageContext.request.contextPath}/Images/curry.png" alt="Curry Powder">
                </div>
                <div class="product-info">
                    <h4>Curry Powder</h4>
                    <p class="price">Rs. 180</p>
                    <button class="add-btn" onclick="addToCart(42, 'Curry Powder', 180, 'curry.png')">Add to Cart</button>
                </div>
            </div>
        </div>
    </div>
</div>



<!-- ===== PRODUCTS ===== -->
<div class="section" style="background: white;">
    <h2>Our Products</h2>
    <div class="product-container">

        <!-- Fresh Apple -->
        <div class="product-card">
            <div class="product-img-wrap">
                <img src="${pageContext.request.contextPath}/Images/apple.png" alt="Fresh Apple">
            </div>
            <div class="product-info">
                <h4>Fresh Apple</h4>
                <p class="price">Rs. 320</p>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="1">
                    <input type="hidden" name="name" value="Fresh Apple">
                    <input type="hidden" name="price" value="320">
                    <input type="hidden" name="image" value="apple.png">
                    <button type="button" class="add-btn" onclick="addToCart(1, 'Fresh Apple', 320, 'apple.png')">Add to Cart</button>
                </form>
            </div>
        </div>

        <!-- Mung Dal -->
        <div class="product-card">
            <div class="product-img-wrap">
                <img src="${pageContext.request.contextPath}/Images/MoongDal.png" alt="Mung Dal">
            </div>
            <div class="product-info">
                <h4>Mung Dal</h4>
                <p class="price">Rs. 280 per kilo</p>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="2">
                    <input type="hidden" name="name" value="Moong Dal">
                    <input type="hidden" name="price" value="280">
                    <input type="hidden" name="image" value="MoongDal.png">
                    <button type="button" class="add-btn" onclick="addToCart(2, 'Moong Dal', 280, 'MoongDal.png')">Add to Cart</button>
                </form>
            </div>
        </div>

        <!-- Dairy Milk Silk Combo -->
        <div class="product-card">
            <div class="product-img-wrap">
                <img src="${pageContext.request.contextPath}/Images/Dairymilk.png" alt="Dairy Milk Silk Combo">
            </div>
            <div class="product-info">
                <h4>Dairy Milk Silk Combo</h4>
                <p class="price">Rs. 1600</p>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="3">
                    <input type="hidden" name="name" value="Dairy Milk Silk Combo">
                    <input type="hidden" name="price" value="1600">
                    <input type="hidden" name="image" value="Dairymilk.png">
                    <button type="button" class="add-btn" onclick="addToCart(3, 'Dairy Milk Silk Combo', 1600, 'Dairymilk.png')">Add to Cart</button>
                </form>
            </div>
        </div>

        <!-- Cauliflower -->
        <div class="product-card">
            <div class="product-img-wrap">
                <img src="${pageContext.request.contextPath}/Images/cauli.png" alt="Cauli flower">
            </div>
            <div class="product-info">
                <h4>Cauli flower</h4>
                <p class="price">Rs. 80/kg</p>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="4">
                    <input type="hidden" name="name" value="Cauliflower">
                    <input type="hidden" name="price" value="80">
                    <input type="hidden" name="image" value="cauli.png">
                    <button type="button" class="add-btn" onclick="addToCart(4, 'Cauliflower', 80, 'cauli.png')">Add to Cart</button>
                </form>
            </div>
        </div>

        <!-- Milk -->
        <div class="product-card">
            <div class="product-img-wrap">
                <img src="${pageContext.request.contextPath}/Images/milk2.png" alt="Milk">
            </div>
            <div class="product-info">
                <h4>Milk</h4>
                <p class="price">Rs. 100/ltr</p>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="5">
                    <input type="hidden" name="name" value="Milk">
                    <input type="hidden" name="price" value="100">
                    <input type="hidden" name="image" value="milk2.png">
                    <button type="button" class="add-btn" onclick="addToCart(5, 'Milk', 100, 'milk2.png')">Add to Cart</button>
                </form>
            </div>
        </div>

        <!-- Jam -->
        <div class="product-card">
            <div class="product-img-wrap">
                <img src="${pageContext.request.contextPath}/Images/jam.png" alt="Jam">
            </div>
            <div class="product-info">
                <h4>Jam</h4>
                <p class="price">Rs. 450</p>
                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="6">
                    <input type="hidden" name="name" value="Jam">
                    <input type="hidden" name="price" value="450">
                    <input type="hidden" name="image" value="jam.png">
                    <button type="button" class="add-btn" onclick="addToCart(6, 'Jam', 450, 'jam.png')">Add to Cart</button>
                </form>
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
