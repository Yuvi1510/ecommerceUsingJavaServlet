<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Shop FataFat Kin</title>
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<%--  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">--%>
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
        <div>
            <a href="${pageContext.request.contextPath}/shop">All</a>
            <c:forEach var="category" items="${categories}">
            <a href="${pageContext.request.contextPath}/shop?action=findProductsByCategory&category=${category.categoryId}">${category.name}</a>
            </c:forEach>
        </div>
      </aside>

      <!-- SCROLLABLE PRODUCTS AREA -->
      <div class="shop-products-area" >


        <!-- SCROLLABLE PRODUCTS AREA -->
        <div class="shop-products-area">
          <div class="product-list">

            <%-- Iterates through the 'products' list, starting at index 0 and stopping at index 3 (4 items total) --%>
            <c:forEach var="product" items="${products}" begin="0" end="3">
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
        </div>
      </div>
      </div>
  </section>

  <!-- ===== FOOTER  ===== -->
 <jsp:include page="fragments/footer.jsp"/>


  <div class="popup-overlay" id="popupOverlay" onclick="handleOverlayClick(event)">
    <div class="popup-box" id="popupBox">
      <button class="popup-close" onclick="closePopup()">✕</button>
      <div class="popup-icon-wrap">
        <div class="popup-icon"><i class='bx bx-check'></i></div>
      </div>
      <h2>Buy Now Confirmed</h2>
      <p class="popup-subtitle">You have selected immediate checkout for:</p>
      <form action="${pageContext.request.contextPath}/order" method="post" class="popup-details">
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


  <script src="${pageContext.request.contextPath}/static/js/user/shop.js"></script>
<script>
  const closeMessage = (id) =>{
    const element = document.getElementById(id);
    if (element) {
      element.style.display = "none";
    }
  }
</script>
</body>

</html>