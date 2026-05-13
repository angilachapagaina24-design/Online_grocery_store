<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About us</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Aboutus.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
<body>

<jsp:include page="header.jsp"/>

<!-- WELCOME -->
<section class="welcome">
    <h2>Welcome To Our Store</h2>
    <p>
        FreshMart is your one-stop destination for fresh groceries, daily essentials, 
        and quality products delivered right to your doorstep.
    </p>
</section>

<!-- TEAM PHOTO SLIDER -->
<section class="team">
    <h3>Team Members</h3>

    <div class="photo-slider">

        <button class="prev" onclick="moveSlide(-1)">❮</button>

        <div class="photo-track" id="photoTrack">

            <div class="photo">
                <div class="img"></div>
                <p>Nisha Magar</p>
            </div>

            <div class="photo">
                <div class="img"></div>
                <p>Jeena Dhakal</p>
            </div>

            <div class="photo">
                <div class="img"></div>
                <p>Angila Chapagain</p>
            </div>

            <div class="photo">
                <div class="img"></div>
                <p>Sampada Parajuli</p>
            </div>

        </div>

        <button class="next" onclick="moveSlide(1)">❯</button>

    </div>
</section>

<!-- WHY -->
<section class="why">
    <h3>Why Our Mart</h3>
    <p>FreshMart provides high-quality groceries sourced from trusted suppliers.</p>
    <p>We focus on freshness, affordability, and customer satisfaction.</p>
    <p>Our goal is to make grocery shopping convenient, reliable, and accessible.</p>
</section>

<!-- ================= FIXED SLIDER SCRIPT ================= -->
<script>
let index = 0; 

function moveSlide(step) {
    const track = document.getElementById("photoTrack");
    const total = track.children.length;

    index = index + step;

    // wrap to last if going before first
    if (index < 0) {
        index = total - 1;
    }

    // wrap to first if going after last
    if (index >= total) {
        index = 0;
    }

    track.style.transform = "translateX(-" + (index * 100) + "%)";
}
</script>

<jsp:include page="Footer.jsp"/>

</body>
</html>