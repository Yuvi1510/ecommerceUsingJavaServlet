<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            text-align: center;
            margin-top: 100px;
        }
        .box {
            display: inline-block;
            padding: 30px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 10px;
        }
        h1 {
            color: red;
        }
        p {
            color: #555;
        }
    </style>
</head>
<body>

<div class="box">
    <h1>403 - Access Denied</h1>
    <p>You do not have permission to access this page.</p>
    <a href="${pageContext.request.contextPath}/home">Go to Home</a>
</div>

</body>
</html>