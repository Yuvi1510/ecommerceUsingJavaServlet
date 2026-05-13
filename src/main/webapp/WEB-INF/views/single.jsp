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
.single-product {
    padding: 60px 0 60px 20px; 
    display: flex;
    justify-content: flex-start;
    margin-left:  90px;
}

/* main display ra small image ko size milaune */
.single-row {
    display: flex;
    flex-direction: column;
    width: 400px; 
    gap: 8px;    
}
/* Big Image Container */
.single-image {
    background-color: #f4f4f4; 
    width: 100%;
    height: 450px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.single-image img {
    width: 85%; 
    height: auto;
    object-fit: contain;
}

/* fixing small image row */
.small-image-group {
    display: flex;
    justify-content: space-between; 
    width: 100%;
}

/* Individual Thumbnail Boxes */
.small-img-column {
    flex-basis: 24%; /* adding gaps between images */
    background-color: #f4f4f4;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}

.small-img-column img {
    width: 100%;
    display: block;
    transition: 0.3s;
}

.small-img-column img:hover {
    opacity: 0.7;
}

.description{
  margin-left: 110px;
}

.number{
width: 50px;
margin: 5px 10px;
padding: 5px;
border: 2px solid #000;
}

.description .btn{
  padding: 5px 10px;
  border-radius: 5px;
  background: coral;
  transform: scale(1.1);
}
.description h3{
    color: #b8a8a8;
    font-weight: normal;
}
.description h4{
  margin-top: 3rem;
  font-size: 1.3rem;
}

.description p{
  margin-top: 1.5rem;

}
.shop-container {
    text-align: center;     
    margin: 40px auto;       
    max-width: 1200px;      
}
h6{
  font-size: 1.3rem;
}

.shop-container h3 {
    font-size: 24px;
    margin-bottom: 10px;
    margin-top: -140px;
    color: #333;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.shop-container hr {
    border: none;
    height: 3px;
    background-color: #ff523b; 
    width: 80px;               
    margin: 0 auto;      
}    

.product-list{
  margin-top: -115px;
}

.popup {
    position: fixed;
    top: 20px;
    right: -350px; /* Moves it completely off-screen */
    background-color: #28a745;
    color: white;
    padding: 15px 25px;
    border-radius: 5px;
    z-index: 9999; /* Ensure it is above everything else */
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
    font-family: sans-serif;
    font-weight: bold;
}

.popup-content i {
    font-size: 24px;
}
 </style>
</head>
<body style="display: flex; flex-direction: column;">

<jsp:include page="fragments/navbar.jsp"/>

<section class=
                 "single-product" style="padding-top: 140px;">

    <c:if test="${not empty success}">
        <div id="successMessage" style="display: flex; background-color: #7af67c; color: white">
                ${success}

            <button

                    onclick="closeMessage('successMessage')"
                    style="color: red; padding:0 5px">
                X
            </button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div id="errorMessage" style="display: flex; background-color: #f85656; color: white">
                ${error}

            <button

                    onclick="closeMessage('errorMessage')"
                    style="color: black; padding:0 5px">
                X
            </button>
        </div>
    </c:if>

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
        <input class="number" type="number" name="quantity" value="1">

            <form action="${pageContext.request.contextPath}/cart" method="post">
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


<script src="${pageContext.request.contextPath}/static/js/user/shop.js"></script>

   <script>
       const closeMessage = (id) =>{
           const element = document.getElementById(id);
           if (element) {
               element.style.display = "none";
           }
       }
    //Grab the big image by its ID
    var MainImg = document.getElementById("MainImg");
    
    // Grab all the small images into a list (array)
    var smallimg = document.getElementsByClassName("small-img");

    // Set up the click function for each small image
    smallimg[0].onclick = function() { MainImg.src = smallimg[0].src; };
    smallimg[1].onclick = function() { MainImg.src = smallimg[1].src; };
    smallimg[2].onclick = function() { MainImg.src = smallimg[2].src; };
    smallimg[3].onclick = function() { MainImg.src = smallimg[3].src; };

 
    // Gallery Swap Logic
    var MainImg = document.getElementById("MainImg");
    var smallimg = document.getElementsByClassName("small-img");

    for (let i = 0; i < smallimg.length; i++) {
        smallimg[i].onclick = function() {
            MainImg.src = smallimg[i].src;
        };
    }

    // Popup Logic
    const addToCartBtn = document.querySelector('.description .btn');
    const cartPopup = document.getElementById('cart-popup');

    addToCartBtn.onclick = function() {
        // Force show
        cartPopup.classList.add('show');
        console.log("Popup shown"); 
        // Hide after 3 seconds
        setTimeout(function() {
            cartPopup.classList.remove('show');
            console.log("Popup hidden");
        }, 3000);
    };

</script>
</body>
</html>
