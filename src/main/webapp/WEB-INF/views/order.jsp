<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/order.css">
</head>
<body style="display: block; ">

<!-- ===== NAVBAR ===== -->


<jsp:include page="fragments/navbar.jsp"/>
    <div class="container" style="margin-top: 80px; min-height: 1200px; overflow: scroll">

        <h1>My Orders</h1>
        <c:if test="${not empty success}">
            <div id="successMessage" style="display: flex; ">
                <p style="background-color: #7af67c; color: white; margin: auto; padding:0 10px;">

                        ${success}

                    <button

                            onclick="closeMessage('successMessage')"
                            style="color: red; padding:0 5px; margin-left: 10px">
                        X
                    </button>
                </p>


            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div id="errorMessage" style="display: flex; ">
                <p style="background-color: #f85656; color: white; margin: auto; padding: 0 10px;">

                        ${error}

                    <button

                            onclick="closeMessage('errorMessage')"
                            style="color: black; padding:0 5px; margin-left: 10px;">
                        X
                    </button>
                </p>


            </div>
        </c:if>


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
                                                     class="item-image"/>

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
    </div>

<jsp:include page="fragments/footer.jsp"/>


<!-- JS LINK -->
<script>

    const closeMessage = (id) =>{
        const element = document.getElementById(id);
        if (element) {
            element.style.display = "none";
        }
    }

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