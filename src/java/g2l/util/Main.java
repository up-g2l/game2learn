/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

import g2l.dao.DataAccess;
import g2l.dao.G2LConnectionPool;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.naming.NamingException;

/**
 *
 * @author upendraprasad
 */
public class Main {

    public Main() {
        
    }

    public static void main(String[] args) {
        try {
            
            //System.out.println("Reprint: "+HashCoder.encode("uppi123"));
            
          /*  try {
                parseGeo();
            } catch (Exception ex) {
                System.out.println("EXCEPTION: "+ex.getMessage());
            } 
            */
            EmailSender es = new EmailSender();
            try {
                es.sendEmail("sendtoupendra@yahoo.com", "Test Email", "This is just a Text Email.");
            } catch (MessagingException ex) {
                System.out.println("Exception: " + ex.getMessage());
            }
        } catch (Exception ex) {
            Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static void parseVocab() {
        DataAccess da = new DataAccess();

        String strQuery;
        BufferedReader br = null;
        int numEntered = 0;

        try {
            br = new BufferedReader(new FileReader("./GREWords.txt"));


            StringBuilder sb = new StringBuilder();
            String line = null;

            line = br.readLine();

            String[] split = line.split("\\t", -1);
            System.out.println("[" + split[0] + "]: ");
            strQuery = "INSERT INTO APP.TBL_ENG_WORDS(WORD, MEANING) VALUES('" + split[0] + "', '" + split[1] + "')";

            Connection conn = G2LConnectionPool.getConnection();

            Statement st = conn.createStatement();

            numEntered = numEntered + st.executeUpdate(strQuery);


            while (line != null) {
                sb.append(line);
                sb.append("\n");

                line = br.readLine();
                if (line.length() > 4) {
                    split = line.split("\\t", -1); //System.out.println("["+split[0]+"]: "+split[split.length-1]);
                    strQuery = "INSERT INTO APP.TBL_ENG_WORDS(WORD, MEANING) VALUES('" + split[0] + "', '" + split[split.length - 1] + "')";

                    numEntered = numEntered + st.executeUpdate(strQuery);
                }
            }
            String everything = sb.toString();
            System.out.println("Length of the string: " + everything.length());

            st.close();
            conn.close();
        } catch (Exception ex) {
            System.out.println("Error: " + ex.getMessage());
        } finally {
            try {
                br.close();
            } catch (IOException ex) {
                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        System.out.println("Words entered: " + numEntered);
    }

    private static void parseGeo() throws SQLException, IOException, NamingException {
        DataAccess da = new DataAccess();

        String strQuery;
        BufferedReader br = null;
        int numEntered = 0;
        Connection conn=null;
        Statement st=null;

        try {
            br = new BufferedReader(new FileReader("/Users/upendraprasad/Programming/g2l/web/MCGeotilda.txt"));

            String line = null;

            line = br.readLine();

            String[] split = line.split("~", -1);
            System.out.println("[" + split[0] + "]: ");
            strQuery = "INSERT INTO APP.MC_TEMP(TEXT, ANS1, ANS2, ANS3, ANS4, ANS_CORR) VALUES('" + split[0].trim() + "', '" + split[1].trim() + "', '" + split[2].trim() + "', '" + split[3].trim() + "', '" + split[4].trim() + "', '" + split[5].trim() + "')";

            conn = G2LConnectionPool.getConnection();

            st = conn.createStatement();

            numEntered = numEntered + st.executeUpdate(strQuery);


            while (line != null) {
                line = br.readLine();
                if (line.length() > 4) {
                    split = line.split("~", -1); //System.out.println("["+split[0]+"]: "+split[split.length-1]);
                    strQuery = "INSERT INTO APP.MC_TEMP(TEXT, ANS1, ANS2, ANS3, ANS4, ANS_CORR) VALUES('" + split[0].trim() + "', '" + split[1].trim() + "', '" + split[2].trim() + "', '" + split[3].trim() + "', '" + split[4].trim() + "', '" + split[5].trim() + "')";

                    numEntered = numEntered + st.executeUpdate(strQuery);
                }
            }
            

        }  finally {            
            st.close();
            conn.close();
            br.close();
        }

        System.out.println("Words entered: " + numEntered);
    }

    private static void sendEmail2() {
        // Recipient's email ID needs to be mentioned.
        String to = "upendra0111@yahoo.com";

        // Sender's email ID needs to be mentioned
        String from = "sendtoupendra@yahoo.com";

        // Assuming you are sending email from localhost
        String host = "localhost";

        // Get system properties
        Properties properties = System.getProperties();

        // Setup mail server
        properties.setProperty("mail.smtp.host", host);

        // Get the default Session object.
        Session session = Session.getDefaultInstance(properties);

        try {
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
            System.out.println("Sent message successfully....");
        } catch (MessagingException mex) {
            System.out.println("EXCEPTION: " + mex.getMessage());
        }
    }
}
