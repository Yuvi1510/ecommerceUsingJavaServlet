<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 5/3/2026
  Time: 7:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar">
    <div class="navbar-item">
        <div class="logo">
<%--            <img src="simages/download.png" alt="FataFat Kin Logo" />--%>
            <img src="${pageContext.request.contextPath}/static/images/download.png" alt="FataFat Kin Logo" />
        </div>

        <div class="search-container">
            <input type="text" placeholder="Search product" class="search-input" />
            <button class="search-btn">
                <img src="${pageContext.request.contextPath}/static/images/search.png" class="search-icon" />
            </button>
        </div>

        <ul class="nav-links">
            <li><a href="#">Home</a></li>
            <li><a href="shop.html">Shop</a></li>
            <li><a class="active" href="about.html">About</a></li>
            <li><a href="order.html">My order</a></li>

            <li class="icon"><a href="service.html"><i class="bx bx-help-circle icon"></i><span>Service</span></a></li>
            <li class="icon">
                <a href="cart.html"><i class="bx bx-shopping-bag icon"></i><span>cart</span></a>
            </li>
            <li class="icon">
                <a href="${pageContext.request.contextPath}/login"><i class="bx bx-user icon"></i><span>login</span></a>
            </li>
        </ul>
    </div>
</nav>
