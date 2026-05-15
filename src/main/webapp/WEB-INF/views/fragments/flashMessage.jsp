<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 5/15/2026
  Time: 7:04 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:if test="${not empty success}">
    <div id="successMessage" style="display: flex; ">
        <p style="background-color: #7af67c; color: white; margin: auto; padding:0 10px;">

                ${success}

            <button

                    onclick="closeMessage('successMessage')"
                    style="color: red; padding:0 5px; margin-left: 10px">
                X
            </button>
        </p>


    </div>
</c:if>
<c:if test="${not empty error}">
    <div id="errorMessage" style="display: flex; ">
        <p style="background-color: #f85656; color: white; margin: auto; padding: 0 10px;">

                ${error}

            <button

                    onclick="closeMessage('errorMessage')"
                    style="color: black; padding:0 5px; margin-left: 10px;">
                X
            </button>
        </p>


    </div>
</c:if>

