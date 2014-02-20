package com.oracleateam.iam.protectedapp;

import java.io.IOException;

import java.net.UnknownHostException;

import java.security.Principal;

import java.util.Enumeration;
import java.util.Iterator;
import java.util.Set;

import javax.naming.InitialContext;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;

import weblogic.management.MBeanHome;


public class RequestInfo {
    public RequestInfo() {
        super();
    }

    static public void dump(JspWriter out, HttpServletRequest request) throws IOException {

        out.println("Server info:<BR/>");

        out.println("<pre>");
        out.println( "Server Name: " + request.getServerName() );
        out.println( "Server Port: " + request.getServerPort() );
        out.println( "Server Path: " + request.getServletPath() );
        out.println("");
        out.println( "WLS Server: " + getServerName() );
        out.println("</pre>");

        out.println("<HR/>");

            
        out.println("Attributes:<BR/>");

        out.println("<pre>");
        out.println("   Auth Type: " + request.getAuthType());
        out.println("   Is Secure: " + request.isSecure());
        out.println("Content Type: " + request.getContentType());
        out.println("</pre>");

        out.println("<HR/>");


        if (null != request.getAuthType()) {
            out.println("Request is authenticated. Subject and principal info:");
            out.println("<pre>");
            out.println("Remote User: " + request.getRemoteUser());
            Principal principal = request.getUserPrincipal();
            out.println("Principal: " + principal.getName());

            

            Set<Principal> principals = weblogic.security.Security.getCurrentSubject().getPrincipals();
            if (null != principals) {
                out.println("Current subject principals: " +
                            weblogic.security.Security.getCurrentSubject().getPrincipals().toString());

                Iterator it = principals.iterator();
                while (it.hasNext()) {
                    Principal p = (Principal)it.next();
                    // This is kinda pointless
                    if (p instanceof weblogic.security.principal.WLSGroupImpl) {
                        //weblogic.security.principal.WLSGroupImpl gi = (weblogic.security.principal.WLSGroupImpl) p;

                        out.println("Principal name: " + p.getName());
                        out.println("Principal class: " + p.getClass().toString());
                    }
                }
            }

            out.println("</pre>");
            
            // Try the Identity Context thing
            try {
                IdentityContextInfo ici = new IdentityContextInfo();
                String subj = request.getHeader("OAM_IDENTITY_ASSERTION");
                if ( ( null == subj ) || (subj.equals("") ) ) {
                    out.println( "OAM_IDENTITY_ASSERTION is not present." );
                }
                else {
                    out.println( "Identity Context info:" );
                    out.println( ici.getClaimsContent(subj) );
                }
            }
            catch ( Exception e ) { }
        }


        out.println("<HR/>");
        out.println("Parameters:<BR/>" );

        out.println( "<pre>");
        Enumeration keys = request.getParameterNames();
        while (keys.hasMoreElements()) {
            String key = (String)keys.nextElement();
            out.println(" Name: " + key);

            ////To retrieve a single value
            //String value = request.getParameter(key);
            //out.println(value);

            // If the same key has multiple values (check boxes)
            String[] valueArray = request.getParameterValues(key);
            out.println("#vals: " + valueArray.length);
            for (int i = 0; i < valueArray.length; i++) {
                out.println("Value: " + valueArray[i]);
            }
            out.println("");
        }
        out.print("</pre>");


        out.println("<HR/>");
        out.println("Attributes:<BR/>");

        out.println( "<pre>");
        keys = request.getAttributeNames();
        while (keys.hasMoreElements()) {
            String key = (String)keys.nextElement();
            out.println(" Name: " + key);

            //To retrieve a single value
            String value = request.getAttribute(key).toString();
            out.println("Value: " + value);

            out.println("");
        }
        out.print("</pre>");


        out.println("<HR/>");
        out.println("Headers:<BR/>");

        out.println( "<pre>");
        keys = request.getHeaderNames();
        while (keys.hasMoreElements()) {
            String key = (String)keys.nextElement();
            out.println(" Name: " + key);

            Enumeration vals = request.getHeaders(key);
            while (vals.hasMoreElements()) {
                String val = (String)vals.nextElement();
                out.println("Value: " + val);
            }
            out.println("");
        }
        out.print("</pre>");

        out.println("<HR/>");
        out.println("Cookies:<BR/>");
        

        Cookie[] cookies = request.getCookies();
        if ((null != cookies) && (cookies.length > 0)) {
            out.println( "<pre>");
            for (int i = 0; i < cookies.length; i++) {
                Cookie c = cookies[i];
                out.println(" Name: " + c.getName());
                out.println("Value: " + c.getValue());
                out.println("");
            }
            out.println( "</pre>");
        }

        out.println( "<HR/>");
        out.println( "Session information:<BR/>" );

        HttpSession session = request.getSession(false);
        if ( session == null ) {
            out.println( "Session NOT yet created." );
        }
        else {
            out.println( "<pre>");
            Enumeration sessionAttrNames;

            sessionAttrNames = session.getAttributeNames();
            while (sessionAttrNames.hasMoreElements()) {
                String name = (String)sessionAttrNames.nextElement();
                out.println(" Name: " + name);
                
                Object val = session.getAttribute(name);
                
                out.println(" Type: " + val.getClass().toString() );
                out.println("Value: " + val.toString() );
            }
            out.println("</pre>");
        }
        
        
    }
    
    public void foo() {
        Set<Principal> principals = weblogic.security.Security.getCurrentSubject().getPrincipals();
        if ( null != principals )
        {
                System.out.println( "Current subject principals: " + weblogic.security.Security.getCurrentSubject().getPrincipals().toString() );
    
                Iterator it = principals.iterator();
                while ( it.hasNext() )
                {
                        Principal p = (Principal) it.next();
                        // This is kinda pointless
                        if ( p instanceof weblogic.security.principal.WLSGroupImpl )
                        {
                                //weblogic.security.principal.WLSGroupImpl gi = (weblogic.security.principal.WLSGroupImpl) p;
                                
                                System.out.println( "Principal name: " + p.getName() );
                                System.out.println( "Principal class: " + p.getClass().toString() );
                        }
                }
        }
    }
    
    
    public static String getServerHostname() {
        String hostname = "unknown";
        try {
            hostname = java.net.InetAddress.getLocalHost().getHostName();
        } catch (UnknownHostException e) {
        }
        
        return hostname;
    }
    
    private static String ATTRNAME = "RequestCount";
    
    static public int getRequestCount(HttpSession session ) throws IOException {
        Object o = session.getAttribute( ATTRNAME );
        Integer count = 0;
        
        if ( null == o ) {
            // count is null
            // do nothing.
        }
        else {
            count = (Integer) o;
            count += 1;
        }

        session.setAttribute(ATTRNAME, count);

        return count;
    }
    
    public static String getServerName() {
        // it may be better to do
        // System.getProperty("weblogic.Name");
        
        String serverName = "Unknown";  
        try {  
            InitialContext myCtx = new InitialContext();
            MBeanHome mbeanHome = (MBeanHome) myCtx.lookup("weblogic.management.home.localhome");
            serverName = mbeanHome.getMBeanServer().getServerName();            
        }  
        catch (Exception e) {  
            //throw new JspException (e);
            // do nothing
        }  
          
        if (serverName == null) serverName = "";  
          
        //getJspContext().getOut().println(serverName);  
        return serverName;
    }
    
}
