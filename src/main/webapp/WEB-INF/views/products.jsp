<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 3/24/2026
  Time: 6:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html>
<head>
    <title>Products</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css">
    <script src="${pageContext.request.contextPath}/static/js/products.js"></script>
    <script>
        const categories = [
            <c:forEach var="cat" items="${categories}">
            { id: ${cat.categoryId}, name: "${cat.name}" },
            </c:forEach>
        ];
        console.log(categories)
    </script>
</head>

<body>
<header>
    <h1>Fatafat-Kin</h1>
    <span>Admin Dashboard</span>
    <button class="logout-btn"><a href="">Logout</a></button>
</header>

<main>
    <aside>
        <a href="dashboard"><button class="option ">Users</button></a>
        <a href="categories"><button class="option ">Categories</button></a>
        <a href="products"><button class="option active">Products</button></a>
        <a href="orders"><button class="option">Orders</button></a>
        <a href="reports"><button class="option">Reports</button></a>
    </aside>

    <div class="content-container">
        <div class="content" id="users-page">
            <h2>Users Management</h2>
            <div class="buttons">
                <a href="/products"><button >All Products</button></a>
                <button onclick="changeContent('addProduct')">Add Product</button>
                <button onclick="changeContent('findProductsByName')">Find Product By Name</button>
                <button onclick="changeContent('findProductsByCategory')">Find Product By Category</button>
                <button onclick="changeContent('findProductsById')">Find Product By ID</button>
            </div>
            <div id="inner-content" class="form-container">
               <c:if test="${not empty products}">
                   <table>
                       <caption>All Products</caption>
                       <thead>
                       <tr>
                           <th>ID</th>
                           <th>Name</th>
                           <th>Description</th>
                           <th>ImagePath</th>
                           <th>Price</th>
                           <th>Quantity</th>
                           <th>Actions</th>
                       </tr>
                       </thead>
                       <tbody >
                      <c:forEach var="product" items="${products}">
                          <tr>
                              <td>${product.productId}</td>
                              <td>${product.name}</td>
                              <td>${product.description}</td>
                              <td>${product.imagePath}</td>
                              <td>${product.price}</td>
                              <td>${product.quantity}</td>

                              <c:forEach var="cat" items="${categories}">
                                  <c:if test="${cat.categoryId == product.categoryId}">
                                      <td>${cat.name}</td>
                                  </c:if>
                              </c:forEach>
                              <td>
                                  <button onclick="editProduct('${product.productId}','${product.name}','${product.description}','${product.imagePath}','${product.price}','${product.quantity}','${product.categoryId}', categories)">Edit</button>
                                  <button onclick="deleteProduct('${product.productId}','${product.name}','${product.description}','${product.imagePath}','${product.price}','${product.quantity}','${product.categoryId}', categories)" class="btn-danger">Delete</button>
                              </td>
                          </tr>
                      </c:forEach>
                       </tbody>
                   </table>
               </c:if>

<%--                <form action="" method="post">--%>
<%--                    <div>--%>
<%--                        <label for="category">Category: </label>--%>
<%--                        <select name="category" id="">--%>
<%--                            <option value="sports">Sports</option>--%>
<%--                            <option value="electronics">Electronics</option>--%>
<%--                            <option value="fashion">Fashion</option>--%>
<%--                        </select>--%>
<%--                    </div>--%>
<%--                    <button type="submit">Find Product</button>--%>
<%--                </form>--%>

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
