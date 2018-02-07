/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataAccess;
import g2l.dao.DataEntry;
import g2l.util.GPMember;
import g2l.util.GameFigure;
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

/**
 *
 * @author upendraprasad
 */
public class FigUploader extends HttpServlet {

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
            out.println("<title>Servlet FigUploader</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FigUploader at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
    
    protected void fetchFigInfo(HttpServletRequest request, HttpServletResponse response) throws SQLException, NamingException, ServletException, IOException {
        GPMember gpm = (GPMember) request.getSession().getAttribute("member");
        if (gpm == null) {
            try {
                response.sendRedirect("ErrorPage.jsp");
            } catch (IOException ex) {
                Logger.getLogger(FigManager.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        DataAccess da = new DataAccess();
        List<GameFigure> allFigures = da.getAllFigures(gpm.getId());
        request.setAttribute("allFig", allFigures);
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/uploadFigures.jsp");
        rd.forward(request, response);
    }

    protected void saveImage(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not yet implemented");
    }

    protected void updateData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        GameFigure gFig = new GameFigure();

        gFig.setFigId(Integer.parseInt(request.getParameter("figId")));
        gFig.setFigKeywords(request.getParameter("figKey"));
        gFig.setFigCaption(request.getParameter("figCaption"));
        gFig.setFigSource(request.getParameter("figSource"));
        //gFig.setFigSaveName(request.getParameter("figSaveName"));
        gFig.setStatus(request.getParameter("figStatus"));



        DataEntry de = new DataEntry();
        try {
            int rowsUpdated = de.updateImage(gFig);
            if (rowsUpdated == 0) {
                response.getWriter().write("FAIL");
            }
            //String figId = de.createNewImage(gFig);//Create an entry for the figrue first
        } catch (Exception ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
            response.getWriter().write("FAIL");
        }
        //response.sendRedirect("FigManager");
    }
}
