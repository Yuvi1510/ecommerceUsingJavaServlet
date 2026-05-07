<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shop FataFat Kin</title>
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/shop.css">
</head>

<body>

  <!-- ===== NAVBAR ===== -->
  <jsp:include page="fragments/navbar.jsp"/>


  <!-- ===== SHOP SECTION (products only — no footer inside) ===== -->
  <section id="shop">
    <div class="shop-container">
      <h3>Products</h3>
      <hr class="divider">
      <p>Find the best and most compatible products for you</p>
    </div>

    <div class="shop-layout">

      <!-- FIXED CATEGORY SIDEBAR -->
      <aside class="category-sidebar">
        <div class="cat-title">Categories</div>
        <a href="${pageContext.request.contextPath}/shop">All</a>
        <c:forEach var="category" items="${categories}">
        <a href="${pageContext.request.contextPath}/shop?action=findByCategory&categoryId=${category.categoryId}">${category.name}</a>
        </c:forEach>
        </div>
      </aside>

      <!-- SCROLLABLE PRODUCTS AREA -->
      <div class="shop-products-area" >

<%--        <div class="product-list">--%>
<%--          <div class="product-container">--%>
<%--            <div class="img-box">--%>
<%--              <img onclick="window.location.href='single1.html';" class="product-img" src="images/boy/31.png" alt="">--%>
<%--            </div>--%>
<%--            <div class="star"><i class='bx bxs-star'></i><i class='bx bxs-star'></i><i class='bx bxs-star'></i><i--%>
<%--                class='bx bxs-star'></i><i class='bx bxs-star'></i></div>--%>
<%--            <h5 class="p-name">Men's Waffle Knit Short Sleeve Button-Down Casual Shirt</h5>--%>
<%--            <h4 class="p-price">Rs 1500</h4>--%>
<%--            <button class="buy-btn"--%>
<%--              onclick="openPopup('Men\'s Waffle Knit Short Sleeve Button-Down Casual Shirt', 'Rs 1,500', 'images/boy/31.png')">BUY--%>
<%--              NOW</button>--%>
<%--          </div>--%>
<%--        </div>--%>

  <!-- SCROLLABLE PRODUCTS AREA -->
  <div class="shop-products-area">
    <div class="product-list">

      <%-- Iterates through the 'products' list, starting at index 0 and stopping at index 3 (4 items total) --%>
      <c:forEach var="product" items="${products}" begin="0" end="3">
        <div class="product-container">
          <div class="img-box">
              <%-- Dynamically link to single product page using product ID --%>
            <img onclick="window.location.href='singleProduct?id=${product.productId}';"
                 class="product-img"
<%--                 src="${product.imagePath}"--%>
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
                  onclick="openPopup('${product.name}', 'Rs ${product.price}', '${product.imagePath}')">
            BUY NOW
          </button>
        </div>
      </c:forEach>

    </div>
  </div>


      </div>
  </section>

  <!-- ===== PAGINATION (outside #shop so it scrolls with body) ===== -->
  <section id="pagination">
    <div class="page">
      <button class="btn1"><i class='bx bx-left-arrow-alt'></i>prev</button>
      <ul>
        <a href="#">
          <li class="link active" onclick="activeLink(event)">1</li>
        </a>
        <a href="#">
          <li class="link" onclick="activeLink(event)">2</li>
        </a>
        <a href="#">
          <li class="link" onclick="activeLink(event)">3</li>
        </a>
        <a href="#">
          <li class="link" onclick="activeLink(event)">4</li>
        </a>
        <a href="#">
          <li class="link" onclick="activeLink(event)">5</li>
        </a>
        <a href="#">
          <li class="link" onclick="activeLink(event)">6</li>
        </a>
      </ul>
      <button class="btn2">next<i class='bx bx-right-arrow-alt'></i></button>
    </div>
  </section>

  <!-- ===== FOOTER  ===== -->
  <footer class="footer">
    <div class="row">
      <div class="footer-one">
        <img src="images/download.png" alt="Logo">
        <p>Shop the best of Nepal from the comfort of home and experience the joy of truly fast delivery with Fatafat
          Kin.</p>
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
          <p>123 Street Name, City, US</p>
        </div>
        <div>
          <h6 class="text">PHONE</h6>
          <p>(123) 456-7890</p>
        </div>
        <div>
          <h6 class="text">EMAIL</h6>
          <p>mail@example.com</p>
        </div>
      </div>
      <div class="footer-one">
        <h5>Instagram</h5>
        <div class="insta-grid">
          <img src="images/spring/download (2).jpg">
          <img src="images/spring/download (3).jpg">
          <img src="images/spring/images (2).jpg">
          <img src="images/spring/images (1).jpg">
          <img src="images/spring/download (4).jpg">
        </div>
      </div>
    </div>
    <div class="payment">
      <div class="payment-img">
        <div class="image">
          <img src="images/spring/esewa.jpg">
          <img src="images/spring/khalti.png">
          <img src="images/spring/card.png">
        </div>
        <div class="image">
          <p style="color:#9a9a9a;font-size:0.85rem;">© 2026 Fatafat Kin. All Rights Reserved</p>
        </div>
        <div class="social-icons">
          <a href="#" class="social-link fb">
            <div class="icon-circle"><i class='bx bxl-facebook-circle'></i></div><span class="icon-text">Facebook</span>
          </a>
          <a href="#" class="social-link github">
            <div class="icon-circle"><i class='bx bxl-github'></i></div>
            <span class="icon-text">GitHub</span>
          </a>
          <a href="#" class="social-link linkedin">
            <div class="icon-circle"><i class='bx bxl-linkedin-square'></i></div>
            <span class="icon-text">LinkedIn</span>
          </a>
        </div>
      </div>
    </div>
  </footer>

  <!-- ===== POPUP ===== -->
  <div class="popup-overlay" id="popupOverlay" onclick="handleOverlayClick(event)">
    <div class="popup-box" id="popupBox">
      <button class="popup-close" onclick="closePopup()">✕</button>
      <div class="popup-icon-wrap">
        <div class="popup-icon"><i class='bx bx-check'></i></div>
      </div>
      <h2>Buy Now Confirmed</h2>
      <p class="popup-subtitle">You have selected immediate checkout for:</p>
      <div class="popup-details">
        <div class="detail-row">
          <span class="label">Item</span>
          <span class="value" id="popupItemName">–</span>
        </div>
        <div class="detail-row">
          <span class="label">Quantity</span>
          <span class="value">1</span>
        </div>
        <div class="detail-row">
          <span class="label">Item Subtotal</span>
          <span class="value price" id="popupItemPrice">–</span>
        </div>
      </div>
      <p class="popup-shipping-note">
        <i class='bx bx-info-circle'></i>
        Shipping fee of Rs. 150 will be applied at payment
      </p>
      <div class="popup-btns">
        <button class="popup-cancel" onclick="closePopup()">CANCEL</button>
        <button class="popup-proceed" onclick="proceedToPayment()">
          <i class='bx bx-credit-card'></i>
          PROCEED TO PAYMENT
        </button>
      </div>
    </div>
  </div>

 <script src="Js/shop.js"></script>
</body>

</html>