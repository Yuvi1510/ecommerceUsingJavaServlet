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
    <a href=""><button class="logout-btn">Logout</button></a>
</header>

<main>
    <aside>
        <a href="dashboard"><button class="option ">Users</button></a>
        <a href="categories"><button class="option active">Categories</button></a>
        <a href="products"><button class="option">Products</button></a>
        <a href="orders"><button class="option">Orders</button></a>
        <a href="reports"><button class="option">Reports</button></a>
    </aside>

    <div class="content-container">
        <div class="content" id="users-page">
            <h2>Categories Management</h2>
            <div class="buttons">
                <a href="/categories"><button >All Categories</button></a>
                <button onclick="changeContent('add')">Add Category</button>
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
                                   <button onclick="edit('${category.categoryId}','${category.name}')">Edit</button>
                                   <button onclick="deleteCategory('${category.categoryId}','${category.name}')" class="btn-danger">Delete</button>
                               </td>
                           </tr>
                       </c:forEach>
                       </tbody>
                   </table>
               </c:if>
            </div>
        </div>
        <div id="categories-page"></div>
        <div id="products-page"></div>
        <div id="orders-page"></div>
        <div id="reports-page"></div>
    </div>

</main>

</body>
</html>
