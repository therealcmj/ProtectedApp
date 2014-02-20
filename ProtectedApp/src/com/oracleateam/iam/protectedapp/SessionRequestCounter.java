package com.oracleateam.iam.protectedapp;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;


public class SessionRequestCounter {
    public SessionRequestCounter() {
        super();
    }
    
    private static String ATTRNAME = "RequestCount";
    
    static public int getCount(JspWriter out, HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            out.println("Session NOT yet created.");
        }

        Object o = session.getAttribute( ATTRNAME );
        Integer count = 1;
        
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

}
