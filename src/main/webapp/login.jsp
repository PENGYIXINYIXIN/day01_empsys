<%--
  Created by IntelliJ IDEA.
  User: renr
  Date: 2019/6/6
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<form action="login.do" method="post">
    name<input type="text" name="username" /><br />
    password<input type="password" name="password" /><br />
    <input type="checkbox" name="isRemember" value="1" />记住我<br />
    <input type="submit" value="login" /><br />

</form>

</body>
</html>
