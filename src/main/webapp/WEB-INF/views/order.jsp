<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/order.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>

<!-- ===== NAVBAR ===== -->
<jsp:include page="fragments/navbar.jsp"/>

<div class="container">

    <h1>My Orders</h1>

    <c:choose>
        <c:when test="${not empty error}">
            <p style="color: red; text-align: center; padding: 5px;">
                <c:out value="${error}" />
            </p>
        </c:when>
        <c:when test="${not empty success}">
            <p style="color: green; text-align: center; padding: 5px;">
                <c:out value="${success}" />
            </p>
        </c:when>
    </c:choose>

    <c:choose>
        <c:when test="${empty orders}">
            <div id="empty">
                <img src="${pageContext.request.contextPath}/static/images/order-img.jpeg" class="empty-img" alt="No Orders">
                <h2>No Orders</h2>
                <h3>You haven't placed any orders yet</h3>
            </div>
        </c:when>

        <c:otherwise>
            <div id="orders-container">

                <c:forEach var="order" items="${orders}">
                    <div class="order-wrapper">

                        <div class="order-card">
                            <div class="order-header">
                                <h3>Order #${order.orderId}</h3>
                                <span class="order-date">Placed on: ${order.date}</span>
                            </div>

                            <div class="order-details">
                                <div class="order-info">
                                    <p><strong>Order Status:</strong>
                                        <span class="status-badge status-${order.orderStatus}">
                                                ${order.orderStatus}
                                        </span>
                                    </p>
                                    <p><strong>Total Amount:</strong> <span class="total-amount">Rs ${order.totalAmount}</span></p>
                                </div>
                            </div>

                            <div class="order-items">
                                <h4>Items in this order:</h4>

                                <div class="items-list">
                                    <c:forEach var="item" items="${order.orderItems}">
                                        <div class="item-card">
                                            <img src="${pageContext.request.contextPath}/images/${item.imagePath}"
                                                 alt="${item.name}"
                                                 class="item-image"

                                            <div class="item-details">
                                                <h5>${item.name}</h5>
                                                <p class="item-description">${item.description}</p>
                                                <div class="item-price-info">
                                                    <span class="item-price">Rs ${item.price}</span>
                                                    <span class="item-quantity">Quantity: ${item.orderQuantity}</span>
                                                    <span class="item-total">Total: Rs ${item.amount}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="order-actions">
                                <c:if test="${order.orderStatus == 'PENDING'}">
                                    <a href="${pageContext.request.contextPath}/order?action=cancel&id=${order.orderId}" class="btn-cancel" >
                                        Cancel Order
                                    </a>
                                </c:if>
                                <c:if test="${order.orderStatus == 'DELIVERED'}">
                                    <button class="btn-review" onclick="writeReview(${order.orderId})">
                                        Write a Review
                                    </button>
                                </c:if>
                                <button class="btn-track">
                                    Track Order
                                </button>
                            </div>
                        </div>

                    </div>
                </c:forEach>

            </div>
        </c:otherwise>

    </c:choose>

    <jsp:include page="fragments/footer.jsp"/>


</div>

<!-- JS LINK -->
<script>
    const orderContainer = document.getElementById("order");
const empty = document.getElementById("empty");
const clearBtn = document.getElementById("clearBtn");

if (orderContainer) {
  let orders = JSON.parse(localStorage.getItem("orders")) || [];

  function showOrders() {
    orderContainer.innerHTML = "";

    if (orders.length === 0) {
      empty.style.display = "flex";
      clearBtn.style.display = "none";
    } else {
      empty.style.display = "none";
      clearBtn.style.display = "block";

      orders.forEach((order) => {
        const div = document.createElement("div");
        div.classList.add("order-card");

        div.innerHTML = `
          <img src="${order.img}" width="120">
          <h3>${order.name}</h3>
          <p>Rs ${order.price}</p>
          <p>Status: ${order.status}</p>
        `;

        orderContainer.appendChild(div);
      });
    }
  }

  if (clearBtn) {
    clearBtn.addEventListener("click", () => {
      localStorage.removeItem("orders");
      orders = [];
      showOrders();
    });
  }

  showOrders();
}
</script>

</body>
</html>