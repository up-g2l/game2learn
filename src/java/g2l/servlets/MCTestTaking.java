/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataAccess;
import g2l.dao.DataEntry;
import g2l.dao.ExamDAO;
import g2l.dao.QuestionDAO;
import g2l.util.GPMember;
import g2l.util.MCQuestion;
import g2l.util.TestMC;
import g2l.util.UserTest;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author upendraprasad
 */
public class MCTestTaking extends HttpServlet {
    
    @Override
    public void init() throws ServletException
    {
          /// Automatically java script can run here
          System.out.println("*** MCTestTaking Servlet Initialized successfully ***");
;
          
         //Enumeration<String> initPara =  this.getInitParameterNames();


    }

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
            out.println("<title>Servlet MCTest</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>No valid request option for service has been provided.</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
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
        String act = request.getParameter("activity");
        if (act == null) {
            act = "";
        }
        
        if (act.equalsIgnoreCase("userTests")) {
            provideUserTestInfo(request, response);
        }
        
        if (act.equalsIgnoreCase("testInfo")) {
            provideTestInfo2(request, response);
        }
        if (act.equalsIgnoreCase("testTake")) {
            offerTest(request, response);
        }
        if (act.equalsIgnoreCase("saveTestAns")) {
            offerTest(request, response);
        }
        if (act.equalsIgnoreCase("submit")) {
            submitTest(request, response);
        }
        processRequest(request, response);
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
        doGet(request,response);
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet. s
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    protected void provideTestInfo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String testId = request.getParameter("testId");
        
        DataAccess da =new DataAccess();       
        
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            TestMC mcTest =  da.fetchTestMC(testId);
            /* TODO output your page here. You may use following sample code. */
            out.println("<p>Test Details</p><table>");
            out.println("<tr><td style=\"width:50px;\">Test Id</td><td>"+testId+"</td></tr>");
            out.println("<tr><td> Duration</td><td>"+mcTest.getTestDuration()+"</td></tr>");
            out.println("<tr><td>Test Creator</td><td>"+mcTest.getUserId()+"</td></tr>");
            out.println("<tr><td>Available From</td><td>"+mcTest.getDateFrom().toString()+"</td></tr>");
            out.println("<tr><td>Available Until </td><td>"+mcTest.getDateTo().toString()+"</td></tr>");
            out.println("</table>");
        }catch(Exception e){out.println("<p>Failure in Data Access</p>");}
        finally {            
            out.close();
        }
    }
    
    protected void provideUserTestInfo(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
        
        DataAccess da =new DataAccess();       
        
        HttpSession httpSession = request.getSession();
        GPMember gpm = (GPMember) httpSession.getAttribute("member");
        
        JSONObject jut;
        
        JSONArray jsonUTs = new JSONArray();
        List<UserTest> listUserTests;
                UserTest ut;
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        
        String html =   "        <table class=\"table table-sm\">\n" +
                        "            <thead>\n" +
                        "              <tr>\n" +
                        "                <th style='width:60%'>ID: Title</th>\n" +
                        "                <th>Status</th>\n" +
                        "                <th>Score</th>\n" +
                        "              </tr>\n" +
                        "            </thead>\n" +
                        "            <tbody>\n";
                        

                        
        
        try {
             listUserTests =  da.fetchUserTests(gpm.getId());
            for (UserTest listUserTest : listUserTests) {
                ut = listUserTest;
                jut = new JSONObject();
                jut.put("testId", ut.getTestMC().getTestId());
                jut.put("score",ut.getScore());
                jut.put("status",ut.getStatus());
                jut.put("testTitle",ut.getTestMC().getTestTitle());
                jut.put("testDesc",ut.getTestMC().getDescription());
                // jut.put("testFinished", "")
                html = html + "         <tr>\n" +
                        "                <td>"+ut.getTestMC().getTestId()+": "+ut.getTestMC().getTestTitle()+"</td>\n" +
                        "                <td>"+ut.getStatus()+"</td>\n" +
                        "                <td> "+String.valueOf(ut.getScore())+" </td>\n" +
                        "              </tr>\n";
                jsonUTs.put(jut);          
            }

        }catch(Exception e){out.println("<h4>Failure in fetching data.</h4>");}
        
        html = html + "            </tbody>\n" +
                        "        </table>";

        try {
            out.println(html);
        } finally {
            out.close();
        }
      
    }
            
        protected void provideTestInfo2(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String testId = request.getParameter("testId");System.out.println("testId:"+testId);
        
        DataAccess da =new DataAccess();       
        
        JSONObject jsonTest = new JSONObject();
        
        
        response.setContentType("text/json");
        PrintWriter out = response.getWriter();
        try {
            TestMC mcTest =  da.fetchTestMC(testId);
            GPMember newMember = da.fetchMemberById(mcTest.getUserId());System.out.println(newMember.getName());
            
            jsonTest.put("testId",testId);
            jsonTest.put("testTitle",mcTest.getTestTitle());
            jsonTest.put("testDesc",mcTest.getDescription());
            jsonTest.put("testDuration",mcTest.getTestDuration());
            jsonTest.put("testCreator",newMember.getName());
            jsonTest.put("testFrom", mcTest.getDateFrom().toString());
            jsonTest.put("testTo", mcTest.getDateTo().toString());
            out.println(jsonTest.toString());

        }catch(Exception e){out.println("<p>Failure in Data Access</p>");}
        finally {            
            out.close();
        }
      
    }

    protected void offerTest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String testId = request.getParameter("testId");
        
        QuestionDAO qd = new QuestionDAO();
        DataAccess da = new DataAccess();
        
        HttpSession httpSession = request.getSession();
        GPMember gm = (GPMember) httpSession.getAttribute("member");
        
        ExamDAO ed = new ExamDAO();
        try {
            ed.createUserTestEntry(gm.getId(), testId);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestTaking.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestTaking.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        TestMC tmc=null;
        try {
            tmc = da.fetchTestMC(testId);
            
        } catch (SQLException ex) {
            Logger.getLogger(MCTestTaking.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestTaking.class.getName()).log(Level.SEVERE, null, ex);
        }
        System.out.println("Selected Questions: " + tmc.getqIds());

        String[] qidList = tmc.getqIdList();

        List<MCQuestion> qBeans=null;
        try {
            qBeans = qd.fetchQuestionsByIdList(qidList);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        }

        JSONArray qDB = new JSONArray();
        JSONObject qObj;
        MCQuestion qb;
        
        HashMap qhm = new HashMap();

        for (int i = 0; i < qBeans.size(); i++) {
            qb = qBeans.get(i);
            if(!qhm.containsKey(qb.getSimQid())){
                qhm.put(qb.getSimQid(), qb);
                qObj = new JSONObject();
                qObj.put("qId", qb.getqId());
                qObj.put("qText", qb.getqText());
                qObj.put("ansA", qb.getAnsA());
                qObj.put("ansB", qb.getAnsB());
                qObj.put("ansC", qb.getAnsC());
                qObj.put("ansD", qb.getAnsD());
                qObj.put("ansE", qb.getAnsE());
                qObj.put("ansCorr", qb.getAnsCorrect());
                qObj.put("choice","");
                qObj.put("figName", qb.getFigure().getFigSaveName());
                qDB.put(qObj);
            }            
            
        }
        
        response.setContentType("text/json");
        PrintWriter out = response.getWriter();
        try {
            out.println(qDB.toString());
        } finally {
            out.close();
        }
        

       /* request.setAttribute("selectedQ", tmc.getqIds());
        request.setAttribute("strQList", qDB.toString());System.out.println("Question list as JSON: " +qDB.toString());
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/mcTestTaking.jsp");
        rd.forward(request, response);*/
    }

    protected void submitTest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession httpSession = request.getSession();
        GPMember gm = (GPMember) httpSession.getAttribute("member");
       // String userId = request.getParameter(gm.getId());
        String testId = request.getParameter("testId");
        String ansList = request.getParameter("answers");
        String score = request.getParameter("points");
        
        System.out.println("Score: "+score);
        
        ExamDAO ed =  new ExamDAO();
        int rows=0;
        try {
            rows = ed.saveTest(gm.getId(), testId, score, ansList);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestTaking.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestTaking.class.getName()).log(Level.SEVERE, null, ex);
        }
     
    
        String[] allAnswers =  ansList.split(ansList, 1);
        PrintWriter out = response.getWriter();
        
        
        response.setContentType("text/html;charset=UTF-8");
         try {
            /* TODO output your page here. You may use following sample code. */
            if(rows!=0){
            out.println("<h3 class=\"alert alert-success\" role=\"alert\">(x) Your test has been successfully saved. Click on home to go back to your homepage.</h3>");
            }            
            else{out.println("<h3 class=\"alert alert-danger\" role=\"alert\"> Failure in saving test data.</h3>");}
        } finally {            
            out.close();
        }
    }
}
