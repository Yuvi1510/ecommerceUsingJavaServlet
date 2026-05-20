<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
  <title>Categories</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

<style>
@import url("https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");

* {
  font-family: "Poppins", sans-serif;
  text-decoration: none;
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html,
body {
  overflow-x: hidden;
  scrollbar-width: none;
}

body {
  background: #fff;
}

body::-webkit-scrollbar {
  display: none;
}

/*universal selection for button*/
button {
  font-size: 0.8rem;
  font-weight: 700;
  outline: none;
  border: none;
  background-color: #1d1d1d;
  color: aliceblue;
  padding: 13px 30px;
  cursor: pointer;
  text-transform: uppercase;
  transition: 0.3s ease;
}

button:hover {
  background-color: #3a3833;
}

/* navbar design*/
.navbar {
  background: #f9f9f9;

  padding: 10px 40px;

  width: 100%;

  position: fixed;

  top: 0;

  left: 0;
}

.navbar-item {
  display: flex;

  justify-content: space-between;

  align-items: center;
}

#cart-count {
  position: absolute;
  top: -3px;
  right: 32px;
  background-color: #ff523b;
  color: white;
  font-size: 11px;
  font-weight: bold;
  width: 18px;
  height: 18px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  visibility: hidden; /* Hide until at least 1 item is added */
}

#cart-count.show {
  visibility: visible;
}

/* Logo Styling */

.logo img {
  height: 70px;

  display: block;
}

/* Search Bar Styling */

.search-container {
  display: flex;
  flex: 0 1 400px;
  margin: 0 20px;
}

.search-input {
  width: 100%;
  padding: 8px 15px;
  border: 1px solid #ddd;
  border-radius: 4px 0 0 4px;
  outline: none;
}

.search-btn {
  background: #f39c12;
  border: none;
  padding: 8px 12px;
  border-radius: 0 4px 4px 0;
  cursor: pointer;
  display: flex;
  align-items: center;
}

.search-icon {
  width: 18px;
}



/* Navigation Links */

.nav-links {
  display: flex;

  list-style: none;

  gap: 0px;
}

.nav-links li {
  width: 110px;

  text-align: center;

  display: flex;

  font-family: poppins;

  justify-content: center;

  align-items: center;
}

.nav-links li a {
  display: block;

  width: 100%;

  color: #000;

  font-size: 14px;

  font-weight: 500;

  transition: all 0.3s;

  padding: 8px 0;

  text-decoration: none;
}

.nav-links li a.active {
  background-color: rgb(62, 237, 3);

  color: #fff;

  border-radius: 4px;

  font-weight: 600;

  display: inline-block;

  padding: 8px 15px;

  transition: all 0.3s;
}

.nav-links .icon a {
  display: flex;

  flex-direction: column;

  align-items: center;

  gap: 2px;

  color: #000;

  text-align: center;

  font-size: 14px;

  font-weight: 500;
}

.nav-links .icon i {
  font-size: 22px;

  display: block;
}

.nav-links .icon span {
  font-size: 14px;

  font-weight: 500;

  font-family: poppins;

  display: block;
}

.nav-links .icon a:hover {
  font-weight: bold;
}

/* Sidebar hidden by default */

.shortcut-links {
  position: fixed;

  top: 0;

  right: -350px;
  /* hidden */

  width: 300px;

  height: 100vh;

  background: #ffffff;

  padding: 80px 20px 20px;

  overflow-y: auto;

  box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);

  transition: 0.3s ease;

  z-index: 1000;
}

.shortcut-links.active {
  right: 0;
}

.shortcut-links a {
  display: block;

  padding: 12px 15px;

  margin-bottom: 10px;

  border-radius: 8px;

  color: #333;

  font-size: 15px;

  text-decoration: none;

  transition: 0.3s;
}

.shortcut-links a:hover {
  background: #f5f5f5;

  color: #ff6a00;

  transform: translateX(5px);
}

.shortcut-links a:first-child {
  background: #fff1e6;

  color: #ff6a00;

  font-weight: bold;
}

.shortcut-links::-webkit-scrollbar {
  width: 5px;
}

.shortcut-links::-webkit-scrollbar-thumb {
  background: #ccc;

  border-radius: 10px;
}

/*home section*/
#home {
  background-image: url("${pageContext.request.contextPath}/static/images/background1.png");
  /*background: #ECECEC;*/
  width: 100%;
  height: 88vh;
  background-size: cover;
  background-position: top center;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
}

#home span {
  color: coral;
}

/*.container {*/
/*  margin-left: 90px;*/
/*}*/

.container h5 {
  font-size: 1.3rem;
  font-weight: normal;
}

.container h1 {
  margin-top: 15px;
}

.container p {
  margin-top: 15px;
  margin-bottom: 15px;
  font-size: 1.3rem;
}

/*brand logo section*/
.row {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  gap: 40px;
  padding: 20px;
}

.brand-logo {
  width: 100px;
  height: auto;
}

/*for new sewctio*/
.product-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  transition: opacity 0.3s ease-in-out;
}

.one {
  position: relative;
  width: 100%;
  aspect-ratio: 1 / 1;
  overflow: hidden;
  background: #f4f4f4;
}

.one .img-fluid {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.one:hover .img-fluid {
  transform: scale(1.1);
}

.one .details {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
  width: 80%;
  pointer-events: none;
  z-index: 2;
}

/* h2 Heading Style */
.one .details h2 {
  font-size: 24px;
  color: #fff;
  font-weight: 700;
  text-transform: uppercase;
  margin: 0;
  text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
}

#new .one .details button {
  display: inline-block;
  font-size: 14px;
  font-weight: 500;
  color: #000;
  background: none;
  text-transform: uppercase;
  border-bottom: 1px solid #000;
  padding: 2.5px;
  transform: translateY(70px);
  transition: 0.3s ease;
  cursor: pointer;
}

#new .one .details button:hover {
  color: coral;
  border-bottom: 1px solid coral;
}

#new .one:nth-child(1) .details {
  color: #000;
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: flex-start;
  text-align: center;
}

#new .one:nth-child(2) .details {
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: flex-start;
  text-align: center;
}

#new .one:nth-child(3) .details {
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: flex-start;
  text-align: center;
}

/* featured*/
#featured {
  margin-top: 5px;
  margin-bottom: 5px;
  padding: 5px;
  text-align: center;
}

#featured h3 {
  font-weight: normal;
  font-size: 1.6rem;
  margin-bottom: 5px;
  padding: 5px;
}

.product-list {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: stretch;
  gap: 20px;
  flex-wrap: nowrap;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  overflow-x: auto;
  padding: 20px 0;
}

#featured .product-container {
  flex: 0 0 calc(25% - 20px);
  min-width: 250px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  border: 1px solid #eee;
  border-radius: 8px;
  padding: 20px;
  box-sizing: border-box;
  background: #fff;
  transition: 0.3s shadow;
}

.img-box {
  background-color: #f9f9f9;
  width: 100%;
  height: 200px;
  margin-bottom: 15px;
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
}

.img-box img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
}

/* 2. ALIGN TEXT AND STARS */
.star {
  color: #f1c40f;
  margin-bottom: -10px;
  height: 20px;
}

.p-name {
  font-size: 1.1rem;
  color: #333;
  margin-bottom: -20px;
  font-weight: normal;
  min-height: 2.4em;
  font-weight: bold;
}

.p-price {
  font-size: 1.2rem;
  font-weight: bold;
  color: #c4891b;
  margin-bottom: -15px;
}

.p-price s {
  color: #000;
  text-decoration: line-through;
}

.buy-btn {
  background-color: coral;
  color: white;
  padding: 12px 25px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  width: 80%;
  margin-top: auto;
  opacity: 0;
  visibility: hidden;
  transform: translateY(10px);
}

#featured .product-container:hover .buy-btn {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

.buy-btn:hover {
  background: coral;
}

#banner {
  background-image: url("${pageContext.request.contextPath}/static/images/8.jpg");
  width: 100%;
  height: 60vh;
  background-size: cover;
  background-position: top center;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  margin-top: 30px;
  margin-bottom: 30px;
}

.banner {
  margin-left: 90px;
}

#banner h4 {
  color: rgb(32, 32, 102);
  margin-bottom: 10px;
  font-size: 1.3rem;
  font-weight: normal;
}

#banner h1 {
  color: #fff;
  margin-bottom: 10px;
}

#banner p {
  color: #fff;
  margin-bottom: 15px;
  font-size: 1.3rem;
}

#banner button {
  background: coral;
}

#watches {
  margin-top: 5px;
  margin-bottom: 5px;
  padding: 5px;
  text-align: center;
}

#watches h3 {
  font-weight: normal;
  font-size: 1.6rem;
  margin-bottom: 5px;
  padding: 5px;
}

hr {
  width: 60px;
  height: 5px;
  background-color: rgb(133, 94, 22);
  border: none;
  margin: 10px auto;
  border-radius: 5px;
}

/*footer section*/
.footer {
  background-color: #1d1d1d;
  /* Dark background like the image */
  color: #9a9a9a;
  padding: 60px 0;
  margin-top: 50px;
}

.footer .row {
  display: flex;
  justify-content: space-around;
  align-items: flex-start;
  max-width: 1200px;
  margin: 0 auto;
  gap: 100px;
}

.footer-one {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 15px;
}

/* Logo and Description */
.footer-one img {
  width: 150px;
  height: auto;
}

.footer-one p {
  font-size: 0.9rem;
  line-height: 1.6;
  color: #9a9a9a;
}

/* Headings */
.footer-one h5 {
  color: #d8d8d8;
  font-size: 1.2rem;
  margin-bottom: 10px;
  text-transform: capitalize;
}

/* List Styling */
.footer-one ul {
  list-style: none;
  padding: 0;
}

.footer-one ul li {
  margin-bottom: 8px;
}

.footer-one ul li a {
  color: #9a9a9a;
  text-transform: uppercase;
  font-size: 0.85rem;
  transition: 0.3s;
}

.footer-one ul li a:hover {
  color: #fff;
}

/* Contact Section */
.footer-one .text {
  color: #fff;
  font-size: 0.85rem;
  font-weight: 600;
  margin-top: 10px;
}

.footer-one .insta-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 5px;
  width: fit-content;
}

.footer-one .insta-grid img {
  width: 70px;
  height: 70px;
  object-fit: cover;
}

.payment {
  width: 100%;
  background-color: #1d1d1d;
  padding: 20px 40px;
  border-top: 1px solid #333;
}

.payment-img {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1200px;
  margin: 0 auto;
}

.image {
  display: flex;
  align-items: center;
  gap: 15px;
}

.image img {
  height: 30px;
  width: auto;
  object-fit: contain;
  filter: grayscale(0.5);
  transition: 0.3s;
}

.image img:hover {
  filter: grayscale(0);
}

/* fixing github fb and linkined icon of footer*/
.social-icons {
  display: flex;
  gap: 20px;
  align-items: center;
}

.social-link {
  display: flex;
  align-items: center;
  text-decoration: none;
  background-color: transparent;
  transition: all 0.4s ease-in-out;
  border-radius: 50px;
  overflow: hidden;
  max-width: 45px;
}

/* The white circle background from your image */
.icon-circle {
  width: 45px;
  height: 45px;
  background-color: #fff;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-shrink: 0;
}

.social-link i {
  font-size: 1.6rem;
  color: #000;
}

.icon-text {
  color: #fff;
  font-weight: 600;
  font-size: 0.9rem;
  padding-left: 0;
  opacity: 0;
  white-space: nowrap;
  transition: all 0.4s ease-in-out;
}

.social-link:hover {
  max-width: 150px;
  background-color: rgba(255, 255, 255, 0.1);
  padding-right: 15px;
}

.social-link:hover .icon-text {
  opacity: 1;
  padding-left: 10px;
}

.fb:hover .icon-circle i {
  color: #1877f2;
}

.github:hover .icon-circle i {
  color: #333;
}

.linkedin:hover .icon-circle i {
  color: #0077b5;
}

/* shop.jsp file css*/
#shop {
  margin-top: 5rem;
  margin-bottom: 5rem;
  padding: 5px;
}

#shop h3 {
  font-weight: normal;
  font-size: 1.6rem;
  margin-bottom: 5px;
  padding: 5px;
  text-align: center;
  font-family: poppins;
}

#shop p {
  font-size: 1rem;
  margin-bottom: 1rem;
  text-align: center;
  font-family: poppins;
}

.shop-container {
  text-align: left;
  padding: 20px;
}

.product-list {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: stretch;
  gap: 20px;
  flex-wrap: nowrap;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  overflow-x: auto;
  padding: 20px 0;
}

#shop .product-container {
  flex: 0 0 calc(25% - 20px);
  min-width: 250px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  border: 1px solid #eee;
  border-radius: 8px;
  padding: 20px;
  box-sizing: border-box;
  background: #fff;
  transition: 0.3s shadow;
}

#shop .product-container:hover .buy-btn {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

#shop .shop-container {
  margin-top: -15px;
}

.page {
  display: flex;
  align-items: center;
  background: #fff;
  color: #383838;
  padding: 10px 40px;
  border-radius: 6px;
}

#pagination .page ul {
  margin: 5px 0px;
  display: flex;
  list-style: none;
  padding: 0 5px;
  margin: 0;
}

#pagination .page ul li {
  display: inline-block;
  margin: 0 3px;
  background: #ccc;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  text-align: center;
  font-size: 22px;
  font-weight: 500;
  line-height: 32px;
  cursor: pointer;
  transition: 0.6s ease;
}

#pagination .page ul li:hover {
  color: #fff;
  background-color: rgb(239, 73, 100);
}

.link {
  width: 40px;
  height: 40px;
  line-height: 40px;
  text-align: center;
  margin: 0 5px;
  border-radius: 50%;
  cursor: pointer;
  transition: 0.3s;
  font-weight: bold;
}

.link.active {
  background-color: rgb(239, 73, 100);
  color: white;
}

.btn1,
.btn2 {
  display: inline-flex;
  align-items: center;
  font-size: 15px;
  font-weight: 500;
  color: #383838;
  background: transparent;
}

.btn1:hover,
.btn2:hover {
  background: #f0f0f0;
}
     .popup-overlay {
         position: fixed;
         inset: 0;
         background: rgba(0, 0, 0, 0.45);
         backdrop-filter: blur(3px);
         z-index: 9000;
         display: flex;
         align-items: center;
         justify-content: center;
         opacity: 0;
         visibility: hidden;
         transition: opacity 0.3s ease, visibility 0.3s ease;
     }

     .popup-overlay.show {
         opacity: 1;
         visibility: visible;
     }

     .popup-box {
         background: #fff;
         border-radius: 18px;
         padding: 40px 36px 32px 36px;
         max-width: 460px;
         width: 92%;
         position: relative;
         box-shadow: 0 24px 60px rgba(0, 0, 0, 0.18);
         transform: translateY(30px) scale(0.97);
         transition: transform 0.35s cubic-bezier(0.34, 1.56, 0.64, 1), opacity 0.3s ease;
         opacity: 0;
     }

     .popup-overlay.show .popup-box {
         transform: translateY(0) scale(1);
         opacity: 1;
     }

     .popup-close {
         position: absolute;
         top: 16px;
         right: 18px;
         background: none;
         border: none;
         font-size: 1.3rem;
         color: #aaa;
         cursor: pointer;
         padding: 4px 8px;
         transition: color 0.2s;
         line-height: 1;
     }

     .popup-close:hover {
         color: #333;
         background: none;
     }

     .popup-icon-wrap {
         display: flex;
         justify-content: center;
         margin-bottom: 18px;
     }

     .popup-icon {
         width: 64px;
         height: 64px;
         background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
         border-radius: 50%;
         display: flex;
         align-items: center;
         justify-content: center;
         box-shadow: 0 6px 20px rgba(243, 156, 18, 0.35);
         animation: popIcon 0.5s cubic-bezier(0.34, 1.56, 0.64, 1) 0.1s both;
     }

     @keyframes popIcon {
         from {
             transform: scale(0.4);
             opacity: 0;
         }
         to {
             transform: scale(1);
             opacity: 1;
         }
     }

     .popup-icon i {
         font-size: 2rem;
         color: #fff;
     }

     .popup-box h2 {
         text-align: center;
         font-size: 1.35rem;
         font-weight: 700;
         color: #1d1d1d;
         margin-bottom: 8px;
     }

     .popup-subtitle {
         text-align: center;
         font-size: 0.87rem;
         color: #888;
         margin-bottom: 22px;
     }

     .popup-details {
         background: #fafafa;
         border: 1px solid #f0f0f0;
         border-radius: 12px;
         padding: 16px 20px;
         margin-bottom: 22px;
     }

     .popup-details .detail-row {
         display: flex;
         justify-content: space-between;
         align-items: flex-start;
         font-size: 0.88rem;
         color: #555;
         padding: 5px 0;
         border-bottom: 1px solid #f0f0f0;
     }

     .popup-details .detail-row:last-child {
         border-bottom: none;
     }

     .popup-details .detail-row .label {
         color: #888;
         font-weight: 500;
         flex-shrink: 0;
         margin-right: 12px;
     }

     .popup-details .detail-row .value {
         font-weight: 600;
         color: #1d1d1d;
         text-align: right;
     }

     .popup-details .detail-row .value.price {
         color: #f39c12;
         font-size: 1rem;
     }

     .popup-shipping-note {
         text-align: center;
         font-size: 0.78rem;
         color: #aaa;
         margin-bottom: 24px;
         display: flex;
         align-items: center;
         justify-content: center;
         gap: 5px;
     }

     .popup-shipping-note i {
         color: #f39c12;
     }

     .popup-btns {
         display: flex;
         gap: 12px;
     }

     .popup-cancel {
         flex: 1;
         padding: 13px;
         background: #f4f4f4;
         color: #555;
         border: none;
         border-radius: 10px;
         font-size: 0.85rem;
         font-weight: 600;
         cursor: pointer;
         transition: background 0.2s;
         text-transform: uppercase;
         letter-spacing: 0.5px;
     }

     .popup-cancel:hover {
         background: #e8e8e8;
         color: #333;
     }

     .popup-proceed {
         flex: 2;
         padding: 13px;
         background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
         color: #fff;
         border: none;
         border-radius: 10px;
         font-size: 0.85rem;
         font-weight: 700;
         cursor: pointer;
         transition: all 0.2s;
         text-transform: uppercase;
         letter-spacing: 0.5px;
         box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
         display: flex;
         align-items: center;
         justify-content: center;
         gap: 7px;
     }

     .popup-proceed:hover {
         background: linear-gradient(135deg, #219a52 0%, #27ae60 100%);
         box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
         transform: translateY(-1px);
     }

     .popup-proceed i {
         font-size: 1rem;
     }
</style>

  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
</head>
<body>
 <jsp:include page="fragments/navbar.jsp"/>

  <section id="home">
    <div class="container" style="padding-left: 90px;">
      <h5>EXCLUSIVE OFFERS</h5>
      <h1><span>Best Deals</span> This Season</h1>
      <p>
        Fatafat Kin offers the most competitive prices on top-tier <br />
        electronics, fashion, and daily essentials.
      </p>
      <button>Shop Now</button>
    </div>
  </section>

  <section id="brand">
    <div class="row">
      <img src="${pageContext.request.contextPath}/static/images/brands/8.png" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/7.jpg" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/1.png" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/2.jpg" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/11.jpg" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/4.png" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/5.png" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/6.png" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/9.png" class="brand-logo" />
      <img src="${pageContext.request.contextPath}/static/images/brands/goldstar-logo.png" class="brand-logo" />
    </div>
  </section>

  <section id="new">
    <div class="product-container">
      <div class="one">
        <img class="img-fluid" src="${pageContext.request.contextPath}/static/images/featured/5.avif" alt="Rare Sneakers 1" />
        <div class="details">
          <h2 class="text-uppercase">Extreme Rare Sneakers</h2>
          <button>Shop Now</button>
        </div>
      </div>

      <div class="one">
        <img class="img-fluid" src="${pageContext.request.contextPath}/static/images/9.jpg" alt="Black Sneakers" />
        <div class="details">
          <h2 class="text-uppercase">Awesome Black Outfit</h2>
          <button>Shop Now</button>
        </div>
      </div>

      <div class="one">
        <img class="img-fluid" src="${pageContext.request.contextPath}/static/images/shoe/watch.png" alt="Rare Watch" />
        <div class="details">
          <h2 class="text-uppercase">Sport wear up to 50% off</h2>
          <button>Shop Now</button>
        </div>
      </div>
    </div>
  </section>

  <section id="featured">
    <div class="container">
      <h3>Top Picks for You</h3>
      <hr />
      <p>
        High-quality essentials at prices that make sense. Fresh stock has
        just landed at Fatafat Kin.
      </p>
    </div>

    <div class="product-list">
      <c:forEach var="product" items="${topPicks}" >
        <div class="product-container">
          <div class="img-box" style="width: 100%; height: 300px; object-fit:contain; object-position: center center;"
          >
              <%-- Dynamically link to single product page using product ID --%>
            <img onclick="window.location.href='singleProduct?id=${product.productId}';"
                 class="product-img"
                 src="images/${product.imagePath}"
                 alt="${product.name}">
          </div>

          <div class="star">
            <i class='bx bxs-star'></i><i class='bx bxs-star'></i>
            <i class='bx bxs-star'></i><i class='bx bxs-star'></i>
            <i class='bx bxs-star'></i>
          </div>

          <h5 class="p-name">${product.name}</h5>
          <h4 class="p-price">Rs ${product.price}</h4>

          <button class="buy-btn"
                  onclick="openPopup('${product.productId}','${product.name}', '${product.price}', '${product.imagePath}')">
            BUY NOW
          </button>
        </div>
      </c:forEach>

    </div>
  </section>

  <section id="banner">
    <div class="banner">
      <h4>MID SEASON'S SALE</h4>
      <h1>Autumn Collection<br /><span> Up to 25% OFF</span></h1>
      <p>
        Step into Spring with Style: Basanta Deals are Blooming <br />
        at FataFat Kin!
      </p>
      <button>Shop Now</button>
    </div>
  </section>

  <section id="featured">
    <div class="container">
      <h3>Refined Layers for Autumn Mornings.</h3>
      <hr />
      <p>Quick Fashion for a Fast Life – Grab your Mid-Season picks today!</p>
    </div>

    <div class="product-list">
      <c:forEach var="product" items="${products}" begin="0" end="3" >
        <div class="product-container">
          <div class="img-box" style="width: 100%; height: 300px; object-fit:contain; object-position: center center;"
          >
              <%-- Dynamically link to single product page using product ID --%>
            <img onclick="window.location.href='singleProduct?id=${product.productId}';"
                 class="product-img"
                 src="images/${product.imagePath}"
                 alt="${product.name}">
          </div>

          <div class="star">
            <i class='bx bxs-star'></i><i class='bx bxs-star'></i>
            <i class='bx bxs-star'></i><i class='bx bxs-star'></i>
            <i class='bx bxs-star'></i>
          </div>

          <h5 class="p-name">${product.name}</h5>
          <h4 class="p-price">Rs ${product.price}</h4>

          <button class="buy-btn"
                  onclick="openPopup('${product.productId}','${product.name}', '${product.price}', '${product.imagePath}')">
            BUY NOW
          </button>
        </div>
      </c:forEach>
    </div>

    <section id="watches">
      <div class="container">
        <h3>Track your Time in Luxury.</h3>
        <hr />
        <p>
          Instant Elegance on your Wrist – Shop the Mid-Season Watch Edit.
        </p>
      </div>

      <div class="product-list">
        <c:forEach var="product" items="${products}" begin="4" end="7" >
          <div class="product-container">
            <div class="img-box" style="width: 100%; height: 300px; object-fit:contain; object-position: center center;"
            >
                <%-- Dynamically link to single product page using product ID --%>
              <img onclick="window.location.href='singleProduct?id=${product.productId}';"
                   class="product-img"
                   src="images/${product.imagePath}"
                   alt="${product.name}">
            </div>

            <div class="star">
              <i class='bx bxs-star'></i><i class='bx bxs-star'></i>
              <i class='bx bxs-star'></i><i class='bx bxs-star'></i>
              <i class='bx bxs-star'></i>
            </div>

            <h5 class="p-name">${product.name}</h5>
            <h4 class="p-price">Rs ${product.price}</h4>

            <button class="buy-btn"
                    onclick="openPopup('${product.productId}','${product.name}', '${product.price}', '${product.imagePath}')">
              BUY NOW
            </button>
          </div>
        </c:forEach>
      </div>
    </section>

    <section id="shoes">
      <div class="container">
        <h3>Elite Performance</h3>
        <hr />
        <p>
          Quick styles for a fast-paced life. Grab your mid-season pairs
          today!
        </p>
      </div>

      <div class="product-list">
        <c:forEach var="product" items="${products}" begin="8" end="11" >
          <div class="product-container">
            <div class="img-box" style="width: 100%; height: 300px; object-fit:contain; object-position: center center;"
            >
                <%-- Dynamically link to single product page using product ID --%>
              <img onclick="window.location.href='singleProduct?id=${product.productId}';"
                   class="product-img"
                   src="images/${product.imagePath}"
                   alt="${product.name}">
            </div>

            <div class="star">
              <i class='bx bxs-star'></i><i class='bx bxs-star'></i>
              <i class='bx bxs-star'></i><i class='bx bxs-star'></i>
              <i class='bx bxs-star'></i>
            </div>

            <h5 class="p-name">${product.name}</h5>
            <h4 class="p-price">Rs ${product.price}</h4>

            <button class="buy-btn"
                    onclick="openPopup('${product.productId}','${product.name}', '${product.price}', '${product.imagePath}')">
              BUY NOW
            </button>
          </div>
        </c:forEach>
      </div>
    </section>
  </section>

  <footer class="footer">
    <div class="row">
      <div class="footer-one">
        <img src="${pageContext.request.contextPath}/static/images/download.png" alt="Logo" />
        <p>
          Shop the best of Nepal from the comfort of home and experience the
          joy of truly fast delivery with Fatafat Kin.
        </p>
      </div>

      <div class="footer-one">
        <h5>Featured</h5>
        <ul>
          <li><a href="#">men</a></li>
          <li><a href="#">women</a></li>
          <li><a href="#">boys</a></li>
          <li><a href="#">girls</a></li>
          <li><a href="#">new arrivals</a></li>
          <li><a href="#">shoes</a></li>
        </ul>
      </div>

      <div class="footer-one">
        <h5>Contact Us</h5>
        <div>
          <h6 class="text">ADDRESS</h6>
          <p>123 STREET NAME, CITY, US</p>
        </div>
        <div>
          <h6 class="text">PHONE</h6>
          <p>(123) 456-7890</p>
        </div>
        <div>
          <h6 class="text">EMAIL</h6>
          <p>MAIL@EXAMPLE.COM</p>
        </div>
      </div>

      <div class="footer-one">
        <h5>Instagram</h5>
        <div class="insta-grid">
          <img src="${pageContext.request.contextPath}/static/images/spring/download (2).jpg" />
          <img src="${pageContext.request.contextPath}/static/images/spring/download (3).jpg" />
          <img src="${pageContext.request.contextPath}/static/images/spring/images (2).jpg" />
          <img src="${pageContext.request.contextPath}/static/images/spring/images (1).jpg" />
          <img src="${pageContext.request.contextPath}/static/images/spring/download (4).jpg" />
        </div>
      </div>
    </div>
    <div class="payment">
      <div class="payment-img">
        <div class="image">
          <img src="${pageContext.request.contextPath}/static/images/spring/esewa.jpg" />
          <img src="${pageContext.request.contextPath}/static/images/spring/khalti.png" />
          <img src="${pageContext.request.contextPath}/static/images/spring/card.png" />
        </div>

        <div class="image">
          <p>© 2026 Fatafat Kin. All Rights Reserved</p>
        </div>

        <div class="social-icons">
          <a href="#" class="social-link fb">
            <div class="icon-circle">
              <i class="bx bxl-facebook-circle"></i>
            </div>
            <span class="icon-text">Facebook</span>
          </a>

          <a href="#" class="social-link github">
            <div class="icon-circle">
              <i class="bx bxl-github"></i>
            </div>
            <span class="icon-text">GitHub</span>
          </a>

          <a href="#" class="social-link linkedin">
            <div class="icon-circle">
              <i class="bx bxl-linkedin-square"></i>
            </div>
            <span class="icon-text">LinkedIn</span>
          </a>
        </div>
      </div>
    </div>
  </footer>


 <div class="popup-overlay" id="popupOverlay" onclick="handleOverlayClick(event)">
   <div class="popup-box" id="popupBox">
     <button class="popup-close" onclick="closePopup()">✕</button>
     <div class="popup-icon-wrap">
       <div class="popup-icon"><i class='bx bx-check'></i></div>
     </div>
     <h2>Buy Now Confirmed</h2>
     <p class="popup-subtitle">You have selected immediate checkout for:</p>
     <form action="${pageContext.request.contextPath}/orders" method="post" class="popup-details">
       <div class="detail-row">
         <input hidden name="action" value="buy-now" style="border: none" class="value" ></input>
       </div>
       <div class="detail-row">
         <span class="label">Id</span>
         <input name="id"  style="border: none" class="value" id="popupItemId"></input>
       </div>
       <div class="detail-row">
         <span class="label">Item</span>
         <input  style="border: none" class="value" id="popupItemName"></input>
       </div>
       <div class="detail-row">
         <span class="label">Quantity</span>
         <input name="quantity"  style="border: none" class="value">1</input>
       </div>
       <div class="detail-row">
         <span class="label">Item Subtotal</span>
         <input name="subTotal" class="value price" id="popupItemPrice"></input>
       </div>
       <p class="popup-shipping-note">
         <i class='bx bx-info-circle'></i>
         Shipping fee of Rs. 150 will be applied at payment
       </p>
       <div class="popup-btns">
         <button class="popup-cancel" onclick="closePopup()">CANCEL</button>
         <button class="popup-proceed" type="submit">
           <i class='bx bx-credit-card'></i>
           PROCEED TO PAYMENT
         </button>
       </div>
     </form>
   </div>
 </div>



<script>
 let currentProductImg = '';

    document.querySelectorAll('.category-sidebar a').forEach(link => {
      link.addEventListener('click', function (e) {
        document.querySelectorAll('.category-sidebar a').forEach(l => l.classList.remove('active'));
        this.classList.add('active');
      });
    });

    function toggleCatMore() {
      const moreLinks = document.getElementById('catMoreLinks');
      const btn = document.getElementById('catShowMoreBtn');
      const btnText = document.getElementById('catMoreBtnText');
      const icon = document.getElementById('catMoreBtnIcon');
      const isVisible = moreLinks.classList.contains('visible');
      if (isVisible) {
        moreLinks.classList.remove('visible');
        btnText.textContent = 'Show More';
        btn.classList.remove('open');
      } else {
        moreLinks.classList.add('visible');
        btnText.textContent = 'Show Less';
        btn.classList.add('open');
      }
    }

    function activeLink(event) {
      document.querySelectorAll('#pagination .link').forEach(li => li.classList.remove('active'));
      event.currentTarget.classList.add('active');
    }

    const categoryBtn = document.getElementById('category-btn');
    const shortcutLinks = document.querySelector('.shortcut-links');
    if (categoryBtn && shortcutLinks) {
      categoryBtn.addEventListener('click', function (e) {
        e.preventDefault();
        shortcutLinks.classList.toggle('active');
      });
      document.addEventListener('click', function (e) {
        if (!categoryBtn.contains(e.target) && !shortcutLinks.contains(e.target)) {
          shortcutLinks.classList.remove('active');
        }
      });
    }

    const showMoreBtn = document.getElementById('showMoreBtn');
    const moreLinksNav = document.querySelector('.more-links');
    if (showMoreBtn && moreLinksNav) {
      moreLinksNav.style.display = 'none';
      showMoreBtn.addEventListener('click', function (e) {
        e.preventDefault();
        const isHidden = moreLinksNav.style.display === 'none';
        moreLinksNav.style.display = isHidden ? 'block' : 'none';
        showMoreBtn.textContent = isHidden ? 'Show Less' : 'Show More';
      });
    }

    function openPopup(itemId, itemName, itemPrice, imgSrc) {
      document.getElementById('popupItemId').value = itemId;
      document.getElementById('popupItemName').value = itemName;
      document.getElementById('popupItemPrice').value = itemPrice;
      currentProductImg = imgSrc || '';
      document.getElementById('popupOverlay').classList.add('show');
      document.body.style.overflow = 'hidden';
    }

    function closePopup() {
      document.getElementById('popupOverlay').classList.remove('show');
      document.body.style.overflow = '';
    }

    function handleOverlayClick(e) {
      if (e.target === document.getElementById('popupOverlay')) closePopup();
    }

    function proceedToPayment() {
      const name = document.getElementById('popupItemName').textContent;
      const price = document.getElementById('popupItemPrice').textContent;
      let orders = JSON.parse(localStorage.getItem('orders')) || [];
      orders.push({
        name: name,
        price: price.replace('Rs ', '').replace(',', ''),
        img: currentProductImg,
        status: 'Pending'
      });
      localStorage.setItem('orders', JSON.stringify(orders));
      closePopup();
      window.location.href = 'cart.jsp';
    }

    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') closePopup();
    });
</script>
</body>

</html>