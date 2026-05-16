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
    <script src="${pageContext.request.contextPath}/static/js/admin/products.js"></script>
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
        <a href="${pageContext.request.contextPath}/dashboard/users"><button class="option ">Users</button></a>
        <a href="${pageContext.request.contextPath}/dashboardcategories"><button class="option ">Categories</button></a>
        <a href="${pageContext.request.contextPath}/dashboardproducts"><button class="option active">Products</button></a>
        <a href="${pageContext.request.contextPath}/dashboardorders"><button class="option">Orders</button></a>
        <a href="${pageContext.request.contextPath}/dashboard/reports"><button class="option">Reports</button></a>
    </aside>

    <div class="content-container">
        <div class="content" id="users-page">
            <h2>Users Management</h2>

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


            <div class="buttons">
                <a href="${pageContext.request.contextPath}/dashboard/products"><button >All Products</button></a>
                <button onclick="changeContent('addProduct', '${pageContext.request.contextPath}')">Add Product</button>
                <button onclick="changeContent('findProductsByName', '${pageContext.request.contextPath}')">Find Product By Name</button>
                <button onclick="changeContent('findProductsByCategory', '${pageContext.request.contextPath}')">Find Product By Category</button>
                <button onclick="changeContent('findProductsById', '${pageContext.request.contextPath}')">Find Product By ID</button>
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
                           <th>Category</th>
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
                                  <button onclick="editProduct('${product.productId}','${product.name}','${product.description}','${pageContext.request.contextPath}/images/${product.imagePath}','${product.price}','${product.quantity}','${product.categoryId}', categories, '${pageContext.request.contextPath}')">Edit</button>
                                  <button onclick="deleteProduct('${product.productId}','${product.name}','${product.description}','${product.imagePath}','${product.price}','${product.quantity}','${product.categoryId}', categories, '${pageContext.request.contextPath}')" class="btn-danger">Delete</button>
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
