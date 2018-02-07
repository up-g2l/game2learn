/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.NamingException;

/**
 *
 * @author upendraprasad
 */
public class ExamDAO {

    private Connection con;
    private Statement stmt;
    private ResultSet rs;

    /**
     * Creates a new instance of Main
     */
    public ExamDAO() {
        rs = null;
        con = null;
        stmt = null;
    }

    public int saveTest(String userId, String testId, String score, String ansList ) throws NamingException, SQLException {
        int rowsUpdate = 0;
        String query;
            java.util.Date dt = new java.util.Date();

        java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            String currentTime = sdf.format(dt);
            query = "UPDATE g2ldb.user_test SET user_answers = concat(user_answers,'{"+ansList+"}'), score="+score+", status = 1, when_finished='"+currentTime;
              
                   query += "' WHERE USER_ID="+userId+" AND test_id="+testId;

       
        System.out.println("Query: " + query);

        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            rowsUpdate = stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }

        return rowsUpdate;
    }
    
    public int createUserTestEntry(String userId, String testId ) throws NamingException, SQLException {
        int rowsUpdate = 0;
        int utId = 0;
        String query;
            java.util.Date dt = new java.util.Date();

        java.text.SimpleDateFormat sdf =  new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            String currentTime = sdf.format(dt);
            
             query = "SELECT user_test_id FROM g2ldb.user_test WHERE test_id = "+testId+" AND user_id = "+userId;
            


        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            
           
            this.rs = stmt.executeQuery(query);
            
            while(rs.next()){ utId =  rs.getInt("user_test_id");  System.out.println("Executed query: "+query);}
            
            if(utId==0){
                            query = "INSERT INTO g2ldb.user_test(test_id, user_id, user_answers, score,when_started, when_finished)"+
                    " VALUES("+testId+", "+userId+",'{}', 0, '"+currentTime+"', '"+currentTime+"')";
                            System.out.println("User Test Creation uery: "+query);
                            
                rowsUpdate = stmt.executeUpdate(query,Statement.RETURN_GENERATED_KEYS);
            
                this.rs = stmt.getGeneratedKeys();
            
                 while(rs.next()){utId = rs.getInt(1);}
            }
            rs.close();
          
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }

        return utId;
    }
    
    public int enterPractice(String userId, String[] qids, boolean isRight) throws NamingException, SQLException {
        String query = "insert into g2ldb.user_practice (user_id,q_id) values(" + userId + "," + qids[0] + ")";
        for (int i = 1; i < qids.length; i++) {
            query += ",(" + userId + "," + qids[i] + ")";
        }
        query += "on duplicate key update ";
        if (isRight) {
            query += "num_right=num_right + 1";
        } else {
            query += "num_wrong=num_wrong + 1";
        }
        System.out.println("Query: " + query);
        int rowsUpdate = 0;
        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            rowsUpdate = stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }
        return rowsUpdate;
    }
    
    public int savePractice(String userId, String[] qIds, boolean isRight) throws NamingException, SQLException {
        int rowsUpdate = 0;
        String query;
            
            query = "UPDATE g2ldb.user_practice SET ";
            
            if (isRight) {
            query += " num_right=num_right + 1 ";
        } else {
            query += " num_wrong=num_wrong + 1 ";
        }
                    
                   query += "WHERE USER_ID="+userId+" AND Q_ID IN (0";

            for (int i = 0; i < qIds.length; i++) {
                if(!qIds[i].equals("")) {query +=  "," + qIds[i];}
            }
            query +=")";

       
        System.out.println("Query: " + query);

        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            rowsUpdate = stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }

        return rowsUpdate;
    }

    public int savePracticeCheck(String userId, String[] qIds, String chk) throws NamingException, SQLException {
        int rowsUpdate = 0;
        String query; 
            
            query = " UPDATE g2ldb.user_practice SET check_mark='"+chk+"' "+
                    " WHERE USER_ID="+userId+" AND Q_ID IN (0";

            for (int i = 0; i < qIds.length; i++) {
               if(!qIds[i].equals("")) {query +=  "," + qIds[i];}
            }
            query +=")";

       
        System.out.println("Query: " + query);

        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            rowsUpdate = stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }

        return rowsUpdate;
    }
    
    public int initPracticeData(String userId, String[] qIds) throws NamingException, SQLException {
       String query = "insert into g2ldb.user_practice (user_id,q_id) values(" + userId + ",0)";
        for (int i = 1; i < qIds.length; i++) {
            query += ",(" + userId + "," + qIds[i] + ")";
        }
        query += " on duplicate key update status='2'";

        System.out.println("Query: " + query);
        int rowsUpdate = 0;
        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            rowsUpdate = stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }
        return rowsUpdate;
    }
}
