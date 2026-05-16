<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 3/22/2026
  Time: 8:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%--
  Order Management Page for Admin Section
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Order Management - Fatafat-Kin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/order-management.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css">
</head>
<body>
<header>
  <h1>Fatafat-Kin</h1>
  <span>Order management</span>
  <a href=""><button class="logout-btn">Logout</button></a>
</header>

<main>
  <aside>
    <a href="${pageContext.request.contextPath}/dashboard//dashboard/users"><button class="option  ">Users</button></a>
    <a href="${pageContext.request.contextPath}/dashboard/categories"><button class="option ">Categories</button></a>
    <a href="${pageContext.request.contextPath}/dashboard/products"><button class="option">Products</button></a>
    <a href="${pageContext.request.contextPath}/dashboard/orders"><button class="option active">Orders</button></a>
    <a href="${pageContext.request.contextPath}/dashboard/reports"><button class="option">Reports</button></a>
  </aside>

  <div class="content-container">

    <div id="orders-page" class="content-page active">
      <div class="orders-header">
        <h2>Order Management</h2>
      </div>

      <!-- Filter Buttons -->
      <div class="filter-buttons">
        <button class="filter-btn active" data-status="all">All Orders</button>
        <button class="filter-btn" data-status="PENDING">Pending</button>
        <button class="filter-btn" data-status="SHIPPED">Shipped</button>
        <button class="filter-btn" data-status="DELIVERED">Delivered</button>
        <button class="filter-btn" data-status="CANCELLED">Cancelled</button>
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

      <!-- Orders Table -->
      <c:choose>
        <c:when test="${empty orders}">
          <div class="empty-state">
            <h3>No Orders Found</h3>
            <p>There are no orders in the system yet.</p>
          </div>
        </c:when>
        <c:otherwise>
          <div class="table-container">
            <table class="orders-table">
              <thead>
              <tr>
                <th>Order ID</th>
                <th>Customer Email</th>
                <th>Order Date</th>
                <th>Sub Total</th>
                <th>Tax</th>
                <th>Delivery</th>
                <th>Total Amount</th>
                <th>Status</th>
                <th>Order Items</th>
              </tr>
              </thead>
              <tbody id="orders-table-body">
              <c:forEach var="order" items="${orders}">
                <tr class="order-row" data-status="${order.orderStatus}">
                  <td>${order.orderId}</td>
                  <td>${order.userEmail}</td>
                  <td>${order.date}</td>
                  <td>Rs ${order.subTotal}</td>
                  <td>Rs ${order.taxAmount}</td>
                  <td>Rs ${order.deliveryCharge}</td>
                  <td class="total-amount">Rs ${order.totalAmount}</td>
                  <td>
                    <select class="status-dropdown" data-order-id="${order.orderId}" data-current-status="${order.orderStatus}">
                      <option value="PENDING" ${order.orderStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                      <option value="SHIPPED" ${order.orderStatus == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                      <option value="DELIVERED" ${order.orderStatus == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                      <option value="CANCELLED" ${order.orderStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                    </select>
                  </td>
                  <td>
                    <button class="view-items-btn" data-order-id="${order.orderId}">View Items</button>
                  </td>
                </tr>
                <tr class="order-items-row" id="items-${order.orderId}" style="display: none;">
                  <td colspan="9">
                    <div class="order-items-container">
                      <h4>Order Items for Order #${order.orderId}</h4>
                      <c:choose>
                        <c:when test="${empty order.orderItems}">
                          <p>No items found for this order.</p>
                        </c:when>
                        <c:otherwise>
                          <table class="items-table">
                            <thead>
                            <tr>
                              <th>Product Image</th>
                              <th>Product Name</th>
                              <th>Description</th>
                              <th>Price</th>
                              <th>Quantity</th>
                              <th>Amount</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${order.orderItems}">
                              <tr>
                                <td>
                                  <img src="${pageContext.request.contextPath}/images/${item.imagePath}"
                                       alt="${item.name}"
                                       class="item-thumbnail">
                                </td>
                                <td>${item.name}</td>
                                <td>${item.description}</td>
                                <td>Rs ${item.price}</td>
                                <td>${item.orderQuantity}</td>
                                <td>Rs ${item.amount}</td>
                              </tr>
                            </c:forEach>
                            </tbody>
                          </table>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
    <!-- Popup Modal for Status Update -->
    <div id="statusModal" class="modal" style="display: none;">
      <div class="modal-content">
        <div class="modal-header">
          <h3>Update Order Status</h3>
          <button class="modal-close" onclick="closeModal()">×</button>
        </div>
        <form id="statusUpdateForm" method="POST" action="${pageContext.request.contextPath}/dashboard/orders">
          <input type="hidden" name="action" value="updateStatus">
          <input type="hidden" name="orderId" id="modalOrderId">
          <input type="hidden" name="status" id="modalStatus">

          <div class="form-group">
            <label>Are you sure you want to change the status?</label>
            <p id="statusChangeMessage"></p>
          </div>

          <div class="modal-buttons">
            <button type="button" class="btn-cancel-modal" onclick="closeModal()">Cancel</button>
            <button type="submit" class="btn-confirm">Confirm Update</button>
          </div>
        </form>
      </div>
    </div>

    <script src="${pageContext.request.contextPath}/static/js/admin/order-management.js"></script>

  <script>
    const closeMessage = (id) =>{
      const element = document.getElementById(id);
      if (element) {
        element.style.display = "none";
      }
    }
  </script>
</main>
</body>
</html>
