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
    <a href="${pageContext.request.contextPath}/logout"><button class="logout-btn">Logout</button></a>
</header>

<style>
    .card {
        background: white;
        padding: 20px;
        border-radius: 10px;
        min-width: 150px;
        text-align: center;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        font-weight: bold;
    }
</style>

<main>
    <aside>
        <a href="${pageContext.request.contextPath}/dashboard/users"><button class="option  ">Users</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/categories"><button class="option ">Categories</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/products"><button class="option">Products</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/orders"><button class="option active">Orders</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/reports"><button class="option">Reports</button></a>
    </aside>

    <div class="content-container">
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


<%-- cards--%>
        <div style="display:flex; gap:15px; flex-wrap:wrap; justify-content:center; margin:20px 0;">

            <div class="card">Users: ${users}</div>
            <div class="card">Products: ${products}</div>
            <div class="card">Orders: ${orders}</div>
            <div class="card">Revenue: ${revenue}</div>

        </div>

        <div style="display: flex; flex-direction: column; gap: 25px; align-items: center; margin-top: 20px;">

            <div style="display: flex;">
                <div style="width: 500px; height: 300px;">
                    <canvas id="revenueChart"></canvas>
                </div>

                <div style="width: 300px; height: 300px;">
                    <canvas id="statusChart"></canvas>
                </div>
            </div>

            <div style="width: 500px; height: 300px;">
                <canvas id="topProductsChart"></canvas>
            </div>

        </div>

    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const closeMessage = (id) =>{
        const element = document.getElementById(id);
        if (element) {
            element.style.display = "none";
        }
    }


    // MONTHLY REVENUE
    const months = [
        <c:forEach var="m" items="${monthlyRevenue}">
        '${m.month}',
        </c:forEach>
    ];

    const revenue = [
        <c:forEach var="m" items="${monthlyRevenue}">
        ${m.revenue},
        </c:forEach>
    ];

    new Chart(document.getElementById('revenueChart'), {
        type: 'line',
        data: {
            labels: months,
            datasets: [{
                label: 'Monthly Revenue',
                data: revenue
            }]
        }
    });

    // ORDER STATUS
    const statusLabels = [
        <c:forEach var="s" items="${orderStatus}">
        '${s.order_status}',
        </c:forEach>
    ];

    const statusData = [
        <c:forEach var="s" items="${orderStatus}">
        ${s.total},
        </c:forEach>
    ];

    new Chart(document.getElementById('statusChart'), {
        type: 'pie',
        data: {
            labels: statusLabels,
            datasets: [{
                data: statusData
            }]
        }
    });

    // TOP PRODUCTS
    const productLabels = [
        <c:forEach var="p" items="${topProducts}">
        '${p.product}',
        </c:forEach>
    ];

    const productData = [
        <c:forEach var="p" items="${topProducts}">
        ${p.sold},
        </c:forEach>
    ];

    new Chart(document.getElementById('topProductsChart'), {
        type: 'bar',
        data: {
            labels: productLabels,
            datasets: [{
                label: 'Top Products',
                data: productData
            }]
        }
    });

</script>
</body>
</html>
