/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataAccess;
import g2l.dao.QuestionDAO;
import g2l.util.MCQuestion;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author upendraprasad
 */
public class QFetcher extends HttpServlet {

    private ServletContext context;
    private DataAccess dataAccess = new DataAccess();
    //GameQuestion gq =  dataAccess.fetchQuestion();
    
   // private HashMap questions = new HashMap(1,gq);
   
   

    @Override
    public void init(ServletConfig config) throws ServletException {
        this.context = config.getServletContext();
    }


/** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String action = request.getParameter("action");
       // action="complete";
                
        String targetId = request.getParameter("id");//System.out.println("id: "+targetId);
        
          MCQuestion qb=new MCQuestion();
          QuestionDAO qdao = new  QuestionDAO();
        try {
            qb = qdao.fetchQuestionsById(targetId);
        } catch(Exception ex){
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("ErrorPage.jsp");
        }
          
          
          JSONObject qJSON; 
          String strQJson="";

        if (targetId != null) {
            targetId = targetId.trim().toLowerCase();
        } else {
            context.getRequestDispatcher("/error.jsp").forward(request, response);
           }

            if (!targetId.equals("")) {
                qJSON = new JSONObject();
                

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
                   System.out.println("JSON question  Data sent to client:"+strQJson);
            }

                response.setContentType("text/json");
                response.setHeader("Cache-Control", "no-cache");
                response.getWriter().write(strQJson);
     }
}
