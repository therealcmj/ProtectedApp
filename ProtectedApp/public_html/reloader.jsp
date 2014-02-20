<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="com.oracleateam.iam.protectedapp.RequestInfo"%>
<%@ page import="com.oracleateam.iam.protectedapp.SessionRequestCounter"%>
<html>
<head>
    <title>Reloader page</title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
</head>
<body>
<%@include file="links.jsp" %>

<img src="oracle.gif"/>
<BR/>
This page does nothing more than create a J2EE session, puts a counter in it, displays that value, and then reloads.

<P/>

<%
    //HttpSession session = request.getSession(false);
    if ( session == null ) {
        out.println( "Session has NOT yet been created.<P/>" );
        session = request.getSession(true);
    }
    else
    {
        out.println( "Session HAS been created.<BR/>" );        
        out.println( "Session class: " + session.getClass().getName() + "<P/>");
        
        String hostname = RequestInfo.getServerHostname();
        String managedServer = RequestInfo.getServerName();
        Integer count = RequestInfo.getRequestCount(session);
        
        out.print( "Host: " + hostname + "<BR/>" );
        out.print( "Count: " + count + "<BR/>" );
        out.print( "Server: " + managedServer + "</BR>" );
        
        response.setHeader( "ServerHost", hostname );
        response.setHeader( "ManagedServer", managedServer );
        response.setHeader( "RequestCount", count.toString() );

        response.setHeader( "refresh", "1" );

        
        //SessionRequestCounter.showCount( out, request);
    }


%>


</body>
</html>