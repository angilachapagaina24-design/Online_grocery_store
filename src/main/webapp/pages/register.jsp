<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FreshMart Register</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&family=Lato:wght@400;600&display=swap" rel="stylesheet">

    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>

<body>

<div class="card">

    <div class="brand">
        <span class="brand-name">FreshMart</span>
        <p class="brand-tagline">ONLINE GROCERY STORE</p>
    </div>

    <hr class="divider">

    <h2 class="title">Create Account</h2>

    <form action="register" method="post">

        <p class="error">${error}</p>

        <div class="row">
            <div class="field">
                <label>First Name <span class="req">*</span></label>
                <input type="text" name="firstName" placeholder="First name" required>
            </div>
            <div class="field">
                <label>Last Name <span class="req">*</span></label>
                <input type="text" name="lastName" placeholder="Last name" required>
            </div>
        </div>

        <div class="field">
            <label>Mobile Number <span class="req">*</span></label>
            <input type="text" name="mobile" placeholder="Enter mobile number" required>
        </div>

        <div class="field">
            <label>Email Address <span class="req">*</span></label>
            <input type="email" name="email" placeholder="Enter email address" required>
        </div>

        <div class="row">
            <div class="field">
                <label>Password <span class="req">*</span></label>
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <div class="field">
                <label>Confirm Password <span class="req">*</span></label>
                <input type="password" name="confirmPassword" placeholder="Confirm password" required>
            </div>
        </div>

        <div class="terms-row">
            <input type="checkbox" id="agree" name="agree" required>
            <span>I agree to Terms &amp; Privacy Policy</span>
        </div>

        <button type="submit" class="btn">Register Now</button>

    </form>

    <p class="login-link">
        Already have an account? <a href="login.jsp">Login</a>
    </p>

</div>

</body>
</html>