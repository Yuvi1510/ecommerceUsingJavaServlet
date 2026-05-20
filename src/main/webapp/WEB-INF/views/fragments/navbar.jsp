<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        <form action="${pageContext.request.contextPath}/shop" method="get" class="search-container">
            <input name="action" value="findProductsByName" hidden>
            <input type="text" placeholder="Search product" class="search-input" name="name" />
            <button type="submit" class="search-btn">
                <img src="${pageContext.request.contextPath}/static/images/search.png" class="search-icon" />
            </button>
        </form>

        <ul class="nav-links" style="align-items: center">
            <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/shop">Shop</a></li>
            <li><a  href="${pageContext.request.contextPath}/about">About</a></li>
            <li><a href="${pageContext.request.contextPath}/my-orders">My order</a></li>

            <li class="icon"><a href="${pageContext.request.contextPath}/service"><i class="bx bx-help-circle icon"></i><span>Service</span></a></li>
            <li class="icon">
                <a href="${pageContext.request.contextPath}/cart"><i class="bx bx-shopping-bag icon"></i>  <span>cart</span>
<%--                    <span id="cart-count">0</span>--%>
                </a>
            </li>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <p style="color: black; font-weight: bold;text-transform: capitalize;">
                        ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                    </p>
                    <li class="icon">
                        <a href="${pageContext.request.contextPath}/logout"><i class="bx bx-user icon"></i><span>logout</span></a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="icon">
                        <a href="${pageContext.request.contextPath}/login"><i class="bx bx-user icon"></i><span>login</span></a>
                    </li>
                </c:otherwise>
            </c:choose>

        </ul>
    </div>
</nav>
