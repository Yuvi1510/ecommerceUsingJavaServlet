<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>FataFat Kin</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/shop.css">

      <style>
          /* Global Reset for Page Typography and Layout */
          body {
              font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
              margin: 0;
              padding: 0;
              background-color: #ffffff;
              color: #333333;
          }


          .single-product {
              max-width: 1200px;
              margin: 0 auto;
              padding: 40px 20px;
              display: flex;
              justify-content: space-between;
              align-items: flex-start; /* Fixes vertical stretching issues */
              gap: 50px;
          }


          .single-row {
              flex: 0 0 450px;
              display: flex;
              flex-direction: column;
              gap: 12px;
          }

          /* Big Image Screen/Box Layout */  .single-image {
              background-color: #f9f9f9;
              border: 1px solid #eaeaea;
              border-radius: 8px;
              width: 100%;
              height: 500px;
              display: flex;
              align-items: center;
              justify-content: center;
              overflow: hidden;
          }

          .single-image img {
              max-width: 90%;
              max-height: 90%;
              object-fit: contain; /* Prevents image distortion */
              display: block;
          }


          .small-image-group {
              display: flex;
              justify-content: space-between;
              width: 100%;
              gap: 8px;
          }


          .small-img-column {
              flex: 1;
              height: 100px;
              background-color: #f9f9f9;
              border: 1px solid #eaeaea;
              border-radius: 4px;
              cursor: pointer;
              display: flex;
              align-items: center;
              justify-content: center;
              overflow: hidden;
          }

          .small-img-column img {
              max-width: 100%;
              max-height: 100%;
              object-fit: contain;
              transition: opacity 0.2s ease-in-out;
          }

          .small-img-column img:hover {
              opacity: 0.7;
          }


          .description {
              flex: 1; /*it consumes the width of row automativally*/
              display: flex;
              flex-direction: column;
          }


          .description h6 {
              font-size: 1.8rem;
              font-weight: 700;
              margin: 0 0 10px 0;
              color: #222222;
              line-height: 1.2;
          }

          .description h2 {
              font-size: 1.6rem;
              font-weight: 600;
              color: #ff523b; /* Accent Coral color */
              margin: 0 0 20px 0;
          }

          .description h4 {
              font-size: 1.2rem;
              font-weight: 600;
              margin: 30px 0 10px 0;
              color: #333333;
              border-bottom: 2px solid #f4f4f4;
              padding-bottom: 8px;
          }

          .description p {
              font-size: 1rem;
              line-height: 1.6;
              color: #666666;
              margin: 0;
          }

          /* Interactive Form Components of shopping */
          .description form {
              display: flex;
              align-items: center;
              gap: 12px;
              margin-bottom: 10px;
          }

          .number {
              width: 60px;
              height: 40px;
              padding: 5px;
              border: 1px solid #cccccc;
              border-radius: 4px;
              text-align: center;
              font-size: 1rem;
              font-weight: 600;
              box-sizing: border-box;
          }

          .number:focus {
              border-color: #ff523b;
              outline: none;
          }

          .description .btn {
              height: 40px;
              padding: 0 24px;
              border-radius: 4px;
              background-color: #ff523b;
              color: #ffffff;
              font-size: 0.95rem;
              font-weight: 700;
              border: none;
              text-transform: uppercase;
              letter-spacing: 0.5px;
              cursor: pointer;
              transition: background-color 0.2s ease, transform 0.1s ease;
          }

          .description .btn:hover {
              background-color: #e0442f;
          }

          .description .btn:active {
              transform: scale(0.98);
          }

          /* Platform Notification Popups Architecture */
          .popup {
              position: fixed;
              top: 20px;
              right: -350px;
              background-color: #28a745;
              color: white;
              padding: 15px 25px;
              border-radius: 5px;
              z-index: 9999;
              transition: all 0.5s ease;
              opacity: 0;
              visibility: hidden;
          }

          .popup.show {
              right: 20px;
              opacity: 1;
              visibility: visible;
          }

          .popup-content {
              display: flex;
              align-items: center;
              gap: 10px;
              font-weight: bold;
          }

          /* Header Navbar Cart Item Track Badge Component */
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
              visibility: hidden;
          }

          #cart-count.show {
              visibility: visible;
          }

          /* Buy Now Checkout Overlay Panels */
          .popup-overlay {
              position: fixed;
              top: 0;
              left: 0;
              width: 100%;
              height: 100%;
              background-color: rgba(0, 0, 0, 0.5);
              display: flex;
              align-items: center;
              justify-content: center;
              z-index: 10000;
              opacity: 0;
              visibility: hidden;
              transition: opacity 0.3s ease, visibility 0.3s ease;
          }

          .popup-overlay.show {
              opacity: 1;
              visibility: visible;
          }

          .popup-box {
              background-color: #ffffff;
              padding: 30px;
              border-radius: 8px;
              width: 100%;
              max-width: 450px;
              box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
              position: relative;
              box-sizing: border-box;
          }

          /* Overlay Utility Fields Formatting */
          .detail-row {
              display: flex;
              justify-content: space-between;
              align-items: center;
              margin-bottom: 12px;
          }

          .detail-row .value {
              font-weight: 600;
              text-align: right;
              border: none;
              background: transparent;
          }
      </style>
</head>
<body style="display: flex; flex-direction: column;">

<jsp:include page="fragments/navbar.jsp"/>

<div style="padding-top: 140px;">
    <!-- Success/Error Messages -->
    <c:if test="${not empty success}">
        <div id="successMessage" style="display:flex; justify-content: space-between; background: #d1fae5; padding: 12px; border-radius: 10px; margin: 10px 0; color: #065f46; font-weight: 500; max-width: 600px; margin:auto;">
                ${success}
            <button onclick="document.getElementById('successMessage').style.display='none'" style="padding: 2px 5px; background: none; border: none; font-size: 18px; cursor: pointer; color: #065f46;">✕</button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div id="errorMessage" style="display:flex; justify-content: space-between; background: #fee2e2; padding: 12px; border-radius: 10px; margin: 10px 0; color: #991b1b; font-weight: 500;">
                ${error}
            <button onclick="document.getElementById('errorMessage').style.display='none'" style="padding: 2px 5px; background: none; border: none; font-size: 18px; cursor: pointer; color: #991b1b;">✕</button>
        </div>
    </c:if>

    <section class="single-product" >

        <div class="single-row">
            <div class="single-image" style="overflow: hidden;">
                <img src="${pageContext.request.contextPath}/images/${product.imagePath}" id="MainImg" />
            </div>
        </div>

        <div class="description">
            <h6>${product.name}</h6>
            <%--        <h3>${product.description}</h3>--%>
            <h2>Rs ${product.price}</h2>
            <div>

                <form action="${pageContext.request.contextPath}/cart" method="post">
                <input class="number" type="number" name="quantity" value="1">
                    <input hidden name="action" value="add">
                    <input hidden name="productId" value="${product.productId}">
                    <button type="submit" class="btn">Add TO Cart</button>
                </form>

                <h4>Product Details</h4>
                <p>${product.description}</p>

            </div>
            <%--       <div id="cart-popup" class="popup">--%>
            <%--    <div class="popup-content">--%>
            <%--        <i class='bx bx-check-circle'></i>--%>
            <%--        <p>Item added to cart successfully!</p>--%>
            <%--    </div>--%>
            <%--</div>--%>
        </div>
    </section>
</div>

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
                <input hidden name="action" value="create" style="border: none" class="value" ></input>
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


<script src="${pageContext.request.contextPath}/static/js/user/single.js"></script>
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
