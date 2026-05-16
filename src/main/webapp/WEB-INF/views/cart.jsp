Here is the complete JSP code with the new update quantity modal and logic integrated.
```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Shopping Cart</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/cart.css" />
  <style>
    .quantity-btn:hover {
      background-color: #f39c12;
      color: #fff;
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

    .remove-btn:hover {
      background-color: #fff;
    }

    /* Modal Styles */
    .modal-overlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 1000;
      justify-content: center;
      align-items: center;
    }

    .modal-overlay.show {
      display: flex;
    }

    .modal-content {
      background-color: white;
      border-radius: 10px;
      width: 90%;
      max-width: 500px;
      position: relative;
    }

    .modal-header {
      padding: 20px;
      border-bottom: 1px solid #eee;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .modal-header i {
      font-size: 24px;
      color: #e74c3c;
    }

    .modal-header h3 {
      margin: 0;
      color: #333;
    }

    .modal-body {
      padding: 20px;
    }

    .modal-footer {
      padding: 20px;
      border-top: 1px solid #eee;
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }

    .close-modal {
      position: absolute;
      right: 20px;
      top: 15px;
      font-size: 28px;
      cursor: pointer;
      color: #999;
    }

    .close-modal:hover {
      color: #333;
    }

    .modal-btn {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
    }

    .btn-cancel {
      background-color: #e0e0e0;
      color: #333;
    }

    .btn-cancel:hover {
      background-color: #d0d0d0;
    }

    .btn-confirm-delete {
      background-color: #e74c3c;
      color: white;
    }

    .btn-confirm-delete:hover {
      background-color: #c0392b;
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
                  <button class="quantity-btn minus">
                    -
                  </button>
                  <input
                          type="text"
                          value="${item.totalItems}"
                          class="quantity-input"
                          readonly
                  />
                  <button class="quantity-btn plus">
                    +
                  </button>
                </div>
              </td>

              <td class="item-subtotal-display">
                Rs. ${item.totalPrice}
              </td>

              <td>
                <div class="action-group">
                  <button class="remove-btn" data-cart-item-id="${item.cartItemId}">
                    <i class="bx bx-trash"></i>
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
  </div>
</section>

<!-- Buy Now Modal -->
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

<!-- Cart Checkout Modal -->
<div class="modal-overlay" id="cartCheckoutModal">
  <div class="modal-content">
    <span class="close-modal">&times;</span>
    <div class="modal-header">
      <i class="bx bx-shopping-bag"></i>
      <h3>Secure Checkout</h3>
    </div>
    <div class="modal-body"></div>
    <div class="modal-footer">
      <button class="modal-btn btn-cancel">Continue Shopping</button>
      <form action="${pageContext.request.contextPath}/orders" method="post">
        <input type="hidden" name="action" value="create">
        <button type="submit" class="modal-btn btn-confirm-checkout">Confirm and Pay</button>
      </form>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal -->
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
      <button type="button" class="modal-btn btn-cancel">Cancel</button>
      <form action="${pageContext.request.contextPath}/cart" method="post" id="deleteCartForm">
        <input type="hidden" name="action" value="remove">
        <input type="hidden" name="cartItemId" id="deleteCartItemId">
        <button type="submit" class="modal-btn btn-confirm-delete">Remove Item</button>
      </form>
    </div>
  </div>
</div>

<!-- Update Quantity Modal -->
<div class="modal-overlay" id="updateQuantityModal">
  <div class="modal-content">
    <span class="close-modal">&times;</span>

    <div class="modal-header">
      <i class="bx bx-edit"></i>
      <h3>Update Quantity</h3>
    </div>

    <form action="${pageContext.request.contextPath}/cart" method="post">

      <div class="modal-body">

        <input type="hidden" name="action" value="updateQuantity">

        <input
                type="hidden"
                name="cartItemId"
                id="updateCartItemId"
        >

        <label
                for="updateQuantityInput"
                style="display:block; margin-bottom:10px; font-weight:bold;"
        >
          Enter Quantity
        </label>

        <input
                type="number"
                name="quantity"
                id="updateQuantityInput"
                min="1"
                value="1"
                required
                style="
                  width:100%;
                  padding:12px;
                  border:1px solid #ccc;
                  border-radius:6px;
                  font-size:16px;
                "
        >

      </div>

      <div class="modal-footer">
        <button type="button" class="modal-btn btn-cancel">
          Cancel
        </button>

        <button type="submit" class="modal-btn btn-confirm-checkout">
          Update
        </button>
      </div>

    </form>
  </div>
</div>

<!-- ===== FOOTER ===== -->
<jsp:include page="fragments/footer.jsp"/>

<script>
  // Close message function
  const closeMessage = (id) => {
    const element = document.getElementById(id);
    if (element) {
      element.style.display = "none";
    }
  }

  // Format currency
  function formatRs(amount) {
    return "Rs. " + amount.toLocaleString('en-IN');
  }

  function parseRs(stringRs) {
    return parseInt(stringRs.replace(/[Rs. ,]/g, '')) || 0;
  }

  // Update cart totals
  function updateCartTotals() {
    const cartItems = document.querySelectorAll('.cart-item');
    let subtotal = 0;
    let totalItemsCount = 0;

    cartItems.forEach(item => {
      const priceDisplay = item.querySelector('.item-price-display').textContent;
      const price = parseRs(priceDisplay);
      const quantity = parseInt(item.querySelector('.quantity-input').value);
      const itemSubtotal = price * quantity;

      item.querySelector('.item-subtotal-display').textContent = formatRs(itemSubtotal);
      subtotal += itemSubtotal;
      totalItemsCount += quantity;
    });

    const shippingFee = subtotal > 0 ? 150 : 0;
    const grandTotal = subtotal + shippingFee;

    document.getElementById('cartSubtotalDisplay').textContent = formatRs(subtotal);
    document.getElementById('shippingFeeDisplay').textContent = formatRs(shippingFee);
    document.getElementById('cartTotalDisplay').textContent = formatRs(grandTotal);

    const itemCountDisplay = document.getElementById('itemCountDisplay');
    if (totalItemsCount === 0) {
      itemCountDisplay.textContent = "Your cart is empty.";
    } else {
      itemCountDisplay.textContent = `${totalItemsCount} Item${totalItemsCount > 1 ? 's' : ''} in your cart`;
    }
  }

  document.addEventListener('DOMContentLoaded', () => {
    const cartTableBody = document.getElementById('cartTableBody');
    if (!cartTableBody) return;

    // Modal functions
    function openModal(modalId) {
      document.getElementById(modalId).classList.add('show');
    }

    function closeModal(modalId) {
      document.getElementById(modalId).classList.remove('show');
    }

    // Close modal buttons
    document.querySelectorAll('.modal-overlay').forEach(modal => {
      modal.querySelectorAll('.close-modal, .btn-cancel').forEach(btn => {
        btn.addEventListener('click', () => closeModal(modal.id));
      });

      modal.addEventListener('click', (e) => {
        if (e.target === modal) closeModal(modal.id);
      });
    });

    // Cart table events
    cartTableBody.addEventListener('click', (event) => {
      const target = event.target;
      const row = target.closest('.cart-item');
      if (!row) return;

      // Minus button
      if (target.classList.contains('minus') || target.closest('.minus')) {
        event.preventDefault();

        const currentQuantity = row.querySelector('.quantity-input').value;
        const cartItemId = row.querySelector('.remove-btn').getAttribute('data-cart-item-id');

        document.getElementById('updateCartItemId').value = cartItemId;
        document.getElementById('updateQuantityInput').value = Math.max(parseInt(currentQuantity) - 1, 1);

        openModal('updateQuantityModal');
      }

      // Plus button
      if (target.classList.contains('plus') || target.closest('.plus')) {
        event.preventDefault();

        const currentQuantity = row.querySelector('.quantity-input').value;
        const cartItemId = row.querySelector('.remove-btn').getAttribute('data-cart-item-id');

        document.getElementById('updateCartItemId').value = cartItemId;
        document.getElementById('updateQuantityInput').value = parseInt(currentQuantity) + 1;

        openModal('updateQuantityModal');
      }

      // Delete button
      if (target.classList.contains('remove-btn') || target.closest('.remove-btn')) {
        event.preventDefault();

        const removeBtn = target.classList.contains('remove-btn') ? target : target.closest('.remove-btn');
        const cartItemId = removeBtn.getAttribute('data-cart-item-id');

        const itemName = row.querySelector('.cart-item-details h4').textContent;
        document.getElementById('deleteItemName').textContent = itemName;
        document.getElementById('deleteCartItemId').value = cartItemId;

        openModal('deleteConfirmModal');
      }

      // Buy now button
      if (target.classList.contains('buy-now-item-btn') || target.closest('.buy-now-item-btn')) {
        event.preventDefault();
        const productName = row.querySelector('.cart-item-details h4').textContent;
        const quantity = row.querySelector('.quantity-input').value;
        const subtotalDisplay = row.querySelector('.item-subtotal-display').textContent;

        const htmlContent = `
                <p>You have selected immediate checkout for:</p>
                <p>Item: <strong>${productName}</strong></p>
                <p>Quantity: ${quantity}</p>
                <p>Item Subtotal: <strong>${subtotalDisplay}</strong></p>
                <p>(Shipping fee of Rs. 150 will be applied at payment)</p>
            `;

        const modal = document.getElementById('buyNowModal');
        modal.querySelector('.modal-body').innerHTML = htmlContent;
        openModal('buyNowModal');
      }
    });

    // Proceed to checkout
    document.getElementById('proceedCheckoutBtn').addEventListener('click', (event) => {
      event.preventDefault();

      const totalItemsText = document.getElementById('itemCountDisplay').textContent;
      if (totalItemsText === "Your cart is empty.") {
        alert("Your cart is empty. Add items before checking out.");
        return;
      }

      const grandTotal = document.getElementById('cartTotalDisplay').textContent;
      const totalItems = totalItemsText.split(' ')[0];

      const htmlContent = `
            <p>You are about to checkout with your entire cart.</p>
            <p>Total Items: <strong>${totalItems}</strong></p>
            <p>Grand Total to Pay: <strong>${grandTotal}</strong></p>
            <p>Please confirm your order before payment.</p>
        `;

      const modal = document.getElementById('cartCheckoutModal');
      modal.querySelector('.modal-body').innerHTML = htmlContent;
      openModal('cartCheckoutModal');
    });

    // Initial totals
    updateCartTotals();
  });
</script>

</body>
</html>