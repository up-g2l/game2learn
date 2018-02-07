/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataAccess;
import g2l.util.TestMC;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author upendraprasad
 */
public class TestInfo extends HttpServlet {

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
        String testId = request.getParameter("testId");
        
        DataAccess da =new DataAccess();
        
        
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            TestMC mcTest =  da.fetchTestMC(testId);
            /* TODO output your page here. You may use following sample code. */
            out.println("<p>Test Details</p><table>");
            out.println("<tr><td>Title</td><td style='width=400px'>"+mcTest.getTestTitle()+"</td></tr>");
            out.println("<tr><td style=\"width:50px;\">Test Id</td><td>"+testId+"</td></tr>");
            out.println("<tr><td> Duration</td><td>"+mcTest.getTestDuration()+" minutes</td></tr>");
          //  out.println("<tr><td>Test Creator</td><td>"+mcTest.getUserId()+"</td></tr>");
            out.println("<tr><td>Name of Test Creator</td><td>"+mcTest.getUserId()+"</td></tr>");
            out.println("<tr><td>Description</td><td>"+mcTest.getDescription()+"</td></tr>");
            out.println("<tr><td>From</td><td>"+mcTest.getDateFrom()+"</td></tr>");
            out.println("<tr><td>From</td><td>"+mcTest.getDateTo()+"</td></tr>");
            out.println("</table>");
        }catch(Exception e){out.println("<p>Failure in Data Access</p>");}
        finally {            
            out.close();
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
}
