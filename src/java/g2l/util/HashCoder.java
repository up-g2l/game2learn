/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author upendraprasad
 */
public final class HashCoder {
    


public static String encode(String password) throws NoSuchAlgorithmException{

MessageDigest md = MessageDigest.getInstance("SHA-256");// Note the data base column for password hash is varchar(256)
        md.update(password.getBytes());
        
        byte byteData[] = md.digest();
 
        //convert the byte to hex format method 1
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < byteData.length; i++) {
         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }
     
        System.out.println("Hex format : " + sb.toString());
        return sb.toString();
}

}