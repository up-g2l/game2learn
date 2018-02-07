/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.dao;

/**
 *
 * @author upendraprasad
 */
import g2l.util.GPMember;
import g2l.util.GameFigure;
import g2l.util.MCQuestion;
import g2l.util.TestMC;
import g2l.util.UserTest;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author upendraprasad
 */
/*
 * Main.java
 * 
 * Created on 17 Sep, 2007, 10:49:17 PM
 * 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author amit
 */
public class DataAccess {

    private Connection con;
    private Statement stmt;
    private ResultSet rs;

    /**
     * Creates a new instance of Main
     */
    public DataAccess() {
        con = null;
        stmt = null;
        rs=null;
    }

    /**
     *
     * @param strLogin
     * @return
     */
    public boolean existingLogin(String strLogin) throws NamingException, SQLException {
        
        GPMember member = fetchMember(strLogin,"");
        
        if (member != null) {
            return true;
        } else {
            return false;
        }
        
    }

    public boolean existingUser(String email) throws NamingException, SQLException {
        
        GPMember member = fetchMember("",email);
        
        if (member != null) {
            return true;
        } else {
            return false;
        }
        
    }
    /**
     *
     * @param loginId
     * @return
     */
    public GPMember fetchMember(String loginId, String email) throws NamingException, SQLException {
        GPMember member = null;
        //gameQ = new GameQuestion[4];
        
        
        
        try {  //System.out.println("Step 2");
            con = G2LConnectionPool.getConnection(); System.out.println("DB Connection Created Succefully");
            stmt = con.createStatement();
            
           if(email.equals("")){ rs = stmt.executeQuery("SELECT * FROM g2ldb.user_info WHERE login='" + loginId + "'");}
           else{ rs = stmt.executeQuery("SELECT * FROM g2ldb.user_info WHERE  email='"+email+"'");}
            int i = 0;
            while (rs.next()) {
                member = new GPMember();                
                member.setName(rs.getString("user_name"));
                member.setPassword(rs.getString("password"));
                member.setUserType(rs.getString("user_type"));
                member.setId(rs.getString("user_id"));
                member.setLogin(rs.getString("login"));
                member.setEmail(rs.getString("email"));
                member.setUserStatus(rs.getString("user_status"));
                member.setUserLevel(rs.getString("user_level"));
                member.setUserSince(rs.getString("user_since"));
                //System.out.println(q + ":   " + qt);

                System.out.println("DataAccess end:" + i);
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        } finally {
            stmt.close();
            con.close();
        }        
        return member;
        
    }
    
    public GPMember fetchMemberById(String userId) throws NamingException, SQLException {
        GPMember member = null;
        //gameQ = new GameQuestion[4];
        
        
        
        try {  //System.out.println("Step 2");
            con = G2LConnectionPool.getConnection(); System.out.println("DB Connection Created Succefully");
            stmt = con.createStatement();
            
            rs = stmt.executeQuery("SELECT * FROM g2ldb.user_info WHERE user_id='" + userId + "'");

            int i = 0;
            while (rs.next()) {
                member = new GPMember();                
                member.setName(rs.getString("user_name"));
                member.setPassword(rs.getString("password"));
                member.setUserType(rs.getString("user_type"));
                member.setId(rs.getString("user_id"));
                member.setLogin(rs.getString("login"));
                member.setEmail(rs.getString("email"));
                member.setUserStatus(rs.getString("user_status"));
                member.setUserLevel(rs.getString("user_level"));
                member.setUserSince(rs.getString("user_since"));
                //System.out.println(q + ":   " + qt);

                System.out.println("DataAccess end:" + i);
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        } finally {
            stmt.close();
            con.close();
        }        
        return member;
        
    }
    
    public List<MCQuestion> fetchQuestion(String qId) throws NamingException, SQLException {
        
        
        List<MCQuestion> listQBeans = new ArrayList<MCQuestion>();
        MCQuestion qb;
        
        
        
        try {            
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT * FROM g2ldb.mc_questions WHERE Q_ID=" + qId);
            int i = 0;
            while (rs.next()) { //System.out.println("Fetcg Question Started:"+i+":"+rs.getString("question"));
                qb = new MCQuestion();
                qb.setqId(rs.getString("q_id"));
                qb.setqText(rs.getString("q_text"));
                qb.setqType(rs.getString("q_type"));
                qb.setAnsA(rs.getString("ans1"));
                qb.setAnsB(rs.getString("ans2"));
                qb.setAnsC(rs.getString("ans3"));
                qb.setAnsD(rs.getString("ans4"));
                qb.setAnsE(rs.getString("ans5"));
                qb.setAnsCorrect(rs.getString("correct_ans"));                
                listQBeans.add(qb);
                i++;
            }
             rs.close();
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
           
            stmt.close();
            con.close();
        }        
        return listQBeans;
        
    }
    
    public MCQuestion fetchQuestionsById(String qId) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE Q_ID=" + qId;
        List<MCQuestion> listQBeans = (List<MCQuestion>) getQuestions(strQuery);
        MCQuestion qBean = (MCQuestion) listQBeans.get(0);
        qBean.setFigure(this.getFigure(qBean.getFigId()));
        return qBean;
    }
    
    public List<MCQuestion> fetchQuestionsByIdList(String[] qIdList) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE Q_ID IN (999";
        for (int i = 0; i < qIdList.length; i++) {
            strQuery += "," + qIdList[i];
        }
        strQuery += ")";
        List<MCQuestion> listQBeans = (List<MCQuestion>) getQuestions(strQuery);
        return listQBeans;
    }
    
    public List<MCQuestion> fetchQuestions(String qType, String qSource, String tags, String qProvider) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE Q_STATUS ='1' ";
        if(tags==null){tags="";}//Make sure that null is not encountered
        if(qProvider==null){qProvider="";}
        if (!tags.equals("")) {
            String[] strArrTags = tags.split(";");
            strQuery += "AND Q_TAGS LIKE '%" + strArrTags[0] + ";%'";            
            for (int i = 1; i < strArrTags.length; i++) {
                strQuery += " OR Q_TAGS LIKE  '%" + strArrTags[i] + ";%'";
            }
        }
        
        if (!qType.equals("")) {
            strQuery += "AND Q_TYPE LIKE '%" + qType + "%'";
        }
        if (!qSource.equals("")) {
            strQuery += "AND Q_SOURCE LIKE '%" + qSource + "%'";
        }
        if (!qProvider.equals("")) {
            strQuery += "AND Q_PROVIDER = " + qProvider;
        }
        System.out.println("Query: " + strQuery);
        
        return getQuestions(strQuery);
    }
    
    public List<MCQuestion> fetchDetailedQuestions(String qType, String qSource, String tags, String qProvider) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions AS MCQ JOIN g2ldb.figures AS F ON MCQ.FIG_ID=F.FIG_ID  WHERE MCQ.Q_STATUS ='1' ";
        if(tags==null){tags="";}//Make sure that null is not encountered
        if(qProvider==null){qProvider="";}
        if (!tags.equals("")) {
            String[] strArrTags = tags.split(";");
            strQuery += "AND MCQ.Q_TAGS LIKE '%" + strArrTags[0] + ";%'";            
            for (int i = 1; i < strArrTags.length; i++) {
                strQuery += " OR MCQ.Q_TAGS LIKE  '%" + strArrTags[i] + ";%'";
            }
        }
        
        if (!qType.equals("")) {
            strQuery += "AND MCQ.Q_TYPE LIKE '%" + qType + "%'";
        }
        if (!qSource.equals("")) {
            strQuery += "AND MCQ.Q_SOURCE LIKE '%" + qSource + "%'";
        }
        if (!qProvider.equals("")) {
            strQuery += "AND MCQ.Q_PROVIDER = " + qProvider;
        }
        System.out.println("Query: " + strQuery);
        
        return getDetailedQuestions(strQuery);
    }
    
    public List<MCQuestion> fetchQuestionsByTag(String tags) throws NamingException, SQLException {
        String[] strArrTags = tags.split(";");
        String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE TAGS LIKE '%" + strArrTags[0] + ";%'";
        
        for (int i = 1; i < strArrTags.length; i++) {
            strQuery += " OR Q_TAGS LIKE  '%" + strArrTags[i] + ";%'";
        }
        
        System.out.println("Query: " + strQuery);
        return (List<MCQuestion>) getQuestions(strQuery);
    }
    
    public List<MCQuestion> fetchQuestionsByContributor(String userId) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE Q_PROVIDER=" + userId;
        return (List<MCQuestion>) getQuestions(strQuery);
    }
    
    public List<MCQuestion> fetchQuestionsBySource(String source) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE Q_SOURCE LIKE '" + source + "'";
        return (List<MCQuestion>) getQuestions(strQuery);
    }
    
    public List<MCQuestion> fetchQuestionsByQType(String qType) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE Q_TYPE LIKE '%" + qType + "%'";
        System.out.println("Query: " + strQuery);
        return (List<MCQuestion>) getQuestions(strQuery);
    }
    
    private List<MCQuestion> getQuestions(String query) throws NamingException, SQLException {
        //   MCQuestion[] qBeans = new MCQuestion[];
        List<MCQuestion> qBeans = new ArrayList<MCQuestion>();
        
        
        
        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            MCQuestion qBean;
            System.out.println("DataAccess: Query" + query);
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                qBean = new MCQuestion();
                qBean.setqId(rs.getString("q_id"));
                qBean.setqText(rs.getString("q_text"));
                qBean.setqType(rs.getString("q_type"));
                qBean.setAnsA(rs.getString("ans1"));
                qBean.setAnsB(rs.getString("ans2"));
                qBean.setAnsC(rs.getString("ans3"));
                qBean.setAnsD(rs.getString("ans4"));
                qBean.setAnsE(rs.getString("ans5"));
                qBean.setAnsCorrect(rs.getString("correct_ans"));
                qBean.setExplanation(rs.getString("q_explanation_id"));
                qBean.setTags(rs.getString("q_tags"));
                qBean.setHelpLink(rs.getString("q_help"));
                qBean.setqType(rs.getString("q_type"));
                qBean.setSource(rs.getString("q_source"));
                qBean.setFigId(rs.getString("fig_id"));
                qBean.setSimQid(rs.getString("sim_q_id"));
                qBean.setqStatus(rs.getString("q_status"));
                //System.out.println(q + ":   " + qt);    System.out.println("DataAccess end:"+i);
                qBeans.add(qBean);
            }
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }        
        return qBeans;
    }
    
    private List<MCQuestion> getDetailedQuestions(String query) throws NamingException, SQLException {
        //   MCQuestion[] qBeans = new MCQuestion[];
        List<MCQuestion> qBeans = new ArrayList<MCQuestion>();
        
        
        
        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            MCQuestion qBean;
            System.out.println("DataAccess: Query" + query);
            ResultSet rs = stmt.executeQuery(query);
            GameFigure fig;
            
            while (rs.next()) {
                qBean = new MCQuestion();
                qBean.setqId(rs.getString("q_id"));
                qBean.setqText(rs.getString("q_text"));
                qBean.setqType(rs.getString("q_type"));
                qBean.setAnsA(rs.getString("ans1"));
                qBean.setAnsB(rs.getString("ans2"));
                qBean.setAnsC(rs.getString("ans3"));
                qBean.setAnsD(rs.getString("ans4"));
                qBean.setAnsE(rs.getString("ans5"));
                qBean.setAnsCorrect(rs.getString("correct_ans"));
                qBean.setExplanation(rs.getString("q_explanation_id"));
                qBean.setTags(rs.getString("q_tags"));
                qBean.setHelpLink(rs.getString("q_help"));
                qBean.setqType(rs.getString("q_type"));
                qBean.setSource(rs.getString("q_source"));
                qBean.setFigId(rs.getString("fig_id"));
                qBean.setSimQid(rs.getString("sim_q_id"));
                qBean.setqStatus(rs.getString("q_status"));
                fig = new GameFigure();
                fig.setFigId(rs.getInt("fig_id"));
                fig.setFigSaveName(rs.getString("fig_save_name"));
                fig.setFigCaption(rs.getString("fig_caption"));
                qBean.setFigure(fig);
                qBeans.add(qBean);
            }
            rs.close();
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }        
        return qBeans;
    }
        
    public List<String> fetchAllTags() throws NamingException, SQLException {
        List<String> listAllTags = new ArrayList<String>();
        String tags;
        String[] strArrTags;
        
        try {            
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            
             rs = stmt.executeQuery("SELECT DISTINCT Q_TAGS FROM g2ldb.mc_questions WHERE Q_TAGS != '' ");
            
            while (rs.next()) {
                tags = rs.getString("q_tags");
                strArrTags = tags.split(";");
                for (int i = 0; i < strArrTags.length; i = i + 1) {
                    if (!strArrTags[i].trim().equals("") && !strArrTags[i].trim().equals("null")) {
                        listAllTags.add(strArrTags[i]);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            rs.close();
            stmt.close();
            con.close();
        }
        
        return listAllTags;
        
    }
    
    public String getAllQTags() throws NamingException, SQLException {
        String allTags = "";
        String tags;
        StringBuilder sb = new StringBuilder();
        
        try {            
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            
             rs = stmt.executeQuery("SELECT DISTINCT Q_TAGS FROM g2ldb.mc_questions WHERE Q_STATUS='5' AND Q_TAGS != '' ");
            
            while (rs.next()) {
                tags = rs.getString("q_tags");
                sb.append(tags.trim());
            }
            allTags = sb.toString();//System.out.println("Tags builder: "+allTags);
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            rs.close();
            stmt.close();
            con.close();
        }
        
        return allTags;
        
    }
    
    public List<String> fetchAllSources() throws NamingException, SQLException {
        List<String> listAllSources = new ArrayList<String>();
        String sources;
        String[] strArrTags;
        
        try {            
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT DISTINCT Q_SOURCE FROM g2ldb.mc_questions WHERE Q_SOURCE != '' ");
            
            while (rs.next()) {
                sources = rs.getString("q_source");
                strArrTags = sources.split(";");
                for (int i = 0; i < strArrTags.length; i = i + 1) {
                    if (!strArrTags[i].trim().equals("") && !strArrTags[i].trim().equals("null")) {
                        listAllSources.add(strArrTags[i]);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }        
        
        return listAllSources;
        
    }
    
    public String getAllQSources() throws NamingException, SQLException {
        
        String sources;
        StringBuilder sb = new StringBuilder();
        
        try{            
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            
             rs = stmt.executeQuery("SELECT DISTINCT Q_SOURCE FROM g2ldb.mc_questions WHERE Q_STATUS='5' AND Q_SOURCE != '' ");
            
            while (rs.next()) {
                sources = rs.getString("q_source");
                sb.append(sources);sb.append(";");
                }            
         
        }catch (SQLException e) {
            System.err.println(e);
        }finally {
            rs.close();
            stmt.close();
            con.close();
        }        
        
        return sb.toString();
        
    }

    // public  fetchWords
    public TestMC fetchTestMC(String testId) throws SQLException, NamingException {
        TestMC testMC = new TestMC();
        String strQuery = "select * from g2ldb.mc_test WHERE TEST_ID=" + testId;
        try {
            con = G2LConnectionPool.getConnection();            
            stmt = con.createStatement();
             rs = stmt.executeQuery(strQuery);
            while (rs.next()) {
                testMC.setTestTitle(rs.getString("TITLE"));
                testMC.setTestId(rs.getString("TEST_ID"));
                testMC.setUserId(rs.getString("USER_ID"));
                testMC.setqIds(rs.getString("Q_LIST"));
                testMC.setTestDuration(rs.getInt("DURATION"));
                testMC.setTestStatus(rs.getString("TEST_STATUS"));                
                testMC.setDateCreated(rs.getTimestamp("date_created"));
                testMC.setDateFrom(rs.getTimestamp("date_from"));
                testMC.setDateTo(rs.getTimestamp("date_to"));
                testMC.setDescription(rs.getString("description"));
            }
        } catch (Exception e) {
            System.err.println(e);
        } finally {
            rs.close();
            stmt.close();
            con.close();
        }        
        testMC.setqIdList(testMC.getqIds().split(";"));
        return testMC;
    }
    
    public List<UserTest> fetchUserTests(String userId) throws SQLException{
        List<UserTest> listUserTests = new ArrayList<UserTest>();
        
        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            UserTest ut;
            
            String query = "SELECT * FROM G2LDB.MC_TEST AS A JOIN G2LDB.USER_TEST B ON A.TEST_ID = B.TEST_ID " +
                                " WHERE B.USER_ID= "+userId+" ORDER BY B.WHEN_FINISHED DESC LIMIT 40;";
            System.out.println("DataAccess: Query" + query);
            ResultSet rs = stmt.executeQuery(query);
            TestMC tmc;
            
            while (rs.next()) {
                
                ut = new UserTest();
                tmc = new TestMC();
                tmc.setTestTitle(rs.getString("title"));
                tmc.setDescription(rs.getString("description"));
                tmc.setTestId(rs.getString("test_id"));
                ut.setScore(rs.getInt("score"));
                ut.setStatus(rs.getString("status"));
                ut.setUserAnswers(rs.getString("user_answers"));
                ut.setTestMC(tmc);

                listUserTests.add(ut);
            }
            rs.close();
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        } 
        
        return listUserTests;
    }
    
    public GameFigure getFigure(String fid) throws SQLException, NamingException{
        GameFigure gFig = new GameFigure();
       String  strQuery = "SELECT * from g2ldb.figures where fig_id ="+fid;
       
           try {            
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            
            ResultSet rs = stmt.executeQuery(strQuery);
            
            while (rs.next()) {
                gFig.setFigId(rs.getInt("fig_id"));
                 gFig.setFigSaveName(rs.getString("fig_save_name"));
                  gFig.setFigOrigName(rs.getString("fig_orig_name"));
                   gFig.setFigCaption(rs.getString("fig_caption"));
                    gFig.setFigSource(rs.getString("fig_source"));
                 //    gFig.setFigCreationDate(rs.getDate("date_change"));
            }
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }
       
       return gFig;
    }
    
    public List<GameFigure> getAllFigures(String userId) throws SQLException, NamingException{
        List <GameFigure> gfl = new ArrayList<GameFigure>();
        GameFigure gFig;
       String  strQuery = "SELECT * from g2ldb.figures where fig_provider ="+userId+" AND FIG_STATUS !='3' ORDER BY DATE_CHANGE DESC LIMIT 40" ;
        System.out.println("Query: "+strQuery);
       
           try {            
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            
             rs = stmt.executeQuery(strQuery);
            
            while (rs.next()) {
                gFig = new GameFigure();
                gFig.setFigId(rs.getInt("fig_id"));
                 gFig.setFigSaveName(rs.getString("fig_save_name"));
                  gFig.setFigOrigName(rs.getString("fig_orig_name"));
                   gFig.setFigCaption(rs.getString("fig_caption"));
                    gFig.setFigSource(rs.getString("fig_source"));
                    gFig.setFigKeywords(rs.getString("fig_keywords"));
                    gFig.setStatus(rs.getString("fig_status"));
                 //    gFig.setFigCreationDate(rs.getDate("date_change"));
                    gfl.add(gFig);
            }
        } catch (SQLException e) {
            System.err.println(e);
        } finally {
               rs.close();
            stmt.close();
            con.close();
        }
       
       return gfl;
    }
}
