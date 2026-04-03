<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 3/24/2026
  Time: 5:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>Categories</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/about.css">
</head>
<body class="about-page">
<nav class="navbar">
    <div class="navbar-item">
        <div class="logo">
            <a href="index.html"><img src="images/logo2.png" alt="FataFat Kin Logo"></a>
        </div>

        <div class="search-container">
            <input type="text" placeholder="Search product" class="search-input">
            <button class="search-btn" type="button">
                <img src="images/search.png" class="search-icon" alt="">
            </button>
        </div>

        <ul class="nav-links">
            <li><a href="index.html">Home</a></li>
            <li><a href="#">Shop</a></li>
            <li><a href="#">Top Sales</a></li>
            <li><a href="#">New Arrivals</a></li>
            <li><a href="#">Offer</a></li>
            <li><a href="about.html">About</a></li>
            <li class="icon"><a href="#customer-service"><i class="bx bx-help-circle icon"></i><span>customer service</span></a></li>
            <li class="icon"><a href="#"><i class="bx bx-shopping-bag icon"></i><span>cart</span></a></li>
            <li class="icon"><a href="login.html"><i class="bx bx-user icon"></i><span>login</span></a></li>
        </ul>
    </div>
</nav>

<header class="about-hero">
    <div class="about-hero-inner">
        <p class="about-kicker">Our story</p>
        <h1>Fast shopping for a <span>fast life</span></h1>
        <p class="about-lead">Fatafat Kin brings competitive prices on electronics, fashion, and daily essentials—built as part of our coursework to show how a modern Nepal-focused storefront can look and feel.</p>
        <a href="#customer-service" class="about-service-btn"><i class="bx bx-headphone" aria-hidden="true"></i> Customer service</a>
    </div>
</header>

<main class="about-main">
    <section class="about-section about-split">
        <div class="about-split-text">
            <h2>Who we are</h2>
            <hr class="about-rule">
            <p>We imagined Fatafat Kin as Nepal’s friendly online stop for people who want quality without the wait. The site highlights deals, seasonal collections, and trusted brands—so browsing feels as quick as the name suggests.</p>
            <p>This project is a coursework exercise: we focused on layout, navigation, product presentation, and a consistent visual language across pages.</p>
        </div>
        <div class="about-split-visual">
            <img src="images/background.png" alt="Shopping and lifestyle">
        </div>
    </section>

    <section class="about-section about-values">
        <h2>What we stand for</h2>
        <hr class="about-rule">
        <div class="about-cards">
            <article class="about-card">
                <i class="bx bx-package"></i>
                <h3>Value</h3>
                <p>Fair pricing on the products shoppers care about, from sneakers to watches.</p>
            </article>
            <article class="about-card">
                <i class="bx bx-shield-quarter"></i>
                <h3>Trust</h3>
                <p>Clear categories, honest copy, and a layout that puts products first.</p>
            </article>
            <article class="about-card">
                <i class="bx bx-rocket"></i>
                <h3>Speed</h3>
                <p>A streamlined path from homepage to cart—built for a smooth demo experience.</p>
            </article>
        </div>
    </section>

    <section id="customer-service" class="about-section about-service" tabindex="-1">
        <h2>Customer service</h2>
        <hr class="about-rule">
        <p class="about-service-text">We are here for orders, delivery questions, and returns. Contact us using the details below.</p>
        <p class="about-service-line"><i class="bx bx-phone"></i> <a href="tel:+9771234567890">+977 123 456 7890</a></p>
        <p class="about-service-line"><i class="bx bx-envelope"></i> <a href="mailto:support@fatafatkin.com">support@fatafatkin.com</a></p>
    </section>

    <section class="about-cta">
        <div class="about-cta-inner">
            <h2>Ready to explore?</h2>
            <p>Jump back to the shop and see seasonal picks, featured items, and more.</p>
            <a href="index.html" class="about-cta-btn">Back to home</a>
        </div>
    </section>
</main>

<footer class="footer">
    <div class="row">
        <div class="footer-one"></div>
        <p>Fatafat Kin is Nepal’s premier destination for fast, reliable, and premium online shopping.
            Bringing the best of tech and fashion directly to your doorstep.</p>
    </div>
</footer>
</body>
</html>
