<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us - FreshMart</title>

    <!-- CSS -->
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
    
</head>
<body>
<jsp:include page="header.jsp"/>

<!-- CONTACT -->
<section class="contact-container">

    <h2>Contact Us</h2>
    <p class="subtitle">We’d love to hear from you!</p>

    <!-- Message -->
    <%
        String msg = (String) request.getAttribute("message");
        if (msg != null) {
    %>
        <p class="msg"><%= msg %></p>
    <%
        }
    %>

    <div class="contact-box">

        <!-- FORM -->
        <form action="contact" method="post" class="form">
            <input type="text" name="name" placeholder="Your Name" required>
            <input type="email" name="email" placeholder="Your Email" required>
            <input type="text" name="subject" placeholder="Subject" required>
            <textarea name="message" placeholder="Your Message" required></textarea>
            <button type="submit">Send Message</button>

        </form>

        <!-- INFO -->
        <div class="info">
            <h3>Store Info</h3>
            <p>📍 Pokhara, Nepal</p>
            <p>📞 +977-9800000000</p>
            <p>📧 freshmart@gmail.com</p>

            <!-- SOCIAL ICONS -->
            <div class="social">
                <h4>Follow Us</h4>
                <div class="icons">
                    <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://wa.me/9779800000000" target="_blank"><i class="fab fa-whatsapp"></i></a>
                </div>
            </div>
        </div>

    </div>

</section>
<jsp:include page="Footer.jsp" />
</body>
</html>