/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.servlets;

import java.io.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.http.*;


/**
 *
 * @author upendraprasad
 */
public class G2LEmail extends HttpServlet {
    private String from;
    private String host;
    
    
    @Override
    public void init()throws ServletException{
        
      ServletConfig sc;
        sc = getServletConfig();

        
        // Sender's email ID needs to be mentioned
        from = sc.getInitParameter("fromEmail");
        System.out.println("FromEmail is:"+from);
        
      // Assuming you are sending email from localhost
         host = sc.getInitParameter("host");
         
          System.out.println("Host is:"+host);
    }

    @Override
    public void doGet(HttpServletRequest request,
                    HttpServletResponse response)
            throws ServletException, IOException
  {
       
            // Recipient's email ID needs to be mentioned.
            String to = request.getParameter("to");
              System.out.println("ToEmail is:"+to);
      
            

      /* 
            // Get system properties
            Properties properties = System.getProperties();
       
            // Setup mail server
            properties.setProperty("mail.smtp.host", host);
            properties.put("mail.smtp.debug", "true");

       
            // Get the default Session object.
            Session session = Session.getDefaultInstance(properties);
            
                // Set response content type
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

               // Create a default MimeMessage object.
               MimeMessage message = new MimeMessage(session);
               // Set From: header field of the header.
               message.setFrom(new InternetAddress(from));
               // Set To: header field of the header.
               message.addRecipient(Message.RecipientType.TO,
                                        new InternetAddress(to));
               // Set Subject: header field
               message.setSubject("This is the Subject Line!");
               // Now set the actual message
               message.setText("This is actual message");
               // Send message
               
               Transport.send(message);
               String title = "Send Email";
               String res = "Sent message successfully....";
               String docType =
               "<!doctype html public \"-//w3c//dtd html 4.0 " +
               "transitional//en\">\n";
               out.println(docType +
               "<html>\n" +
               "<head><title>" + title + "</title></head>\n" +
               "<body bgcolor=\"#f0f0f0\">\n" +
               "<h1 align=\"center\">" + title + "</h1>\n" +
               "<p align=\"center\">" + res + "</p>\n" +
               "</body></html>");*/
              
Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);

        String msgBody = "An empty message";

try {

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from, "Example.com Admin"));
            msg.addRecipient(Message.RecipientType.TO,
                             new InternetAddress(to, "Mr. User"));
            msg.setSubject("Your Example.com account has been activated");
            msg.setText(msgBody);
            Transport.send(msg);

System.out.println("Done");
        } catch (MessagingException ex) {
            Logger.getLogger(G2LEmail.class.getName()).log(Level.SEVERE, null, ex);
        }

   }
} 