/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author upendraprasad
 */
public class EmailSender {
        private final String username = "upendra0111";
		private final String password = "your_pass";
        
        private Properties props;

    public EmailSender() {
        //props = System.getProperties();
		//props.put("mail.smtp.auth", "true");
		//props.put("mail.smtp.starttls.enable", "true");
		//props.put("mail.smtp.host", "localhost");
		//props.put("mail.smtp.port", "587");
         // Get a Properties object
      props = System.getProperties();
     props.setProperty("mail.smtp.host", "smtp.gmail.com");
     //props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
     props.setProperty("mail.smtp.socketFactory.fallback", "false");
     props.setProperty("mail.smtp.port", "465");
     props.setProperty("mail.smtp.socketFactory.port", "465");
     props.put("mail.smtp.auth", "true");
     props.put("mail.debug", "true");
     props.put("mail.store.protocol", "pop3");
     props.put("mail.transport.protocol", "smtp");
     final String username = "upendra0111@gmail.com";//
     final String password = "password";
     
    }
    
        
        
    
      public  void sendEmail(String receiver, String subject, String text) throws MessagingException{//working

          System.out.println("Sendign Email");
          // Get the default Session object.
           Session session = Session.getDefaultInstance(props, 
                          new Authenticator(){
                             @Override
                             protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(username, password);
                             }});
		/*Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
              @Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });*/

			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress("upendra0111@gmail.com"));
			message.addRecipients(Message.RecipientType.TO,
				InternetAddress.parse(receiver));
			message.setSubject(subject);
			message.setText(text);
 
			Transport.send(message);
    }
}
