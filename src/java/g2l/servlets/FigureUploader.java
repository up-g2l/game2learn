/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataEntry;
import g2l.util.GPMember;
import g2l.util.GameFigure;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;

/**
 *
 * @author upendraprasad
 */
public class FigureUploader extends HttpServlet {

    //private static final String UPLOAD_DIR = "uploadedImages";
    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 1024 * 1024;
    private int maxMemSize = 1024 * 1024; //Not More than 20KB
    private GameFigure gFig;
    private FileItem figFile;

    /**
     * Initialize with upload path
     */
    @Override
    public void init() {
        // Get the file location where it would be stored.
        String relativeWebPath = "/g2l/uploadedImages";
       String filePath = getServletContext().getRealPath(relativeWebPath);
      //  filePath = getServletContext().getInitParameter("file-upload");
        System.out.println("Figure Uploader Servlet Initiated. Upload location:" + filePath);
        File fileSaveDir = new File(filePath);// creates the save directory if it does not exists        
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
            System.out.println("Creating directory");
        } else {
            System.out.println("Save directory exists as " + fileSaveDir.getAbsolutePath());
        }
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        gFig = new GameFigure();//FigureBean      
        HttpSession sesn = request.getSession();
        GPMember member = (GPMember) sesn.getAttribute("member");
        gFig.setFigProvider(member.getId());



        isMultipart = ServletFileUpload.isMultipartContent(request);
        //process only if its multipart content
        if (isMultipart) {
            //Create an entry for the figure first whose id will be figId
            try {
                //int figId = de.createNewImage(gFig);
                //gFig.setFigId(figId);

                DiskFileItemFactory factory = new DiskFileItemFactory();// Create a factory for disk-based file items
                ServletContext servletContext = this.getServletConfig().getServletContext();// Configure a repository (to ensure a secure temp location is used)
                File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
                factory.setRepository(repository);
                factory.setSizeThreshold(maxFileSize);
                ServletFileUpload upload = new ServletFileUpload(factory);// Create a new file upload handler                
                upload.setSizeMax(maxMemSize);// Set overall request size constraint

                List<FileItem> multiparts = upload.parseRequest(request);// Parse the request        

                Iterator<FileItem> iter = multiparts.iterator();
                while (iter.hasNext()) {// Process the uploaded items
                    FileItem item = iter.next();
                    String name;

                    if (item.isFormField()) {
                         name = item.getFieldName();
                        if (name.equals("figCaption")) {
                            gFig.setFigCaption(item.getString());
                        } else if (name.equals("figKey")) {
                            gFig.setFigKeywords(item.getString());
                        } else if (name.equals("figSource")) {
                            gFig.setFigSource(item.getString());
                        } else if (name.equals("figStatus")) {
                            gFig.setStatus(item.getString());
                        }
                    } else {
                        figFile = item;
                    }
                }
                processUploadedFile();
                //File uploaded successfully

                System.out.println("Image Saved ");
                request.setAttribute("message", "SAVED");
                processRequest(request, response);
            } catch (Exception ex) {
                System.out.println("FAIL: "+ex.getMessage());
                request.setAttribute("message", "FAIL: " + ex.getMessage());
                processRequest(request, response);
            }

        } else {//Fetch the data
            request.setAttribute("message", "Sorry this Servlet only handles file upload request.");
        }


    }


    protected void processUploadedFile() throws Exception {
        String figNameActual;
        DataEntry de = new DataEntry();

        figNameActual = new File(figFile.getName()).getName();
        String ext = figNameActual.substring(figNameActual.lastIndexOf("."));//file extention
        gFig.setFigOrigName(figNameActual);
        gFig.setFigSaveName(gFig.getFigId() + ext);

        int figId = de.createNewImage(gFig);
        gFig.setFigId(figId);     
        gFig.setFigSaveName(gFig.getFigId() + ext);

        figFile.write(new File(filePath + File.separator + gFig.getFigSaveName()));//Write the file on the disk
        de.updateImage(gFig);// Update the image information in the database

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        JSONObject qJSON = new JSONObject();

        response.setContentType("json");
        response.setHeader("Cache-Control", "no-cache");

        if (request.getAttribute("message").equals("SAVED")) {
            qJSON.put("figUpload", "SAVED");
            qJSON.put("message", "Image uploaded successfully");
            qJSON.put("figId", gFig.getFigId());
            qJSON.put("figName", gFig.getFigSaveName());
            qJSON.put("figCaption", gFig.getFigCaption());
            qJSON.put("figKey", gFig.getFigKeywords());
            qJSON.put("figSource", gFig.getFigSource());
            qJSON.put("figStatus", gFig.getStatus());
            
        } else {
            qJSON.put("figUpload", "FAIL");
            qJSON.put("message",request.getAttribute("message"));
        }

        String strQJson = qJSON.toString();

        System.out.println("JSON Image  Data sent to client:" + strQJson);

        response.getWriter().write(strQJson);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       updateFigData(request,response);
    }
    /*Discarded*/
    protected void  updateFigData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
         String imgId = request.getParameter("imgId");
        String imgName = request.getParameter("imgName");
        String imgCaption = request.getParameter("imgCaption");
        String imgKeywords = request.getParameter("imgKeywords");
        String imgAltText = request.getParameter("imgAltText");
        String imgSource = request.getParameter("imgSource");

        //  gFig.setFigAltText(imgAltText);
        gFig.setFigCaption(imgCaption);
        gFig.setFigId(Integer.getInteger(imgId));
        gFig.setFigKeywords(imgKeywords);
        gFig.setFigSaveName(imgName);
        gFig.setFigSource(imgSource);


        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        DataEntry de = new DataEntry();

        try {
            if (de.updateImage(gFig) > 0) {

                try {
                    out.println("<span>" + request.getAttribute("message") + "</span>");
                    out.println("<img src=\"./uploadedImages/" + request.getAttribute("fileName") + "\" width=\"300px\" />");
                    out.println("<input type=\"hidden\" id=\"imgName\" value=\"" + request.getAttribute("fileName") + "\">");
                    out.println("<input type=\"hidden\" id=\"imgId\" value=\"" + request.getAttribute("figId") + "\">");
                } catch (Exception e) {
                    out.println("<p>Failure in Data Access</p>");
                } finally {
                    out.close();
                }
            } else {
                out.println("<p>Failure in Data Update</p>");
            }
        } catch (Exception ex) {
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("ErrorPage.jsp");
        }
    }
}