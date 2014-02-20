<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=ISO-8859-1"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
    </head>
    <body>

<script language="JavaScript">

function deleteCookie(szName)
{
    //alert( "Deleting cookie named " + szName );
    
    newCookie = szName + '=' + '; PATH=/' + "; EXPIRES=" + new Date(1).toGMTString();
    //alert( newCookie );
    
    document.cookie = newCookie;
    
}


function setCookie(szName, szValue)
{
    //alert( "Name: " + szName + "\r\n" + "Value: " + szValue );
    
    document.cookie = szName + '=' + szValue + '; PATH=/';
    
    window.location.reload();
}

function setCookieFromForm()
{
    //alert( "Setting cookie from form input" );
    szName  = document.forms['newcookie'].name.value;
    szValue = document.forms['newcookie'].val.value;
    
    setCookie( szName, szValue );
}

function makeRandomString(iLen)
{
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < iLen; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
}

function setRandomCookie()
{
    setCookie( makeRandomString(5), makeRandomString(50) );
}

</script>

<%@include file="links.jsp" %>

<B>Set a new cookie:</b>
<form name="newcookie">
<table>
<tr><td>Name:</td><td><input type="text" name="name" value=""/></td></tr>
<tr><td>Value:</td><td><input type="text" name="val" value=""/></td></tr>
<tr><td colspan="2" align="center"><input type="button" value=" Set " onclick="setCookieFromForm();"/> <input type="button" value=" Set Random" onclick="setRandomCookie();"/></td></tr>
</table>
</form>
<P/>

<B>Existing cookies:</B><BR/>
<%
        Cookie[] cookies = request.getCookies();
        if ((null != cookies) && (cookies.length > 0)) {
            out.println( "<table border=1>");
            out.println( "<tr><th></th><th>Name</th><th>Value</th></tr>" );
            for (int i = 0; i < cookies.length; i++) {
                Cookie c = cookies[i];
                out.println( "<tr>" );
                out.println( "<td>" + "<a href=\"\" onclick=\"deleteCookie('" + c.getName() + "');\">X</a></td>" );
                out.println( "<td>" + c.getName() + "</td><td>" + c.getValue() + "</td>" );
                
                //out.println( "<tr><td colspan=3><hr/></td></tr>" );
                
                out.println( "</tr>" );
            }
            out.println( "</pre>");
        }
%>
    
    </body>
</html>