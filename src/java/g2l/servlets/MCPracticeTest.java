package g2l.servlets;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import g2l.dao.ExamDAO;
import g2l.dao.QuestionDAO;
import g2l.util.GPMember;
import g2l.util.MCQuestion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author upendraprasad
 */
public class MCPracticeTest extends HttpServlet {

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
            act = "practice";
        }
        if (act.equalsIgnoreCase("practice")) {
            offerTest(request, response);
        }
        if (act.equalsIgnoreCase("getJSON")) {
            offerJSON(request, response);
        }
        if (act.equalsIgnoreCase("submit")) {
            savePractice(request, response);
        }
        //processRequest(request, response);
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
     * Returns a short description of the servlet. s
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    // </editor-fold>
    
    protected void offerTest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tagPar = request.getParameter("tags");
        System.out.println("tags: " + tagPar);
        String qType = request.getParameter("subSelect");
        System.out.println("qType: " + qType);
        String qSource = request.getParameter("qSource");
        System.out.println("qSource: " + qSource);
        String qStatus = request.getParameter("qStatus");
        System.out.println("qStatus " + qStatus);
        String qProvider = request.getParameter("qProvider");
        System.out.println("qProvider " + qProvider);
        String fromDate = request.getParameter("qAprvlDate");
        System.out.println("From Date " + fromDate);

        GPMember gm = (GPMember) request.getSession().getAttribute("member");
        if (qProvider != null) {
            qProvider = gm.getId();
        }

        MCQuestion qb;
        List<MCQuestion> qBeans = null;
        QuestionDAO qd = new QuestionDAO();
        try {
            //qSource="";
            qBeans = qd.fetchQuestions(qType, qSource, tagPar, qProvider, "5", fromDate,40, true,true);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        }

        JSONArray qDB = new JSONArray();
        JSONObject qObj;

        for (int i = 0; i < qBeans.size(); i++) {
            qb = qBeans.get(i);
            qObj = new JSONObject();
            qObj.put("qId", qb.getqId());
            qObj.put("qText", qb.getqText());
            qObj.put("ansA", qb.getAnsA());
            qObj.put("ansB", qb.getAnsB());
            qObj.put("ansC", qb.getAnsC());
            qObj.put("ansD", qb.getAnsD());
            qObj.put("ansE", qb.getAnsE());
            qObj.put("ansCorr", qb.getAnsCorrect());
            qObj.put("choice", "");
            qObj.put("figName", qb.getFigure().getFigSaveName());
            qDB.put(qObj);
        }

        request.setAttribute("strQList", qDB.toString());
        System.out.println("Data Returned for Preview: " + qDB.toString());
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/mcPracticeTest1.jsp");
        rd.forward(request, response);
    }
    
    protected void offerJSON(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      System.out.println("Query String: "+request.getQueryString());
        String tagPar = request.getParameter("tags");        System.out.println("tags: " + tagPar);
        String qType = request.getParameter("subSelect");        System.out.println("qType: " + qType);
        String qSource = request.getParameter("qSource");        System.out.println("qSource: " + qSource);
        String qStatus = request.getParameter("qStatus");        System.out.println("qStatus " + qStatus);
        String qProvider = request.getParameter("qProvider");        System.out.println("qProvider " + qProvider);
        String fromDate = request.getParameter("qAprvlDate");        System.out.println("From Date " + fromDate);
        String maxNumQ = request.getParameter("maxNumQ");        System.out.println("maxNumQ " + maxNumQ);
        String chkMem = request.getParameter("chkMem");        System.out.println("chkMem " + chkMem);
        String chkCMark = request.getParameter("chkCMark");        System.out.println("chkCMark " + chkCMark);
        String chkFlash = request.getParameter("chkFlash");        System.out.println("chkFlash " + chkFlash);
        String chkAccordion = request.getParameter("chkAccordion");        System.out.println("chkAccordion " + chkAccordion);
        
       

        GPMember gm = (GPMember) request.getSession().getAttribute("member");
        boolean isMemPlus = false;
        boolean isCheck = false;
        
        
        if (chkMem != null) {
            isMemPlus = true;
            qProvider = gm.getId();
        }
        
        if (chkCMark != null) {
            isCheck = true;
            qProvider = gm.getId();
        }
        
        if (qProvider != null || isMemPlus || isCheck ) {// Only the entries of the user
            qProvider = gm.getId();
        }

        
        List<MCQuestion> qBeans = null;
        QuestionDAO qd = new QuestionDAO();
        try {
            //qSource="";
            qBeans = qd.fetchQuestions(qType, qSource, tagPar, qProvider, qStatus, fromDate, Integer.parseInt(maxNumQ), isMemPlus, isCheck);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        }
/*
        JSONArray qDB = new JSONArray();
        JSONObject qObj;
        MCQuestion qb;

        for (int i = 0; i < qBeans.size(); i++) {
            qb = qBeans.get(i);
            qObj = new JSONObject();
            qObj.put("qId", qb.getqId());
            qObj.put("qText", qb.getqText());
            qObj.put("ansA", qb.getAnsA());
            qObj.put("ansB", qb.getAnsB());
            qObj.put("ansC", qb.getAnsC());
            qObj.put("ansD", qb.getAnsD());
            qObj.put("ansE", qb.getAnsE());
            qObj.put("ansCorr", qb.getAnsCorrect());
            qObj.put("choice", "");
            qObj.put("checkMarked", "0");
            qObj.put("figName", qb.getFigure().getFigSaveName());
            qDB.put(qObj);
        }*/
        response.setContentType("text/json");
        PrintWriter out = response.getWriter();
        try {
            out.println(getStringJSON(qBeans));
        } finally {
            out.close();
        }
    }
    
    protected void savePractice(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
      String checked = request.getParameter("checked");         String [] chkIds = checked.trim().split(";");
      String unchecked = request.getParameter("unchecked");      String [] unchkIds = unchecked.trim().split(";");
      String ansRight = request.getParameter("right");        String [] rightQid = ansRight.trim().split(";");
      String ansWrong = request.getParameter("wrong");       String [] wrongQid = ansWrong.trim().split(";");
      
      String allQids = checked.concat(unchecked); System.out.println("allQids: "+allQids);
        String [] qIds = allQids.split(";");
      ExamDAO ed = new ExamDAO();
      GPMember member = (GPMember)request.getSession().getAttribute("member");
      int rows = 0;
    try {
        rows += ed.initPracticeData(member.getId(), qIds);
      rows += ed.savePracticeCheck(member.getId(),chkIds,"1");
      rows += ed.savePracticeCheck(member.getId(),unchkIds,"0");
      rows += ed.savePractice(member.getId(),rightQid,true);
      rows += ed.savePractice(member.getId(),wrongQid,false);
    } catch (Exception ex) {
      Logger.getLogger(MCPracticeTest.class.getName()).log(Level.SEVERE, null, ex);
    } 
      response.getWriter().print("Number of entries updated: "+rows);
    }
    
    protected String getStringJSON(List<MCQuestion> qBeans){
        JSONArray qDB = new JSONArray();
        JSONObject qObj;
        MCQuestion qb;

        for (int i = 0; i < qBeans.size(); i++) {
            qb = qBeans.get(i);
            qObj = new JSONObject();
            qObj.put("qId", qb.getqId());
            qObj.put("qText", qb.getqText());
            qObj.put("ansA", qb.getAnsA());
            qObj.put("ansB", qb.getAnsB());
            qObj.put("ansC", qb.getAnsC());
            qObj.put("ansD", qb.getAnsD());
            qObj.put("ansE", qb.getAnsE());
            qObj.put("ansCorr", qb.getAnsCorrect());
            qObj.put("choice", "");            
            if(qb.isChecked()){qObj.put("checkMarked", "1");}
            else{qObj.put("checkMarked", "0");}
            qObj.put("figName", qb.getFigure().getFigSaveName());
            qDB.put(qObj);
        }
        return qDB.toString();
    }
}
