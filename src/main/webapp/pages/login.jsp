<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FreshMart Login</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&family=Lato:wght@400;600&display=swap" rel="stylesheet">

    <!-- Correct CSS Link -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>

<body>

<div class="card">

    <!-- Brand -->
    <div class="brand">
        <h1 class="brand-name">FreshMart</h1>
        <p class="brand-tagline">ONLINE GROCERY STORE</p>
    </div>

    <div class="divider">Welcome Back</div>

    <!-- Form -->
    <form action="login" method="post">

        <p class="error-msg">${error}</p>

       <div class="field">
    		<label>EMAIL</label>
    		<input type="text" name="email" placeholder="Enter your Email" required>
		</div>

        <div class="field">
            <label>PASSWORD</label>
            <input type="password" name="password" placeholder="Enter your Password" required>
        </div>

        <button type="submit" class="btn-login">LOG IN</button>

    </form>

    <p class="footer-link">
        New to FreshMart? <a href="register.jsp">Create an account</a>
    </p>

</div>

</body>
</html>