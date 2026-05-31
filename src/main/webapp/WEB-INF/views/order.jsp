<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/order.css">
    <style>
        /* Simple tab styles - MORE VISIBLE COLORS */
        .orders-tabs {
            display: flex;
            gap: 12px;
            margin: 20px 0;
            flex-wrap: wrap;
        }

        .tab-btn {
            padding: 10px 24px;
            background: #9af489;
            border: 2px solid #cbd5e1;
            border-radius: 30px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s;
            color: #1e293b;
        }

        .tab-btn:hover {
            background: #cbd5e1;
            transform: translateY(-1px);
        }

        .tab-btn.active {
            background: #22c55e;
            border-color: #16a34a;
            color: white;
        }

        /* Hide filtered orders */
        .order-wrapper.filtered-out {
            display: none;
        }

        /* Button colors - greenish theme with better visibility */
        .btn-cancel, .btn-review, .btn-track {
            border: none;
            padding: 8px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s;
        }

        .btn-cancel {
            background: #dc2626;
            color: white;
        }

        .btn-cancel:hover {
            background: #b91c1c;
            transform: scale(1.02);
        }

        .btn-review {
            background: #16a34a;
            color: white;
        }

        .btn-review:hover {
            background: #15803d;
            transform: scale(1.02);
        }

        .btn-track {
            background: #0284c7;
            color: white;
        }

        .btn-track:hover {
            background: #0369a1;
            transform: scale(1.02);
        }

        /* Fix for fixed navbar - add padding to body */
        body {
            padding-top: 80px;
            margin: 0;
            background: #f1f5f9;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px 40px 20px;
        }

        h1 {
            color: #0f172a;
            margin-bottom: 10px;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }

        .status-PENDING { background: #fef3c7; color: #d97706; }
        .status-SHIPPED { background: #dbeafe; color: #2563eb; }
        .status-DELIVERED { background: #d1fae5; color: #059669; }
        .status-CANCELLED { background: #fee2e2; color: #dc2626; }

        .order-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
            flex-wrap: wrap;
            gap: 10px;
        }

        .order-header h3 {
            margin: 0;
            color: #0f172a;
        }

        .order-date {
            color: #64748b;
            font-size: 14px;
        }

        .order-details {
            margin-bottom: 15px;
        }

        .order-details p {
            margin: 8px 0;
        }

        .order-actions {
            display: flex;
            gap: 12px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .items-list {
            margin-top: 10px;
        }

        .item-card {
            display: flex;
            gap: 15px;
            padding: 12px;
            background: #f8fafc;
            border-radius: 12px;
            margin-bottom: 10px;
            align-items: center;
        }

        .item-image {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 10px;
        }

        .item-details {
            flex: 1;
        }

        .item-details h5 {
            margin: 0 0 5px 0;
            color: #0f172a;
        }

        .item-details p {
            margin: 0;
            color: #475569;
        }

        #empty {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 16px;
        }

        .empty-img {
            width: 200px;
            opacity: 0.6;
        }

        a.btn-cancel {
            text-decoration: none;
            display: inline-block;
        }

        @media (max-width: 640px) {
            .tab-btn {
                padding: 6px 16px;
                font-size: 13px;
            }

            .order-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .item-card {
                flex-direction: column;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<jsp:include page="fragments/navbar.jsp"/>

<div class="container">
    <h1>My Orders</h1>

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


    <!-- Filter Tabs - More Visible -->
    <div class="orders-tabs">
        <button class="tab-btn active" onclick="filterOrders('all', this)">All Orders</button>
        <button class="tab-btn" onclick="filterOrders('PENDING', this)">Pending</button>
        <button class="tab-btn" onclick="filterOrders('SHIPPED', this)">Shipped</button>
        <button class="tab-btn" onclick="filterOrders('DELIVERED', this)">Delivered</button>
        <button class="tab-btn" onclick="filterOrders('CANCELLED', this)">Cancelled</button>
    </div>

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
                    <div class="order-wrapper" data-status="${order.orderStatus}">
                        <div class="order-card">
                            <div class="order-header">
                                <h3>Order #${order.orderId}</h3>
                                <span class="order-date">${order.date}</span>
                            </div>

                            <div class="order-details">
                                <p><strong>Order Status:</strong>
                                    <span class="status-badge status-${order.orderStatus}">${order.orderStatus}</span>
                                </p>
                                <p><strong> Total Amount:</strong> <strong style="color: #16a34a; font-size: 18px;">Rs ${order.totalAmount}</strong></p>
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
                                                <p>Quantity: ${item.orderQuantity} × Rs ${item.price} = <strong>Rs ${item.amount * item.orderQuantity}</strong></p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="order-actions">
                                <c:if test="${order.orderStatus == 'PENDING'}">
                                    <a href="${pageContext.request.contextPath}/orders?action=cancel&id=${order.orderId}" class="btn-cancel" onclick="return confirm('Are you sure you want to cancel this order?')">Cancel Order</a>
                                </c:if>
                                <c:if test="${order.orderStatus == 'DELIVERED'}">
                                    <button class="btn-review" onclick="writeReview(${order.orderId})">Write a Review</button>
                                </c:if>
                                <c:if test="${order.orderStatus != 'CANCELLED' && order.orderStatus != 'DELIVERED'}">

                                <button class="btn-track" onclick="trackOrder('${order.orderId}')">Track Order</button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="fragments/footer.jsp"/>

<script>
        const closeMessage = (id) =>{
        const element = document.getElementById(id);
        if (element) {
        element.style.display = "none";
    }
    }
    // Simple filter function - just checks status and shows/hides
    function filterOrders(status, button) {
        // Update active tab styling - make active tab green, others visible gray
        const tabs = document.querySelectorAll('.tab-btn');
        tabs.forEach(tab => {
            tab.classList.remove('active');
        });
        button.classList.add('active');

        // Get all order wrappers
        const orders = document.querySelectorAll('.order-wrapper');

        // Loop through and filter
        orders.forEach(order => {
            const orderStatus = order.getAttribute('data-status');

            if (status === 'all') {
                order.classList.remove('filtered-out');
            } else {
                if (orderStatus === status) {
                    order.classList.remove('filtered-out');
                } else {
                    order.classList.add('filtered-out');
                }
            }
        });
    }


    // Track order function
    function trackOrder(orderId) {
        alert('Tracking information for order #' + orderId + '\n\nYour order is on the way!');
        // You can implement actual tracking here
    }
</script>

</body>
</html>