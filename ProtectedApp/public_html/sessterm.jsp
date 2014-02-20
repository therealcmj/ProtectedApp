<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=ISO-8859-1"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
    </head>
    <body>
<%
    request.getSession().invalidate();
%>
    Your J2EE session should be invalidated.
<BR/>
    <a href=".">home</a>
    </body>
</html>