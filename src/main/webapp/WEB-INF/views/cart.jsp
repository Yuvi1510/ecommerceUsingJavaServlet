<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>test - Shopping Cart</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/cart.css" />
  <style>
    .quantity-btn:hover {
      background-color: #f39c12;
      /* Changes background to orange */
      color: #fff;
      /* Optional: Changes text to white for better contrast */
    }

    .quantity-input {
      width: 40px;
      text-align: center;
      border: none;
      border-left: 1px solid #ddd;
      border-right: 1px solid #ddd;
      padding: 10px 0;
      font-size: 16px;
    }

    .action-group {
      display: flex !important;
      flex-direction: row;
      align-items: center;
      gap: 12px;
      white-space: nowrap;
      justify-content: flex-start;
    }

    .cart-table td:last-child {
      width: 1%;
      min-width: 160px;
      white-space: nowrap;
    }

    .buy-now-item-btn {
      margin: 0;
      display: inline-block;
    }

    .remove-btn {
      background: none;
      border: none;
      color: #e74c3c;
      cursor: pointer;
      font-size: 20px;
      display: flex;
      align-items: center;
      padding: 0;
      transition: color 0.3s ease;
    }

    .cart-table td:last-child {
      min-width: 150px;
    }

    /* Hover: Remove icon turns orange */
    .remove-btn:hover {
      background-color: #fff;

    }
  </style>
</head>

<body>

<!-- ===== NAVBAR ===== -->
<jsp:include page="fragments/navbar.jsp"/>


  <section class="shop">
    <div class="cart-container" id="cartRoot">
      <div class="cart-header">
        <h3>Shopping Carts</h3>
        <p id="itemCountDisplay">
          ${cartItems.size()} Items in your cart
        </p>
      </div>
      <table class="cart-table">
        <thead>
          <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody id="cartTableBody">

        <c:choose>

          <c:when test="${not empty cartItems}">

            <c:forEach var="item" items="${cartItems}">

              <tr class="cart-item" data-price="${item.price}">

                <td>
                  <div class="cart-item-info">

                    <img
                            src="${pageContext.request.contextPath}/images/${item.imagePath}"
                            alt="${item.name}"
                            class="cart-item-image"
                    />

                    <div class="cart-item-details">
                      <h4>${item.name}</h4>
                      <p>${item.description}</p>
                    </div>

                  </div>
                </td>

                <td class="item-price-display">
                  Rs. ${item.price}
                </td>

                <td>
                  <div class="quantity-control">

                    <button
                            class="quantity-btn minus"
                            data-cart-item-id="${item.cartItemId}">
                      -
                    </button>

                    <input
                            type="text"
                            value="${item.totalItems}"
                            class="quantity-input"
                            readonly
                    />

                    <button
                            class="quantity-btn plus"
                            data-cart-item-id="${item.cartItemId}">
                      +
                    </button>

                  </div>
                </td>

                <td class="item-subtotal-display">
                  Rs. ${item.totalPrice}
                </td>

                <td>

                  <div class="action-group">

                    <form
                            action="${pageContext.request.contextPath}/remove-cart-item"
                            method="post"
                    >

                      <input
                              type="hidden"
                              name="cartItemId"
                              value="${item.cartItemId}"
                      />

                      <button class="remove-btn" type="submit">
                        <i class="bx bx-trash"></i>
                      </button>

                    </form>

                    <button class="buy-now-item-btn">
                      BUY NOW
                    </button>

                  </div>

                </td>

              </tr>

            </c:forEach>

          </c:when>

          <c:otherwise>

            <tr>
              <td colspan="5" style="text-align:center; padding: 30px;">
                Your cart is empty
              </td>
            </tr>

          </c:otherwise>

        </c:choose>

        </tbody>
      </table>
      <c:set var="subtotal" value="${0}" />

      <c:forEach var="item" items="${cartItems}">
        <c:set var="subtotal" value="${subtotal + item.totalPrice}" />
      </c:forEach>

      <c:set var="shippingFee" value="${subtotal > 0 ? 150 : 0}" />

      <c:set var="total" value="${subtotal + shippingFee}" />

      <div class="cart-summary">

        <div class="summary-box">

          <div class="summary-row">
            <span>Subtotal</span>

            <span id="cartSubtotalDisplay">
                Rs. ${subtotal}
            </span>
          </div>

          <div class="summary-row">
            <span>Shipping Fee</span>

            <span id="shippingFeeDisplay">
                Rs. ${shippingFee}
            </span>
          </div>

          <div class="summary-row total">
            <span>Total</span>

            <span id="cartTotalDisplay">
                Rs. ${total}
            </span>
          </div>

          <button class="checkout-btn" id="proceedCheckoutBtn">
            Proceed to Checkout
          </button>

        </div>

      </div>
  </section>

  <div class="modal-overlay" id="buyNowModal">
    <div class="modal-content">
      <span class="close-modal">&times;</span>
      <div class="modal-header">
        <i class="bx bx-check-circle"></i>
        <h3>Buy Now Confirmed</h3>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer">
        <button class="modal-btn btn-cancel">Cancel</button>
        <button class="modal-btn btn-confirm-checkout">Proceed to Payment</button>
      </div>
    </div>
  </div>

  <div class="modal-overlay" id="cartCheckoutModal">
    <div class="modal-content">
      <span class="close-modal">&times;</span>
      <div class="modal-header">
        <i class="bx bx-shopping-bag"></i>
        <h3>Secure Checkout</h3>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer">
        <button onclick="window.location.href = 'shop.html'" class="modal-btn btn-cancel">Continue Shopping</button>
        <form action="${pageContext.request.contextPath}/order" method="post">
          <input hidden name="action" value="create">
          <button type="submit" style="padding: 10px 20px; border-radius: 5px; background-color: #20cf20">Confirm and Pay</button>
        </form>
      </div>
    </div>
  </div>

  <div class="modal-overlay" id="deleteConfirmModal">
    <div class="modal-content">
      <span class="close-modal">&times;</span>
      <div class="modal-header">
        <i class="bx bx-trash"></i>
        <h3>Remove Item?</h3>
      </div>
      <div class="modal-body">
        <p>Are you sure you want to remove <strong id="deleteItemName">this item</strong> from your cart?</p>
        <p>This action cannot be undone.</p>
      </div>
      <div class="modal-footer">
        <button class="modal-btn btn-cancel">Cancel</button>
        <button class="modal-btn btn-confirm-delete" id="confirmDeleteBtn">Remove Item</button>
      </div>
    </div>
  </div>


<!-- ===== FOOTER  ===== -->
<jsp:include page="fragments/footer.jsp"/>

  <script src="${pageContext.request.contextPath}/static/js/user/cart.js"></script>
</body>

</html>