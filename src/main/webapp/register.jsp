<%--
  Created by IntelliJ IDEA.
  User: deca
  Date: 13/09/2025
  Time: 4:18 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h2>Register User</h2>
<s:form action="register">
    <s:textfield name="username" label="Username"/>
    <s:password name="password" label="Password"/>
    <s:submit value="Register"/>
</s:form>

</body>
</html>
