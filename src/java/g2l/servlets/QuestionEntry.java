/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataAccess;
import g2l.dao.DataEntry;
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
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 *
 * @author upendraprasad
 */
public class QuestionEntry extends HttpServlet {

    private ServletContext context;

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
    @Override
    public void init(ServletConfig config) throws ServletException {
        this.context = config.getServletContext();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet QuestionEntry</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuestionEntry at " + request.getContextPath() + "</h1>");
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
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {



        String act = request.getParameter("act");

        if (act == null) {
            act = "start";
        }

        if (act.equalsIgnoreCase("start")) {
            startProcess(request, response);
        }
        if (act.equalsIgnoreCase("save")) {
            saveQuestion(request, response);
        }
        if (act.equalsIgnoreCase("edit")) {
            editQuestion(request, response);
        }
        if (act.equalsIgnoreCase("getq")) {
            showQuestion(request, response);
        }
        if (act.equalsIgnoreCase("status")) {
            showQuestion(request, response);
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

    protected void startProcess(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Starting Question Entry Controller...");
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
        RequestDispatcher rd = context.getRequestDispatcher("/enterQ.jsp");
        rd.forward(request, response);
    }

    protected void saveQuestion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesn1 = request.getSession();

        GPMember member = (GPMember) sesn1.getAttribute("member");


        String qId = request.getParameter("qId");
        System.out.println("Questions ID:" + qId);
        /*String question = request.getParameter("question");  
         String qType = request.getParameter("subSelect");
         String ansA = request.getParameter("ansA");//System.out.println("ansA:"+ansA);
         String ansB = request.getParameter("ansB");//System.out.println("ansB:"+ansB);
         String ansC = request.getParameter("ansC");//System.out.println("ansC:"+ansC);
         String ansD = request.getParameter("ansD");//System.out.println("ansD:"+ansD);
         String ansE = request.getParameter("ansE");//System.out.println("ansE:"+ansE);
         String correct = request.getParameter("correct");//System.out.println("Correct:"+correct);
         String helpLink = request.getParameter("helpLink");//System.out.println("ansE:"+ansE);
         String tags = request.getParameter("tags");//System.out.println("ansE:"+ansE);
         String explanation = request.getParameter("explanation");//System.out.println("Explanation:"+explanation);
         String qSource = request.getParameter("source");
         String figId = request.getParameter("figId");
         String simQid = request.getParameter("simQid");*/

        MCQuestion qBean = new MCQuestion();
        qBean.setqText(request.getParameter("question"));
        qBean.setqType(request.getParameter("subSelect"));
        qBean.setAnsA(request.getParameter("ansA"));
        qBean.setAnsB(request.getParameter("ansB"));
        qBean.setAnsC(request.getParameter("ansC"));
        qBean.setAnsD(request.getParameter("ansD"));
        qBean.setAnsE(request.getParameter("ansE"));
        qBean.setAnsCorrect(request.getParameter("correct"));
        qBean.setExplanation(request.getParameter("explanation"));
        qBean.setHelpLink(request.getParameter("helpLink"));
        qBean.setTags(request.getParameter("tags"));
        qBean.setqId(qId);
        qBean.setProvider(member.getId());
        qBean.setSource(request.getParameter("source"));
        qBean.setFigId(request.getParameter("figId"));
        qBean.setSimQid(request.getParameter("simQid"));

        DataEntry de = new DataEntry();
        response.setContentType("text");
        try {
            if (qId.equals("0")) {
                qId = de.enterQuestion(qBean);
                if(qBean.getSimQid().equals("0")){de.updateQuestion(qBean);}
            } else {
                de.updateQuestion(qBean);
            }
            response.getWriter().write(qId);
        } catch (Exception ex) {
            response.getWriter().write("FAIL");
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, "Some error was encountered during question entry.", ex);
            //response.sendRedirect("ErrorPage.jsp");
        }

        //System.out.println("Question id:"+qId);





        //response.setCharacterEncoding("UTF-8");
        // response.setHeader("Cache-Control", "no-cache");

        System.out.println("Data Returned,qId " + qId);
    }

    protected void editQuestion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    protected void showQuestion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String targetId = request.getParameter("id");//System.out.println("id: "+targetId);

        MCQuestion qb = new MCQuestion();
        QuestionDAO qdao = new QuestionDAO();
        try {
            qb = qdao.fetchQuestionsById(targetId);
        } catch (Exception ex) {
            //Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("ErrorPage.jsp");
        }


        JSONObject qJSON;
        String strQJson = "";

        if (targetId != null) {
            targetId = targetId.trim().toLowerCase();
        } else {
            context.getRequestDispatcher("/error.jsp").forward(request, response);
        }

        if (!targetId.equals("")) {
            qJSON = new JSONObject();

            qJSON.put("GET", "PASS");
            qJSON.put("qText", qb.getqText());
            qJSON.put("qId", qb.getqId());
            qJSON.put("qType", qb.getqType());
            qJSON.put("ansA", qb.getAnsA());
            qJSON.put("ansB", qb.getAnsB());
            qJSON.put("ansC", qb.getAnsC());
            qJSON.put("ansD", qb.getAnsD());
            qJSON.put("ansE", qb.getAnsE());
            qJSON.put("ansCorr", qb.getAnsCorrect());
            qJSON.put("explanation", qb.getExplanation());
            qJSON.put("helpLink", qb.getHelpLink());
            qJSON.put("provider", qb.getProvider());
            qJSON.put("source", qb.getSource());
            qJSON.put("tags", qb.getTags());
            qJSON.put("status", qb.getqStatus());
            qJSON.put("figId", qb.getFigId());
            qJSON.put("figName", qb.getFigure().getFigSaveName());
            qJSON.put("simQid", qb.getSimQid());

            strQJson = qJSON.toString();
            System.out.println("JSON question  Data sent to client:" + strQJson);
        }

        response.setContentType("text/json");
        response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(strQJson);
    }
}
