<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 3/22/2026
  Time: 8:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fatafat-Kin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css"/>
    <script src="${pageContext.request.contextPath}/static/js/dashboard.js"></script>
</head>
<body>
<header>
    <h1>Fatafat-Kin</h1>
    <span>Admin Dashboard</span>
    <a href=""><button class="logout-btn">Logout</button></a>
</header>

<main>
    <aside>
        <a href="dashboard"><button class="option active ">Users</button></a>
        <a href="categories"><button class="option ">Categories</button></a>
        <a href="products"><button class="option">Products</button></a>
        <a href="orders"><button class="option">Orders</button></a>
        <a href="reports"><button class="option">Reports</button></a>
    </aside>

    <div class="content-container">
        <div class="content" id="users-page">
            <h2>Users Management</h2>
            <div class="buttons">
                <a href="/dashboard"><button>All Users</button></a>
                <button onclick="changeContent('addUser')">Add User</button>
                <button onclick="changeContent('findUserByEmail')">Find User By Email</button>
                <button onclick="changeContent('findUserById')">Find User By ID</button>
<%--                <button onclick="changeContent('updateUser')">Update User</button>--%>
<%--                <button onclick="changeContent('deleteUser')">Delete User</button>--%>
            </div>
            <div id="inner-content" class="form-container">
                <c:if test="${not empty error}">
                    <span style="color: red;">${error}</span>
                </c:if>
               <c:if test="${not empty users}">
                   <table>
                       <caption>All Users</caption>
                       <thead>
                       <tr>
                           <th>ID</th>
                           <th>First Name</th>
                           <th>Last Name</th>
                           <th>DOB</th>
                           <th>Email</th>
                           <th>Phone</th>
                           <th>Address</th>
                           <th>Actions</th>
                       </tr>
                       </thead>
                       <tbody id="users-table-body">
                       <c:forEach var="user" items="${users}" varStatus="status">
                            <tr>
                                <td>${user.userId}</td>
                                <td>${user.firstName}</td>
                                <td>${user.lastName}</td>
                                <td>${user.dob}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>${user.address}</td>
                                <td class="actions">
                                    <button onclick="editUser('${user.userId}', '${user.firstName}', '${user.lastName}', '${user.dob}', '${user.email}', '${user.phone}', '${user.address}')">Edit</button>
                                    <button onclick="deleteUser('${user.userId}', '${user.firstName}', '${user.lastName}', '${user.dob}', '${user.email}', '${user.phone}', '${user.address}')" class="btn-danger">Delete</button>
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
