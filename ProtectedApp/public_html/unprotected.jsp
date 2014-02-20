<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.oracleateam.iam.protectedapp.RequestInfo"%>
<%@ page contentType="text/html;charset=ISO-8859-1"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
</head>
<body>
<%@include file="links.jsp" %>
<% RequestInfo.dump( out, request ); %>
</body>
</body>
</html>
