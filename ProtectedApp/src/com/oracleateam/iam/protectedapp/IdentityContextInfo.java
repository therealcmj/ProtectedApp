package com.oracleateam.iam.protectedapp;

import oracle.security.idm.IdentityContext.Context;
import oracle.security.idm.IdentityContext.ContextException;


public class IdentityContextInfo {
    public IdentityContextInfo() {
        super();
    }
    
    public String getClaimsContent(String subj) {
        String ret = null;

        try {
            Context ctx = new Context(subj);
            
            ret = ctx.showContents();
        }
        catch (ContextException e) {
            System.out.println( "ContextException caught" );
            e.printStackTrace();
        }
        
        return ret;
    }
}
