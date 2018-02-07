/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.G2LConnectionPool;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author upendraprasad
 */
public class DataParseAndUpload extends HttpServlet {

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
            out.println("<title>Servlet DataParseAndUpload</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DataParseAndUpload at " + request.getContextPath() + "</h1>");
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
        String act = request.getParameter("do");
        if (act.equals("geo")) {
            parseGeo(request, response);
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

    private void parseGeo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String strQuery;
        BufferedReader br;
        int numEntered = 0;
        Connection conn;
        Statement st;

        PreparedStatement ps;

        try {
            br = new BufferedReader(new FileReader("/Users/upendraprasad/Programming/g2l/web/MCGeotil3.txt"));

            String line;

            line = br.readLine();

            String[] split = line.split("~", -1);
            System.out.println("[" + split[0] + "]: ");
            strQuery = "INSERT INTO G2lDB.MCQ_TEMP(TEXT, ANS1, ANS2, ANS3, ANS4, ANS_CORR) VALUES(?,?,?,?,?,?)";

            conn = G2LConnectionPool.getConnection();

            ps = conn.prepareStatement(strQuery);

            ps.setString(1, split[0]);
            ps.setString(2, split[1]);
            ps.setString(3, split[2]);
            ps.setString(4, split[3]);
            ps.setString(5, split[4]);
            ps.setString(6, split[5]);



            numEntered = numEntered + ps.executeUpdate();


            while (line != null) {
                line = br.readLine();
                if (line.length() > 4) {
                    split = line.split("~", -1); //System.out.println("["+split[0]+"]: "+split[split.length-1]);


                    strQuery = "INSERT INTO G2lDB.MCQ_TEMP(TEXT, ANS1, ANS2, ANS3, ANS4, ANS_CORR) VALUES(?,?,?,?,?,?)";

                    conn = G2LConnectionPool.getConnection();

                    ps.clearBatch();

                    ps = conn.prepareStatement(strQuery);

                    ps.setString(1, split[0]);
                    ps.setString(2, split[1]);
                    ps.setString(3, split[2]);
                    ps.setString(4, split[3]);
                    ps.setString(5, split[4]);
                    ps.setString(6, split[5]);

                    numEntered = numEntered + ps.executeUpdate();
                    conn.close();
                }
            }
            br.close();

        } catch (Exception ex) {
            System.out.println("Exception: " + ex.getMessage());
            response.sendRedirect("ErrorPage.jsp");
        }


        System.out.println("Words entered: " + numEntered);
        this.processRequest(request, response);
    }

    private void parseData(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        /*try {
         connection = database.getConnection();
         statement = connection.prepareStatement(SQL_INSERT);
         for (int i = 0; i < entities.size(); i++) {
         Entity entity = entities.get(i);
         statement.setString(1, entity.getSomeProperty());
         // ...
         statement.addBatch();
         if ((i + 1) % 1000 == 0) {
         statement.executeBatch(); // Execute every 1000 items.
         }
         }
         statement.executeBatch();
         } finally {
         if (statement != null) try { statement.close(); } catch (SQLException logOrIgnore) {}
         if (connection != null) try { connection.close(); } catch (SQLException logOrIgnore) {}
         }*/
        String strQuery;
        BufferedReader br;
        int numEntered = 0;
        Connection conn;
        Statement st;

        PreparedStatement ps;

        try {
            br = new BufferedReader(new FileReader("/Users/upendraprasad/Programming/g2l/web/MCGeotil3.txt"));

            String line;

            line = br.readLine();

            String[] split = line.split("~", -1);
            System.out.println("[" + split[0] + "]: ");
            strQuery = "INSERT INTO G2lDB.MCQ_TEMP(TEXT, ANS1, ANS2, ANS3, ANS4, ANS_CORR) VALUES(?,?,?,?,?,?)";

            conn = G2LConnectionPool.getConnection();

            ps = conn.prepareStatement(strQuery);
            int i=0;int[] batchCount;

            while (line != null) {

                if (line.length() > 4) {
                    split = line.split("~", -1); //System.out.println("["+split[0]+"]: "+split[split.length-1]);

                    ps.setString(1, split[0]);
                    ps.setString(2, split[1]);
                    ps.setString(3, split[2]);
                    ps.setString(4, split[3]);
                    ps.setString(5, split[4]);
                    ps.setString(6, split[5]);
                    ps.addBatch();
                    if ((i + 1) % 333 == 0) {
                       batchCount =  ps.executeBatch(); // Execute every 1000 items.
                    }
                }
                line = br.readLine();i++;
            }
            batchCount = ps.executeBatch();

        } catch (Exception ex) {
            System.out.println("Exception: " + ex.getMessage());
            response.sendRedirect("ErrorPage.jsp");
        }


        System.out.println("Words entered: " + numEntered);
        this.processRequest(request, response);
    }
}
