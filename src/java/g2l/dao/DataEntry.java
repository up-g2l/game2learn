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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.naming.NamingException;

/**
 *
 * @author upendraprasad
 */
public class DataEntry {

    private Statement stmt;
    private PreparedStatement pst;
    private Connection con;
    private String strQuery;
    private ResultSet rs;

    public DataEntry() {
        strQuery = "";
        stmt = null;
        pst = null;
        con = null;
        rs = null;
    }

    public String createNewTest(TestMC mcTest) throws SQLException, NamingException {
        String testId = "";

        /*  strQuery = "INSERT INTO g2ldb.mc_test(USER_ID, Q_LIST, DURATION, TEST_STATUS) VALUES(" + mcTest.getUserId()
         + ", '" + mcTest.getqIds() + "'," + mcTest.getTestDuration() + ",'" + mcTest.getTestStatus() + "')";
         */

        strQuery = "INSERT INTO g2ldb.mc_test(USER_ID, Q_LIST, DURATION, TEST_STATUS,DATE_FROM, DATE_TO, DESCRIPTION) VALUES(?,?,?,?,?,?,?)";

        try {
            con = G2LConnectionPool.getConnection();
            pst = con.prepareStatement(strQuery, Statement.RETURN_GENERATED_KEYS);

            pst.setString(1, mcTest.getUserId());
            pst.setString(2, mcTest.getqIds());
            pst.setInt(3, mcTest.getTestDuration());
            pst.setString(4, mcTest.getTestStatus());
            pst.setTimestamp(5, Timestamp.valueOf("2000-06-02 00:00:00"));//Dafault date time value
            pst.setTimestamp(6, Timestamp.valueOf("2020-06-02 00:00:00"));
            pst.setString(7, mcTest.getDescription());



            int rowAffected = pst.executeUpdate();

            if (rowAffected == 0) {
                throw new SQLException("Test Creation Failed.");
            }
            rs = pst.getGeneratedKeys();
            if (rs.next()) {
                testId = rs.getString(1);
            } else {
                throw new SQLException("Creating test failed, no generated key obtained.");
            }

            rs.close();

            System.out.println("New Test Id:" + testId);

        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            pst.close();
            con.close();
        }
        return testId;
    }

    public int updateTest(TestMC mcTest) throws NamingException, SQLException {

        int rowsUpdated = 0;
         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
        //  strQuery = "UPDATE  g2ldb.mc_test SET QUESTION_LIST='" + mcTest.getqIds() + "', DURATION= " + mcTest.getTestDuration() + ", STATUS='" + mcTest.getTestStatus() + "' WHERE TEST_ID=" + mcTest.getTestId();

        strQuery = "UPDATE  g2ldb.mc_test SET"
                + " DURATION= ?, TEST_STATUS=?, DATE_FROM=?, DATE_TO = ?, DESCRIPTION=?,  TITLE=?"
                + "WHERE TEST_ID=?";

        try {
            
            con = G2LConnectionPool.getConnection();
            pst = con.prepareStatement(strQuery);

            //pst.setString(1, mcTest.getqIds());
            pst.setInt(1, mcTest.getTestDuration());
            pst.setString(2, mcTest.getTestStatus());
             
            String dateFrom = sdf.format(mcTest.getDateFrom())+" 00:00:00";
             String dateTo = sdf.format(mcTest.getDateTo())+" 00:00:00";
             
             System.out.println("date from :"+dateFrom);
             
             System.out.println("Changed on :"+new SimpleDateFormat("yyyy-mm-dd hh:mm:ss").format(new Date()));
             
            pst.setTimestamp(3, Timestamp.valueOf(dateFrom.trim()));
            pst.setTimestamp(4, Timestamp.valueOf(dateTo.trim()));
            pst.setString(5, mcTest.getDescription());
          //  pst.setTimestamp(6, Timestamp.valueOf(new SimpleDateFormat("yyyy-mm-dd hh:mm:ss").format(new Date())));
            pst.setString(6, mcTest.getTestTitle());
            pst.setInt(7, Integer.parseInt(mcTest.getTestId()));


            //System.out.println("Query String:" + strQuery);

            rowsUpdated = pst.executeUpdate();


        } catch (SQLException e) {
            System.err.println(e.getMessage());
        } finally {
            pst.close();
            con.close();
        }
        return rowsUpdated;
    }

    public String createNewUser(GPMember newUser) throws NamingException, SQLException {

        String userId = "";
        strQuery = "INSERT INTO G2LDB.USER_INFO(LOGIN,PASSWORD,USER_NAME, EMAIL, USER_TYPE, USER_LEVEL)"
                + "values ('" + newUser.getLogin() + "',  '" + newUser.getPassword() + "',  '" + newUser.getName()
                + "','" + newUser.getEmail() + "',  '" + newUser.getUserType() + "', 'High School')";


        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();

            System.out.println("Query String:" + strQuery);

            int rowsUpdated = stmt.executeUpdate(strQuery);

            rs = stmt.executeQuery("SELECT MAX(USER_ID) FROM G2LDB.USER_INFO");
            while (rs.next()) {
                userId = rs.getString(1);
            }
            rs.close();

            System.out.println("User Id:" + userId);




        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }
        return userId;
    }

    public String updateUserInfo(GPMember newUser) throws NamingException, SQLException {
        String userId = newUser.getId();

        strQuery = "UPDATE G2LDB.USER_INFO SET LOGIN='" + newUser.getLogin() + "',PASSWORD='" + newUser.getPassword() + "',USER_NAME='" + newUser.getName()
                + "', USER_TYPE='" + newUser.getUserType() + "', EMAIL = '" + newUser.getEmail() + "' WHERE USER_ID=" + userId;

        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();

            System.out.println("Query String:" + strQuery);

            int rowsUpdated = stmt.executeUpdate(strQuery);

        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }
        return userId;
    }
    
        public int changeUserPass(GPMember newUser) throws NamingException, SQLException {
   

        strQuery = "UPDATE G2LDB.USER_INFO SET PASSWORD='" + newUser.getPassword() + "', TOKEN=''  WHERE EMAIL='" + newUser.getEmail()+"' AND TOKEN='"+newUser.getToken()+"'";
            int rowsUpdated=0;
            
        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();

            System.out.println("Query String:" + strQuery);

             rowsUpdated = stmt.executeUpdate(strQuery);

        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }
        return rowsUpdated;
    }

    public String enterQuestion(MCQuestion questBean) throws NamingException, SQLException { //Enter a question and returns the questio id
        String qId = "";

        System.out.println("Entering Question Data:");
        questBean.setqStatus("0");


        try {
            con = G2LConnectionPool.getConnection();

            /* strQuery = "INSERT INTO g2ldb.mc_questions(QUESTION,QTYPE,ANS1,ANS2,ANS3,ANS4,ANS5,CORRECT_ANS,"
             + "TAGS,EXPLANATION,HELP,SOURCE,Q_STATUS, PROVIDER, SIM_QID, FIG_ID) VALUES ('"
             + questBean.getqText() + "', '" + questBean.getqType() + "','" + questBean.getAnsA() + "','" + questBean.getAnsB() + "','"
             + questBean.getAnsC() + "','" + questBean.getAnsD() + "','" + questBean.getAnsE() + "','" + questBean.getAnsCorrect() + "','"
             + questBean.getTags() + "','" + questBean.getExplanation() + "','" + questBean.getHelpLink() + "','"
             + questBean.getSource() + "','" + questBean.getqStatus() + "'," + questBean.getProvider() + ","
             + questBean.getSimQid() + "," + questBean.getFigId() + ")";

             System.out.println("Query String:" + strQuery);*/

            strQuery = "INSERT INTO g2ldb.mc_questions(Q_TEXT,Q_TYPE,ANS1,ANS2,ANS3,ANS4,ANS5,CORRECT_ANS,"
                    + "Q_TAGS,Q_EXPLANATION,Q_HELP,Q_SOURCE,Q_STATUS, Q_PROVIDER, SIM_Q_ID, FIG_ID) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pst = con.prepareStatement(strQuery, Statement.RETURN_GENERATED_KEYS);

            pst.setString(1, questBean.getqText());
            pst.setString(2, questBean.getqType());
            pst.setString(3, questBean.getAnsA());
            pst.setString(4, questBean.getAnsB());
            pst.setString(5, questBean.getAnsC());
            pst.setString(6, questBean.getAnsD());
            pst.setString(7, questBean.getAnsE());
            pst.setString(8, questBean.getAnsCorrect());
            pst.setString(9, questBean.getTags());
            pst.setString(10, questBean.getExplanation());
            pst.setString(11, questBean.getHelpLink());
            pst.setString(12, questBean.getSource());
            pst.setString(13, questBean.getqStatus());
            pst.setString(14, questBean.getProvider());
            pst.setString(15, questBean.getSimQid());
            pst.setString(16, questBean.getFigId());

            //  System.out.println("Prepared SQL is : "+pst.getPreparedSql());

            // int rowsUpdated = stmt.executeUpdate(strQuery);
            //pst.executeQuery();
            //con.commit();

            int rowAffected = pst.executeUpdate();

            if (rowAffected == 0) {
                throw new SQLException("Creating a new question failed, no rows affected.");
            }
            rs = pst.getGeneratedKeys();
            if (rs.next()) {
                qId = rs.getString(1);
            } else {
                throw new SQLException("Creating question failed, no generated key obtained.");
            }

            rs.close();

            System.out.println("Question Id:" + qId);

        } catch (SQLException e) {
            throw new SQLException("Some database error occured" + e.getMessage());
        } finally {

            pst.close();
            con.close();
        }

        return qId;

    }

    public int updateQuestion(MCQuestion questBean) throws NamingException, SQLException { //Enter a question and returns the questio id
        String qId = questBean.getqId();
        int updated = 0;

        System.out.println("Step 0");


        try {
            con = G2LConnectionPool.getConnection();


            /*strQuery = "UPDATE  g2ldb.mc_questions SET Q_TEXT='" + questBean.getqText() + "',Q_TYPE='"
             + questBean.getqType() + "',ANS1='" + questBean.getAnsA() + "',ANS2='" + questBean.getAnsB() + "',ANS3='"
             + questBean.getAnsC() + "',ANS4='" + questBean.getAnsD() + "',ANS5='" + questBean.getAnsE() + "',CORRECT_ANS='"
             + questBean.getAnsCorrect() + "'," + "Q_TAGS='" + questBean.getTags() + "', Q_SOURCE='" + questBean.getSource() + "'"
             + ",Q_HELP='" + questBean.getHelpLink() + "' WHERE Q_ID =" + qId;*/

            strQuery = "UPDATE  g2ldb.mc_questions SET Q_TEXT=?,Q_TYPE=?,ANS1=?,ANS2=?,ANS3=?,ANS4=?, ANS5=?, CORRECT_ANS=?, Q_TAGS=?, Q_SOURCE=?,Q_HELP= ?, FIG_ID=?, Q_EXPLANATION=?, SIM_Q_ID=? WHERE Q_ID = ?";

            pst = con.prepareStatement(strQuery);

            pst.setString(1, questBean.getqText());
            pst.setString(2, questBean.getqType());
            pst.setString(3, questBean.getAnsA());
            pst.setString(4, questBean.getAnsB());
            pst.setString(5, questBean.getAnsC());
            pst.setString(6, questBean.getAnsD());
            pst.setString(7, questBean.getAnsE());
            pst.setString(8, questBean.getAnsCorrect());
            pst.setString(9, questBean.getTags());
            pst.setString(10, questBean.getSource());
            pst.setString(11, questBean.getHelpLink());
            pst.setInt(12, Integer.parseInt(questBean.getFigId()));
            pst.setString(13, questBean.getExplanation());
            pst.setString(14, questBean.getSimQid());
             pst.setInt(15, Integer.parseInt(questBean.getqId()));

            System.out.println("Query String:" + strQuery);
            updated = pst.executeUpdate();
            if (updated == 0) {
                return 0;
            }
           

        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            pst.close();
            con.close();
        }
        return updated;
    }

    public int updateQStatus(String qId, String qStatus) throws NamingException, SQLException {

        int updated = 0;

        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();

            strQuery = "UPDATE  g2ldb.mc_questions SET Q_STATUS='" + qStatus + "' WHERE Q_ID =" + qId;

            System.out.println("Query String:" + strQuery);
            updated = stmt.executeUpdate(strQuery);
            if (updated == 0) {
                return 0;
            }

        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }
        return updated;
    }

    public int enterTestData(String testId, String userId, String ansList) throws NamingException, SQLException {

        int score = 0;
        Date testDate = new Date();
        SimpleDateFormat df = new SimpleDateFormat("MM/dd/YYYY HH:mm AM");
        String formattedDate = df.format(testDate);
        strQuery = "INSERT INTO g2ldb.user_test (TEST_ID, USER_ID, TEST_DATA, STATUS, SCORE, DATE_FINISH)"
                + " VALUES(" + testId + ", " + userId + ", '" + ansList + "','2'," + score + ",'" + formattedDate + "')";

        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            System.out.println("Query String:" + strQuery);

            int rowsUpdated = stmt.executeUpdate(strQuery);
            con.commit();

            con.close();


        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            stmt.close();
            con.close();
        }


        return score;
    }

    public int createNewImage(GameFigure figure) throws NamingException, SQLException {

        int figId = 0;
        strQuery = "INSERT INTO g2ldb.figures(FIG_ORIG_NAME, FIG_SAVE_NAME,  FIG_KEYWORDS, FIG_CAPTION, FIG_SOURCE, FIG_PROVIDER) VALUES(?,?,?,?,?,?)";

        System.out.println("Fig Entry Query: " + strQuery);


        try {
            con = G2LConnectionPool.getConnection();
            pst = (PreparedStatement) con.prepareStatement(strQuery, Statement.RETURN_GENERATED_KEYS);
            pst.setString(1, figure.getFigOrigName());
            pst.setString(2, figure.getFigSaveName());
            pst.setString(3, figure.getFigKeywords());
            pst.setString(4, figure.getFigCaption());
            pst.setString(5, figure.getFigSource());
            pst.setString(6, figure.getFigProvider());

            int rowAffected = pst.executeUpdate();

            if (rowAffected == 0) {
                throw new SQLException("Creating Image entry failed, no rows affected.");
            }
            rs = pst.getGeneratedKeys();
            if (rs.next()) {
                figId = rs.getInt(1);
            } else {
                throw new SQLException("Creating user failed, no generated key obtained.");
            }
            System.out.println("New Figure Id:" + figId);

        } catch (SQLException ex) {
            throw new SQLException(ex.getMessage() + " Could not create new empty figure entry.", ex);
        } finally {
            rs.close();
            pst.close();
            con.close();
        }
        return figId;
    }

    public int updateImage(GameFigure figure) throws NamingException, SQLException {

        strQuery = "UPDATE  g2ldb.figures SET DATE_CHANGE = ? ";
        if (figure.getFigKeywords() != null) {
            strQuery += ", FIG_KEYWORDS = '" + figure.getFigKeywords() + "' ";
        }
        if (figure.getFigCaption() != null) {
            strQuery += ", FIG_CAPTION = '" + figure.getFigCaption() + "' ";
        }
        if (figure.getFigSource() != null) {
            strQuery += ", FIG_SOURCE = '" + figure.getFigSource() + "' ";
        }
        if (figure.getFigSaveName() != null) {
            strQuery += ", FIG_SAVE_NAME = '" + figure.getFigSaveName() + "' ";
        }
        if (figure.getStatus() != "") {
            strQuery += ", FIG_STATUS = '" + figure.getStatus() + "' ";
        }
        strQuery += " WHERE FIG_ID = " + figure.getFigId();




        System.out.println(" Image Data Update Query: " + strQuery);

        int rowsUpdated = 0;

        try {
            con = G2LConnectionPool.getConnection();
            pst = (PreparedStatement) con.prepareStatement(strQuery);

            pst.setTimestamp(1, new Timestamp(new Date().getTime()));

            rowsUpdated = pst.executeUpdate();
            System.out.println("Rows Updated: " + rowsUpdated);

        } catch (SQLException ex) {
            throw new SQLException("Failure in image data updation. " + ex.getMessage());
        } finally {
            pst.close();
            con.close();
        }
        return rowsUpdated;
    }
}
