<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=ISO-8859-1"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
    </head>
    <body>
    
If you have protected this application with OAM then SSO is not working for some reason.
<P/>
    
<form method=post action="j_security_check">
Username: <input type="text"  name= "j_username" value="weblogic"/><BR/>
Password: <input type="password"  name= "j_password" value="Alpha1234"/><BR/>
<input type="submit" value=" Login "/><BR/>
</form>    
    </body>
</html>
