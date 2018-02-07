/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataAccess;
import g2l.dao.QuestionDAO;
import g2l.util.GPMember;
import g2l.util.GameFigure;
import g2l.util.MCQuestion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author upendraprasad
 */
public class QuestionEdit extends HttpServlet {

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
            out.println("<title>Servlet QuestionEdit</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuestionEdit at " + request.getContextPath() + "</h1>");
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
        String act = request.getParameter("act");

        if (act == null) {
            act = "start";
        }

        if (act.equalsIgnoreCase("start")) {
            supplyQDB(request, response);
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

        GPMember gm = (GPMember) request.getSession().getAttribute("member");
        if (qProvider != null) {
            qProvider = gm.getId();
        }
        String figName = "";
        MCQuestion qb;
        List<MCQuestion> qBeans = null;
        QuestionDAO qd = new QuestionDAO();
        try {
            //qSource="";
            qBeans = qd.fetchQuestions(qType, qSource, tagPar, qProvider, qStatus, fromDate,200, false,false);
        } catch (NamingException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(MCTestGen.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        GPMember gpm = (GPMember) request.getSession().getAttribute("member");
        if (gpm == null) {
            try {
                response.sendRedirect("ErrorPage.jsp");
            } catch (IOException ex) {
                Logger.getLogger(FigManager.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        DataAccess da = new DataAccess();
        String allTags = "";
        String allSources = "";
        List<GameFigure> allFigures = new ArrayList<GameFigure>();
        try {
            allTags = da.getAllQTags();//System.out.println("Tags Fetched");
            allSources = da.getAllQSources();  //System.out.println("Sources Fetched");
            allFigures = da.getAllFigures(gpm.getId());
        } catch (NamingException ex) {
            Logger.getLogger(QuestionEntry.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(QuestionEntry.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("allTags", allTags);
        request.setAttribute("allSources", allSources);
        request.setAttribute("allFig", allFigures);

        request.setAttribute("qList", qBeans);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/editQuestion.jsp");
        rd.forward(request, response);
    }
}
