<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 3/24/2026
  Time: 5:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>Categories</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css">
    <script src="${pageContext.request.contextPath}/static/js/admin/categories.js"></script>
</head>
<body>
<header>
    <h1>Fatafat-Kin</h1>
    <span>Admin Dashboard</span>
    <a href="${pageContext.request.contextPath}/logout"><button class="logout-btn">Logout</button></a>
</header>

<main>
    <aside>
        <a href="${pageContext.request.contextPath}/dashboard/users"><button class="option">Users</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/categories"><button class="option active">Categories</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/products"><button class="option">Products</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/orders"><button class="option">Orders</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/reports"><button class="option">Reports</button></a>
    </aside>

    <div class="content-container">
        <div class="content" id="users-page">

            <h2>Categories Management</h2>

            <!-- Success/Error Messages -->
            <c:if test="${not empty success}">
                <div id="successMessage" style="display:flex; justify-content: space-between; background: #d1fae5; padding: 12px; border-radius: 10px; margin: 10px 0; color: #065f46; font-weight: 500; max-width: 600px; margin:auto;">
                        ${success}
                    <button onclick="document.getElementById('successMessage').style.display='none'" style="padding: 2px 5px; background: none; border: none; font-size: 18px; cursor: pointer; color: #065f46;">X</button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div id="errorMessage" style="display:flex; justify-content: space-between; background: #fee2e2; padding: 12px; border-radius: 10px; margin: 10px 0; color: #991b1b; font-weight: 500;">
                        ${error}
                    <button onclick="document.getElementById('errorMessage').style.display='none'" style="padding: 2px 5px; background: none; border: none; font-size: 18px; cursor: pointer; color: #991b1b;">X</button>
                </div>
            </c:if>

            <div class="buttons">
                <a href="${pageContext.request.contextPath}/dashboard/categories"><button>All Categories</button></a>
                <button onclick="changeContent('add', '${pageContext.request.contextPath}')">Add Category</button>
            </div>

            <div id="inner-content" class="form-container">
                <c:if test="${not empty error}">
                    <span style="color: red;">${error}</span>
                </c:if>
                <c:if test="${not empty categories}">
                    <table>
                        <caption>All Categories</caption>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody id="users-table-body">
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>${category.categoryId}</td>
                                <td>${category.name}</td>
                                <td class="actions">
                                    <button onclick="edit('${category.categoryId}','${category.name}', '${pageContext.request.contextPath}')">Edit</button>
                                    <button onclick="deleteCategory('${category.categoryId}','${category.name}', '${pageContext.request.contextPath}')" class="btn-danger">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </div>
    </div>
</main>

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