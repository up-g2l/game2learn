/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.util;

import g2l.dao.DataAccess;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author upendraprasad
 */
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException, NamingException, SQLException {
        // TODO code application logic here
        
     /*   BufferedReader br = null;
 
		try {
 
			String sCurrentLine;
 
			br = new BufferedReader(new FileReader("./Putnam 2011.tex"));
                      String strFile =   br.toString();
 
			while ((sCurrentLine = br.readLine()) != null) {
				System.out.println(sCurrentLine);
			}
 
		} catch (IOException e) {
			throw e;
		} finally {
			try {
				if (br != null) {
                                br.close();
                            }
			} catch (IOException ex) {throw ex;
			}
		}
                
        ArrayList rows = new ArrayList();
        
        String strCurrent="";

        String currentRecord;
        while((currentRecord = br.readLine()) != null){
         rows.add(currentRecord.split("\\item"));
        }
        br.close();
        
 
  
        DataAccess da =new DataAccess();
        List<MCQuestion> qb  =  da.fetchQuestions("MAC2","","quadratic;","");
        System.out.println(qb.size());
             // System.out.println(da.fetchMember("uppi1234").getName());
             * */
        DataAccess da =new DataAccess();
        List<String> tags = da.fetchAllTags();
        System.out.println(tags.size());
       
        List<String> sources = da.fetchAllSources();
        System.out.println(sources.size());
        
      //   List<MCQuestion> qBeans = da.fetchQuestions("","","","");
       ////  System.out.println("Question 50:"+qBeans.get(50).getqText());
       //  System.out.println("Question 20:"+qBeans.get(20).getqText());
         
    }
}
