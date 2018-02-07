/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataEntry;
import g2l.util.GPMember;
import g2l.util.MCQuestion;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author upendraprasad
 */
public class QEntry extends HttpServlet {

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

        HttpSession sesn1 = request.getSession();

        GPMember member = (GPMember) sesn1.getAttribute("member");

        String question = request.getParameter("question");
        String qId = request.getParameter("qId");
        System.out.println("Questions ID:" + qId);
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
        String simQid = request.getParameter("simQid");

        MCQuestion qBean = new MCQuestion();
        qBean.setqText(question);
        qBean.setqType(qType);
        qBean.setAnsA(ansA);
        qBean.setAnsB(ansB);
        qBean.setAnsC(ansC);
        qBean.setAnsD(ansD);
        qBean.setAnsE(ansE);
        qBean.setAnsCorrect(correct);
        qBean.setExplanation(explanation);
        qBean.setHelpLink(helpLink);
        qBean.setTags(tags);
        qBean.setqId(qId);
        qBean.setProvider(member.getId());
        //qBean.setqStatus("1");
        qBean.setSource(qSource);
        qBean.setFigId(figId);
        qBean.setSimQid(simQid);

        DataEntry de = new DataEntry();
        try{
        if (qId.equals("0")) {
            qId = de.enterQuestion(qBean);
        } else {
            de.updateQuestion(qBean);
        }
        }catch(Exception ex){
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, "Some error was encountered during question entry.", ex);
            //response.sendRedirect("ErrorPage.jsp");
        }

        //System.out.println("Question id:"+qId);




        // response.setContentType("text");
        //response.setCharacterEncoding("UTF-8");
        // response.setHeader("Cache-Control", "no-cache");
        response.getWriter().write(qId);
        System.out.println("Data Returned,qId " + qId);
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
}
