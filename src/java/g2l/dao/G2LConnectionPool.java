/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author upendraprasad
 */
public final class G2LConnectionPool {

    
    /**
     * Get Connection from the data pool.
     */
    public static Connection getConnection(){
        
      DataSource ds=null;
    try {
        InitialContext initialContext = new InitialContext();//System.out.println("Step 1: ");
            Context context = (Context) initialContext.lookup("java:comp/env"); //System.out.println("Using Conn Pool: "+context.getNameInNamespace());
            //The JDBC Data source that we just created
           
         
            ds = (DataSource) context.lookup("g2lconnpool");
        } catch (NamingException ex) {
            Logger.getLogger(G2LConnectionPool.class.getName()).log(Level.SEVERE, "The named database resource not found.", ex);
        }
 //System.out.println("Step 2: ");
            Connection connection=null;
        try {
            connection = ds.getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(G2LConnectionPool.class.getName()).log(Level.SEVERE, "Some problem Connecting to the Database", ex);
        }
            return connection;
    }


    
}
