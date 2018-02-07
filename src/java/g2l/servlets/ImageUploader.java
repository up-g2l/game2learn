/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import g2l.dao.DataEntry;
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
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;

/**
 *
 * @author upendraprasad
 */
public class ImageUploader extends HttpServlet {

    //private static final String UPLOAD_DIR = "uploadedImages";
    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 1024 * 1024;
    private int maxMemSize = 1024*1024; //Not More than 20KB
    private GameFigure gFig;
    private String uploadFilePath;
    private File file;

    /**
     *Initialize with upload path
     */
    @Override
    public void init() {
        // Get the file location where it would be stored.
        filePath = getServletContext().getInitParameter("file-upload");
        System.out.println("Image Uploader ServletInitiated. Upload location:" + filePath);
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

      //  isMultipart = ServletFileUpload.isMultipartContent(request); // Check that we have a file upload request

        String applicationPath = request.getServletPath();// gets absolute path of the web application
                System.out.println("Servlet Path: "+applicationPath);

       // uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;// constructs path of the directory to save uploaded file

        File fileSaveDir = new File(filePath);// creates the save directory if it does not exists        
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
            System.out.println("Creating directory");
        } else {
            System.out.println("Save directory exists as " + fileSaveDir.getAbsolutePath());
        }


        gFig = new GameFigure();//FigureBean        
        DataEntry de = new DataEntry();

        isMultipart = ServletFileUpload.isMultipartContent(request);
        //  System.out.println(" How many parts of data :"+request.getParts().size());
        //process only if its multipart content
        if (isMultipart) {
            //Create an entry for the figure first whose id will be figId
            try {
                int figId = de.createNewImage(gFig);
                gFig.setFigId(figId);
                DiskFileItemFactory factory = new DiskFileItemFactory();// Create a factory for disk-based file items

                ServletContext servletContext = this.getServletConfig().getServletContext();// Configure a repository (to ensure a secure temp location is used)
                File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");

                factory.setRepository(repository);
                factory.setSizeThreshold(maxFileSize);
                ServletFileUpload upload = new ServletFileUpload(factory);// Create a new file upload handler                
                upload.setSizeMax(maxMemSize);// Set overall request size constraint

                List<FileItem> multiparts = upload.parseRequest(request);// Parse the request
                // Process the uploaded items
                Iterator<FileItem> iter = multiparts.iterator();
                while (iter.hasNext()) {
                    FileItem item = iter.next();

                    if (item.isFormField()) {
                        processFormField(item);
                    } else {
                        processUploadedFile(item);
                    }
                }
                //File uploaded successfully
                de.updateImage(gFig);// Update the image information in the database
                
                request.setAttribute("fileName", gFig.getFigSaveName());
                request.setAttribute("figId", gFig.getFigId());
                request.setAttribute("message", "File Uploaded Successfully.");
                 System.out.println("Image Saved ");
                processRequest(request, response);
            } catch (Exception ex) {System.out.println(ex.getMessage());               
                request.setAttribute("message", "File Upload Failed due to " + ex.getMessage());
                processRequest(request,response);
            }

        } else {//Fetch the data
            request.setAttribute("message", "Sorry this Servlet only handles file upload request.");
        }
        
        
    }

    private void processFormField(FileItem item) {

        String name = item.getFieldName();

        if (name.equals("imgCaption")) {
            gFig.setFigCaption(item.getString());
        } else if (name.equals("imgKeywords")) {
            gFig.setFigKeywords(item.getString());
        } else if (name.equals("imgSource")) {
            gFig.setFigSource(item.getString());
        } else if (name.equals("imgSaveName")) {
            gFig.setFigSaveName(item.getString());
        } 

        //System.out.println("Data Field: " + name + "; and value:" + item.getString());
    }

    private void processUploadedFile(FileItem item) throws Exception {
        String figNameActual;
        if (!item.isFormField()) {
            figNameActual = new File(item.getName()).getName();
            String ext = figNameActual.substring(figNameActual.indexOf("."));
            item.write(new File(filePath + File.separator + gFig.getFigId()+ext ));
            gFig.setFigOrigName(figNameActual);
            gFig.setFigSaveName(gFig.getFigId()+ext);
            System.out.println("The figureName is :" + gFig.getFigOrigName());
        }
    }

    protected void processRequest1(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            out.println("<img class=\"thumbQFig\" src=\"./uploadedImages/" + request.getAttribute("fileName") + "\" />");
            out.println("<input type=\"hidden\" id=\"imgName\" value=\"" + request.getAttribute("fileName") + "\">");
            out.println("<input type=\"hidden\" id=\"imgId\" value=\"" + request.getAttribute("figId") + "\">");
        } catch (Exception e) {
            out.println("<p>Failure in Data Access</p>");
        } finally {
            out.close();
            
        }
    }
    
   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        JSONObject qJSON = new JSONObject();
                

                qJSON.put("qImgName", request.getAttribute("fileName")); 
                qJSON.put("qImgId", request.getAttribute("figId"));
                
                String strQJson = qJSON.toString();

                System.out.println("JSON Image  Data sent to client:"+strQJson);
            

                response.setContentType("json");
                response.setHeader("Cache-Control", "no-cache");
                response.getWriter().write(strQJson);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
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
        } catch(Exception ex){
            Logger.getLogger(authenticate.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("ErrorPage.jsp");
        }
    }
}
