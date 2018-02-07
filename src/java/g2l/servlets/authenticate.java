/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataAccess;
import g2l.dao.DataEntry;
import g2l.util.GPMember;
import g2l.util.HashCoder;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author upendraprasad
 */
public class authenticate extends HttpServlet {

    String strMsg;

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet authenticate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Still Under Construction</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    }
    
        @Override
    public void init() throws ServletException
    {
          /// Automatically java script can run here
          System.out.println("*** Authentication Servlet Initialized ***");

          
         //Enumeration<String> initPara =  this.getInitParameterNames();


    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String queryType = request.getParameter("queryType");
        if(queryType==null || queryType.equalsIgnoreCase("")){queryType ="login";}

        if (queryType.equalsIgnoreCase("login")) {
            loginUser(request, response);
        }
        if (queryType.equalsIgnoreCase("logout")) {
            logoutUser(request, response);
        }
        if (queryType.equalsIgnoreCase("signup")) {
            signupUser(request, response);
        }
        if (queryType.equalsIgnoreCase("enroll")) {
            enrollUsers(request, response);
        }
        if (queryType.equalsIgnoreCase("forgot")) {
            loginHelp(request, response);
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    protected void loginUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String userPass = request.getParameter("userPass");
        try {
             userPass = HashCoder.encode(userPass); // Fidn the message digest (hash code) of the password
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        }
        

        try {

            DataAccess da = new DataAccess();
            if (!da.existingLogin(userId)) {
                //strMsg = "Incorrect user id. Please Try again.";
                response.sendRedirect("/g2l/index.jsp?status=2");
            } else {
                GPMember newMember = da.fetchMember(userId,"");
                if (newMember.getPassword().equals(userPass)) {  //System.out.println("Trying login: " + newMember.getName());
                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("member", newMember);
                    if(newMember.getUserType().equalsIgnoreCase("10")){
                        response.sendRedirect("/g2l/student/index.html");
                    }else{
                            response.sendRedirect("/g2l/login/user_account.jsp");
                            }
                    
                } else {
                    strMsg = "Incorrect Password. Please Try again.";
                    response.sendRedirect("/g2l/index.jsp?status=0");
                }
            }

        } catch (Exception ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("ErrorPage.jsp");
        }

    }

    protected void logoutUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession();

        httpSession.removeAttribute("member");
        httpSession.invalidate();
        //strMsg = "You have been successfully signed out.";
        strMsg = "You have successfully signed out.";
        response.sendRedirect("/g2l/index.jsp?status=9");
    }

    protected void loginHelp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String signupPass = request.getParameter("signupPass1");
        String userEmail = request.getParameter("email");
        
        String signupHash="";

        try {
            signupHash = HashCoder.encode(signupPass); //System.out.println("New User Creation: "+signupHash);
            //String userQ1 = request.getParameter("userQ1");
            //String userAns1 = request.getParameter("userAns1");
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        }

         response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String memberId = "";

        DataEntry de = new DataEntry();
        GPMember newMember = new GPMember();
      
        newMember.setPassword(signupHash);
     
        newMember.setUserType("10");
        newMember.setEmail(userEmail);
        newMember.setToken(token);
        
        DataAccess da = new DataAccess();
        try {
            if (da.existingUser(userEmail)) {
                 //"A user with this email exists already.";
               // response.sendRedirect("/g2l/index.jsp?status=9&message=" + strMsg);
                    try {
                        int count = de.changeUserPass(newMember);
                        if(count>0){out.println("<h4>Success: Your password has been changed. Click on Home to login.</h4>");}
                        else {out.println("<h4>Fail: Possibly an incorrect token.</h4>");}
                           //"You are now signed up. Please login.";
                       // response.sendRedirect("/g2l/index.jsp?status=10&message=" + strMsg);
                    } catch (NamingException ex) {
                        Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (SQLException ex) {
                        Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    //strMsg = "SUCCESS: "+strMsg;
                    //response.sendRedirect("/g2l/index.jsp?status=10&message=" + strMsg);
                    
                }
            else{
              out.println("<h4>Fail: No user with given email.</h4>");
            }
            
        } catch (NamingException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        }
            
        
    }
    
    protected void signupUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String signupId = request.getParameter("signupId");
        String signupPass = request.getParameter("signupPass1");
        String userEmail = request.getParameter("email");
        
         String signupHash="";

        try {
            signupHash = HashCoder.encode(signupPass); System.out.println("New User Creation: "+signupHash);
            //String userQ1 = request.getParameter("userQ1");
            //String userAns1 = request.getParameter("userAns1");
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        }



        String memberId = "";

        DataEntry de = new DataEntry();
        GPMember newMember = new GPMember();
        newMember.setLogin(signupId);
        newMember.setPassword(signupHash);
        newMember.setName(userName);
        newMember.setUserType("10");
        newMember.setEmail(userEmail);
        
        DataAccess da = new DataAccess();
        try {
            if (da.existingLogin(signupId)) {
                strMsg = "11"; //"This login name exists already.";
               // response.sendRedirect("/g2l/index.jsp?status=9&message=" + strMsg);
            }else
            if (da.existingUser(userEmail)) {
                strMsg = "12"; //"A user with this email exists already.";
               // response.sendRedirect("/g2l/index.jsp?status=9&message=" + strMsg);
            }else{
                    try {
                        memberId = de.createNewUser(newMember);
                        strMsg = "10";   //"You are now signed up. Please login.";
                       // response.sendRedirect("/g2l/index.jsp?status=10&message=" + strMsg);
                    } catch (NamingException ex) {
                        Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (SQLException ex) {
                        Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    //strMsg = "SUCCESS: "+strMsg;
                    //response.sendRedirect("/g2l/index.jsp?status=10&message=" + strMsg);
                    
                }
            String path = "index.jsp?status="+strMsg;
            RequestDispatcher rd = request.getRequestDispatcher(path);
            rd.forward(request, response);
        } catch (NamingException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        }
                 

    }
    
    protected void enrollUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String loginPasswords = request.getParameter("loginPasswords");
        String signupId = request.getParameter("signupId");
        String signupPass = request.getParameter("signupPass1");
        String userEmail = request.getParameter("email");
        
        String[] loginPass = loginPasswords.split(";");
        
        
         String signupHash="";

        try {
            signupHash = HashCoder.encode(signupPass);
            //String userQ1 = request.getParameter("userQ1");
            //String userAns1 = request.getParameter("userAns1");
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        }



        String memberId = "";

        DataEntry de = new DataEntry();
        GPMember newMember = new GPMember();
        newMember.setLogin(signupId);
        newMember.setPassword(signupHash);
        newMember.setName(userName);
        newMember.setUserType("10");
        newMember.setEmail(userEmail);
        
        DataAccess da = new DataAccess();
        try {
            if (da.existingLogin(signupId)) {
                strMsg = "This login name exists already.";
               // response.sendRedirect("/g2l/index.jsp?status=9&message=" + strMsg);
            }else
            if (da.existingUser(userEmail)) {
                strMsg = "A user with this email exists already.";
               // response.sendRedirect("/g2l/index.jsp?status=9&message=" + strMsg);
            }else{
                    try {
                        memberId = de.createNewUser(newMember);
                        strMsg = "You are now signed up. Please login.";
                       // response.sendRedirect("/g2l/index.jsp?status=10&message=" + strMsg);
                    } catch (NamingException ex) {
                        Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (SQLException ex) {
                        Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    //strMsg = "SUCCESS: "+strMsg;
                    response.sendRedirect("/g2l/index.jsp?status=10&message=" + strMsg);
                }
        } catch (NamingException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        }
                 

    }
    

    protected void signupUserOld(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String signupId = request.getParameter("signupId");
        String signupPass = request.getParameter("signupPass");
        String userEmail = request.getParameter("email");

        //String userQ1 = request.getParameter("userQ1");
        //String userAns1 = request.getParameter("userAns1");



        String memberId = "";

        DataEntry de = new DataEntry();
        GPMember newMember = new GPMember();
        newMember.setLogin(signupId);
        newMember.setPassword(signupPass);
        newMember.setName(userName);
        newMember.setUserType("10");
        newMember.setEmail(userEmail);
        try {
            memberId = de.createNewUser(newMember);
            strMsg = "You are now signed up. Please login.";
            response.sendRedirect("/g2l/index.jsp?status=10&message=" + strMsg);
        } catch (NamingException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
        }
        strMsg = "Signup Unsuccessful";
        response.sendRedirect("/g2l/index.jsp?status=10&message=" + strMsg);

    }
    
    
}
