<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 3/27/2026
  Time: 11:18 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fatafat-Kin</title>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">--%>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css"/>--%>
<%--    <script src="${pageContext.request.contextPath}/static/js/dashboard.js"></script>--%>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css">
    <script src="${pageContext.request.contextPath}/static/js/login.js"></script>
</head>
<body>
<div class="container">
    <!--login Forn-->
    <div class="form-box login">
        <c:if test="${not empty error}">
            <span style="color: red;">${error}</span>
        </c:if>
        <form action="">
            <h1>Login</h1>
            <div class="input-box">
                <input type="text" name="email" placeholder="Email" required>
                <i class='bx bxs-user'></i>
            </div>

            <div class="input-box">
                <input type="password" name="password" placeholder="Password" required>
                <i class='bx bxs-lock-alt'></i>
            </div>

            <div class="forget-link">
                <a href="#">Forgot Password</a>
            </div>

            <button type="submit" class="btn">Login</button>
            <p>Or Login With Social Platforms</p>
            <div class="social-icons">
                <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg" alt="Google G Logo" class="google-logo"></i></a>
                <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/b/b9/2023_Facebook_icon.svg" alt="Facebook"></a>
                <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg" alt="GitHub"></a>
                <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/8/81/LinkedIn_icon.svg" alt="LinkedIn"></a>

            </div>
        </form>
    </div>

    <!--Register Form-->
    <div class="form-box register">
        <form action="/register" method="post">
            <h1>Registration</h1>
            <div class="input-box fname">
                <input type="text" name="First Name" placeholder="firstName" required>
                <i class='bx bxs-user'></i>
            </div>

            <div class="input-box lname">
                <input type="text" name="Last Name" placeholder="lastName" required>
                <i class='bx bxs-user'></i>
            </div>

            <div class="input-box phone">
                <input type="number" name="PhoneNo" placeholder="phone" required>
                <i class='bx bxs-phone'></i>
            </div>

            <div class="input-box dob">
                <input type="Date" name="dob" placeholder="DD/MM/YYYY" required>
                <i class='bx bxs-calendar'></i>
            </div>

            <div class="input-box">
                <input type="email" placeholder="email" required>
                <i class='bx bxs-envelope'></i>
            </div>

            <div class="input-box">
                <input type="number" name="address" placeholder="Address..." required>
                <i class='bx bxs-map'></i>
            </div>

            <div class="input-box">
                <input type="password" name="password0" placeholder="Password" required>
                <i class='bx bxs-lock-alt'></i>
            </div>
            <div class="input-box">
                <input type="password" name="password" placeholder="Confirm password" required>
                <i class='bx bxs-lock-alt'></i>
            </div>

            <button type="submit" class="btn register-btn">Register</button>
            <p>Or Register Social Platforms</p>
            <div class="social-icons">
                <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg" alt="Google G Logo" class="google-logo"></i></a>
                <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/b/b9/2023_Facebook_icon.svg" alt="Facebook"></a>
                <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg" alt="GitHub"></a>
                <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/8/81/LinkedIn_icon.svg" alt="LinkedIn"></a>

            </div>
        </form>
    </div>


    <!--Toggle Box-->
    <div class="toggle-box">

        <!--Toggle Box Left-->
        <div class="toggle-panel toggle-left">
            <h1>Hello, Welcome!</h1>
            <p>Don't have an account?</p>
            <button class="btn switch-to-register">Register</button>
        </div>

        <!--Toggle Box right-->
        <div class="toggle-panel toggle-right">
            <h1>Welcome Back!</h1>
            <p>Already have an account?</p>
            <button type="button" class="btn switch-to-login">Login</button>
        </div>
    </div>

</div>
</body>
</html>
