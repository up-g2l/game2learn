/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

import java.util.ArrayList;
import java.util.StringTokenizer;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author upendraprasad
 */
public class SessionFilter implements Filter
{
private FilterConfig filterConfig;

private ArrayList<String> urlList;


public void doFilter (ServletRequest request,ServletResponse response,FilterChain chain)
       throws java.io.IOException, ServletException{
    HttpSession httpSesn;
    HttpServletRequest req=(HttpServletRequest)request;
    HttpServletResponse res=(HttpServletResponse)response;
    String status;
    
    String url = req.getServletPath();
    //System.out.println("From Session Filter, url:"+url);
    boolean allowedRequest = false;         
         
    if(urlList.contains(url)) {  
        allowedRequest = true; System.out.println("An allowed Request.");
    }
    httpSesn = req.getSession(true);
    
    if(!allowedRequest && httpSesn.isNew()){ System.out.println("Not an allowed request and a news session. So redirecting...");
       
             res.sendRedirect("/g2l/index.jsp?status=3");
       }    
        chain.doFilter(req, res);
    

  /*  if (!allowedRequest) {

        if (null == httpSesn) {
            res.sendRedirect("/g2l/index.jsp?status=10");//Session timed out. Redirect.
        }
    } 
    else{                      
            /*status = req.getParameter("status");
   
            System.out.println("Inside the session filter");
            if(httpSesn.isNew())
            {
                if(status==null)
                {
                   res.sendRedirect("/g2l/index.jsp?status=3"); //If the Active session is null ,we redirect to the timeout.jsp 
                 }else{res.sendRedirect("/g2l/index.jsp?status="+status);}
            }
        
                status = req.getParameter("status");
   
            System.out.print("Inside the session filter");
            if(httpSesn.isNew())
            {
                if(status==null)
                {System.out.println(", Status is null");
                   res.sendRedirect("/g2l/index.jsp?status=10"); // 
                 }
                else{
                     System.out.println(", Status is not null");
                    res.sendRedirect("/g2l/index.jsp?status="+status);}
            }
       }  */
  
}

public void init(FilterConfig fConfig) throws ServletException {
    
    this.filterConfig = fConfig;

    String urls = filterConfig.getInitParameter("avoid-urls");

    StringTokenizer token = new StringTokenizer(urls, ",");

    //StringTokenizer token = new StringTokenizer(urls);

    urlList = new ArrayList<String>();

  //  urlList.add(token.nextToken());

    while (token.hasMoreTokens()) {
        if(!urlList.add(token.nextToken())){ System.out.println("Problem in the session filter.");}

    }
}

    public void destroy() {
        this.filterConfig=null;
        throw new UnsupportedOperationException("Not supported yet.");
    }
      
}



