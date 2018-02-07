/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataAccess;
import g2l.dao.DataEntry;
import g2l.dao.QuestionDAO;
import g2l.util.GPMember;
import g2l.util.MCQuestion;
import g2l.util.TestMC;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
public class MCTestGen extends HttpServlet {

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
        int level = 1;
        String stage = request.getParameter("stage");
        if (stage != null) {
            level = Integer.parseInt(stage);
        }


        switch (level) {
            case 1:
                supplyQDB(request, response);
                break;

            case 2:
                showTestPreview(request, response);
                break;

            case 3:
                createTest(request, response);
                break;

            case 4:
                showDescription(request, response);
                break;

            case 5:
                changeDescription(request, response);
                break;

            default:
                response.sendRedirect("ErrorPage.jsp");

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
     * Processes requests for Generation of a test by providing questions to
     * choose from.
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void supplyQDB(HttpServletRequest request, HttpServletResponse response)
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
        
        int limitQNum = 100;

        GPMember gm = (GPMember) request.getSession().getAttribute("member");
        if (qProvider != null) {
            qProvider = gm.getId();
        }
      //  String figName = "";
        MCQuestion qb;
        List<MCQuestion> qBeans = null;
        QuestionDAO qd = new QuestionDAO();
        try {
            //qSource="";
            qBeans = qd.fetchGateway(qType, qSource, tagPar, qProvider, "5", fromDate, limitQNum, false,false);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("qList", qBeans);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/mcTestChoose.jsp");
        rd.forward(request, response);
    }

    /**
     * Processes requests for Generation of a test by creating a test.
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void showTestPreview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String qids = request.getParameter("selectedQ");

        QuestionDAO qd = new QuestionDAO();

        System.out.println("Selected Questions: " + qids);

        String[] qidList = qids.split(";");

        List<MCQuestion> qBeans = null;
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
            qObj.put("figName", qb.getFigure().getFigSaveName());
            qDB.put(qObj);
        }

        request.setAttribute("selectedQ", qids);
        request.setAttribute("strQList", qDB.toString());
        System.out.println("Data Returned for Preview: " + qDB.toString());
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/mcTestPreview.jsp");
        rd.forward(request, response);
    }

    /**
     * Processes requests for Generation of a test by providing questions to
     * choose from.
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void createTest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String selQ = request.getParameter("selectedQ");

        TestMC mcTest = new TestMC();

        GPMember gpm;
        gpm = (GPMember) request.getSession().getAttribute("member");

        mcTest.setUserId(gpm.getId());
        mcTest.setTestDuration(30);
        mcTest.setTestStatus("1"); //Just created status
        mcTest.setqIds(selQ);

        String testId = "";

        DataEntry de = new DataEntry();
        try {
            testId = de.createNewTest(mcTest);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("testId", testId);
        /*request.setAttribute("creator", gpm.getName());
        request.setAttribute("testStatus", mcTest.getTestStatus());
        request.setAttribute("duration", mcTest.getTestDuration());
        request.setAttribute("fromDate", mcTest.getDateFrom());
        request.setAttribute("toDate", mcTest.getDateTo());
        request.setAttribute("creationDate", mcTest.getDateCreated());
        request.setAttribute("description", mcTest.getDescription());*/
        
        //RequestDispatcher rd = getServletContext().getRequestDispatcher("/mcTestDesc.jsp");
        //rd.forward(request, response);
        showDescription(request, response);

    }

    /**
     * Processes requests for Generation of a test by providing questions to
     * choose from.
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void showDescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        TestMC mcTest = new TestMC();

        GPMember gpm;
        gpm = (GPMember) request.getSession().getAttribute("member");        

        String testId = request.getParameter("testId");
        if(testId==null){ testId = (String)request.getAttribute("testId");}

        mcTest.setUserId(gpm.getId());
        mcTest.setTestId(testId);

        DataAccess da = new DataAccess();
        try {
            mcTest = da.fetchTestMC(testId);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        }
        /*request.setAttribute("testId", testId);        
        request.setAttribute("testStatus", mcTest.getTestStatus());
        request.setAttribute("duration", mcTest.getTestDuration());
        request.setAttribute("fromDate", mcTest.getDateFrom());
        request.setAttribute("toDate", mcTest.getDateTo());
        request.setAttribute("creationDate", mcTest.getDateCreated());
        request.setAttribute("description", mcTest.getDescription());*/
        
        request.setAttribute("creator", gpm.getName());
        request.setAttribute("mcTest", mcTest);
        
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/mcTestDesc.jsp");
        rd.forward(request, response);

    }

    /**
     * Processes requests for Generation of a test by providing questions to
     * choose from.
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void changeDescription(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
            TestMC mcTest = new TestMC();

            GPMember gpm;
            gpm = (GPMember) request.getSession().getAttribute("member");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");

            String testId = request.getParameter("testId");

            mcTest.setTestId(testId);
            mcTest.setTestStatus("2");
            mcTest.setTestTitle(request.getParameter("testTitle"));
            mcTest.setDescription(request.getParameter("testDesc"));
            mcTest.setTestDuration(Integer.parseInt(request.getParameter("testDuration")));
            try {
                mcTest.setDateFrom(sdf.parse(request.getParameter("testAvailFrom")));
                mcTest.setDateTo(sdf.parse(request.getParameter("testAvailTo")));
            } catch (ParseException ex) {
                Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
            }

            DataEntry de = new DataEntry();
            try {
                de.updateTest(mcTest);
            } catch (SQLException ex) {
                Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
            } catch (NamingException ex) {
                Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        request.setAttribute("creator", gpm.getName());
        request.setAttribute("mcTest", mcTest);
        
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/mcTestDesc.jsp");
        rd.forward(request, response);


        }
        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
    @Override
        public String getServletInfo(){
        return "Short description";
        }// </editor-fold>
    }
