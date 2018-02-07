/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package g2l.dao;

import g2l.util.GPMember;
import g2l.util.GameFigure;
import g2l.util.MCQuestion;
import g2l.util.TestMC;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author amit
 */
public class QuestionDAO {

    private Connection con;
    private Statement stmt;
    private ResultSet rs;

    /**
     * Creates a new instance of Main
     */
    public QuestionDAO() {
        rs = null;
        con = null;
        stmt = null;
    }

    public MCQuestion fetchQuestionsById(String qId) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions AS M JOIN g2ldb.figures AS F ON M.FIG_ID=F.FIG_ID  WHERE M.Q_ID=" + qId;
        List<MCQuestion> listQBeans = (List<MCQuestion>) getDetailedQuestions(strQuery);
        MCQuestion qBean = (MCQuestion) listQBeans.get(0);

        qBean.setFigure(new DataAccess().getFigure(qBean.getFigId()));
        return qBean;
    }

    public List<MCQuestion> fetchQuestionsByIdList(String[] qIdList) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions AS MCQ JOIN g2ldb.figures AS F ON MCQ.FIG_ID=F.FIG_ID  WHERE MCQ.Q_STATUS !='9' AND MCQ.SIM_Q_ID IN (9999999";
        for (int i = 0; i < qIdList.length; i++) {
            strQuery += "," + qIdList[i];
        }
        strQuery += ") ORDER BY RAND()";
        List<MCQuestion> listQBeans = (List<MCQuestion>) getDetailedQuestions(strQuery);
        return listQBeans;
    }

    public List<MCQuestion> fetchQuestions(String qType, String qSource, String tags, String qProvider, String qStatus, String fromDate,int maxNumQ, boolean isMemPlus, boolean isCheck) throws NamingException, SQLException {

        if (tags == null) {
            tags = "";
        }
        if (qProvider == null) {
            qProvider = "";
        }
        if (qType == null) {
            qType = "";
        }
        if (qSource == null) {
            qSource = "";
        }
        if (qStatus == null) {
            qStatus = "5";
        }//If qStatus is not provided only approved will be fetched
        if (fromDate == null) {
            fromDate = "";
        }

        
            if(isMemPlus || isCheck){
            return fetchPracticedQuestions(qProvider, qType, qSource, tags, fromDate,maxNumQ, isCheck);
            }else{
                return fetchDetailedQuestions(qType, qSource, tags, qProvider, qStatus, fromDate, maxNumQ);
            }
        /* If Figures are not included, the following codes could be used.
         * if (isFigIncluded) {} else {
            String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE Q_STATUS !='9' ";
            
            if (!qStatus.equals("")) {
                strQuery += "AND  Q_STATUS ='" + qStatus + "' ";
            }
            if (!fromDate.equals("")) {
                strQuery += "AND  DATE_CHANGE > '" + fromDate + "' ";
            }
            
                        
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
        }*/
    }

    private List<MCQuestion> getQuestions(String query) throws NamingException, SQLException {
        //   MCQuestion[] qBeans = new MCQuestion[];
        List<MCQuestion> qBeans = new ArrayList<MCQuestion>();



        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            MCQuestion qBean;
            System.out.println("DataAccess: Query" + query);
            rs = stmt.executeQuery(query);

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
            rs.close();
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
            rs = stmt.executeQuery(query);
            GameFigure fig = new GameFigure();

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
                qBean.setExplanation(rs.getString("q_explanation"));
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

        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            rs.close();
            stmt.close();
            con.close();
        }
        return qBeans;
    }
    
    private List<MCQuestion> fetchDetailedQuestions(String qType, String qSource, String tags, String qProvider, String qStatus, String fromDate, int maxNumQ) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions AS MCQ JOIN g2ldb.figures AS F ON MCQ.FIG_ID=F.FIG_ID  WHERE MCQ.Q_STATUS !='9'  ";

        
         if (!qStatus.equals("")) {
                strQuery += "AND  MCQ.Q_STATUS ='" + qStatus + "' ";
            }
         
         if (!fromDate.equals("")) {
                strQuery += "AND  MCQ.DATE_CHANGE > STR_TO_DATE('" + fromDate + " 00:00:00','%Y-%m-%d %H:%i:%s')";
            }
                    
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
        
        strQuery +=" ORDER BY  MCQ.DATE_CHANGE DESC LIMIT "+maxNumQ;
        
        System.out.println("Query: " + strQuery);

        return getDetailedQuestions(strQuery);
    }
    
    private List<MCQuestion> fetchPracticedQuestions(String userId, String qType, String qSource, String tags, String fromDate, int maxNumQ, boolean isCheck) 
        throws NamingException, SQLException {
        String strQuery = " SELECT * FROM g2ldb.user_practice  P JOIN g2ldb.mc_questions  M ON P.Q_ID = M.Q_ID "+
                           " JOIN g2ldb.figures AS F ON M.FIG_ID=F.FIG_ID WHERE P.USER_ID="+userId;   
        
        if(isCheck){
            strQuery +=" AND (P.CHECK_MARK='1') ";
        }else{
            strQuery +=" AND (P.NUM_WRONG > P.NUM_RIGHT OR P.CHECK_MARK='1') ";
        }
                    
        if (!tags.equals("")) {
            String[] strArrTags = tags.split(";");
            strQuery += "AND ( M.Q_TAGS LIKE '%" + strArrTags[0] + ";%'";
            for (int i = 1; i < strArrTags.length; i++) {
                strQuery += " OR M.Q_TAGS LIKE  '%" + strArrTags[i] + ";%'";
            }
            strQuery += ")";
        }
         if (!fromDate.equals("")) {
                strQuery += "AND  M.DATE_CHANGE > STR_TO_DATE('" + fromDate + " 00:00:00','%Y-%m-%d %H:%i:%s')";
            }

        if (!qType.equals("")) {
            strQuery += "AND M.Q_TYPE LIKE '%" + qType + "%'";
        }
        if (!qSource.equals("")) {
            strQuery += "AND M.Q_SOURCE LIKE '%" + qSource + "%'";
        }

        strQuery +=" ORDER BY (P.NUM_WRONG - P.NUM_RIGHT), P.PRAC_DATE LIMIT "+maxNumQ;
        
        System.out.println("Query: " + strQuery);

         List<MCQuestion> qBeans = new ArrayList<MCQuestion>();



        try {
            con = G2LConnectionPool.getConnection();
            stmt = con.createStatement();
            MCQuestion qBean;
            System.out.println("DataAccess: Query" + strQuery);
            rs = stmt.executeQuery(strQuery);
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
                qBean.setChecked(false);
                if(rs.getString("check_mark").equals("1")){
                    qBean.setChecked(true);
                }
                fig = new GameFigure();
                fig.setFigId(rs.getInt("fig_id"));
                fig.setFigSaveName(rs.getString("fig_save_name"));
                fig.setFigCaption(rs.getString("fig_caption"));
                qBean.setFigure(fig);
                qBeans.add(qBean);
            }

        } catch (SQLException e) {
            System.err.println(e);
        } finally {
            rs.close();
            stmt.close();
            con.close();
        }
        return qBeans;
    }

    public List<MCQuestion> fetchGateway(String qType, String qSource, String tags, String qProvider, String qStatus, String fromDate,int maxNumQ, boolean isMemPlus, boolean isCheck) throws NamingException, SQLException {

        if (tags == null) {
            tags = "";
        }
        if (qProvider == null) {
            qProvider = "";
        }
        if (qType == null) {
            qType = "";
        }
        if (qSource == null) {
            qSource = "";
        }
        if (qStatus == null) {
            qStatus = "5";
        }//If qStatus is not provided only approved will be fetched
        if (fromDate == null) {
            fromDate = "";
        }

        return fetchGatewayQuestions(qType, qSource, tags, qProvider, qStatus, fromDate, maxNumQ);
           /* if(isMemPlus || isCheck){
            return fetchPracticedQuestions(qProvider, qType, qSource, tags, fromDate,maxNumQ, isCheck);
            }else{
                return fetchDetailedQuestions(qType, qSource, tags, qProvider, qStatus, fromDate, maxNumQ);
            }
         If Figures are not included, the following codes could be used.
         * if (isFigIncluded) {} else {
            String strQuery = "SELECT * FROM g2ldb.mc_questions WHERE Q_STATUS !='9' ";
            
            if (!qStatus.equals("")) {
                strQuery += "AND  Q_STATUS ='" + qStatus + "' ";
            }
            if (!fromDate.equals("")) {
                strQuery += "AND  DATE_CHANGE > '" + fromDate + "' ";
            }
            
                        
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
        }*/
    }

    private List<MCQuestion> fetchGatewayQuestions(String qType, String qSource, String tags, String qProvider, String qStatus, String fromDate, int maxNumQ) throws NamingException, SQLException {
        String strQuery = "SELECT * FROM g2ldb.mc_questions AS MCQ JOIN g2ldb.figures AS F ON MCQ.FIG_ID=F.FIG_ID  WHERE MCQ.Q_STATUS !='9' AND MCQ.Q_ID = MCQ.SIM_Q_ID ";

        
         if (!qStatus.equals("")) {
                strQuery += "AND  MCQ.Q_STATUS ='" + qStatus + "' ";
            }
         
         if (!fromDate.equals("")) {
                strQuery += "AND  MCQ.DATE_CHANGE > STR_TO_DATE('" + fromDate + " 00:00:00','%Y-%m-%d %H:%i:%s')";
            }
                    
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
        
        strQuery +=" ORDER BY  MCQ.DATE_CHANGE DESC LIMIT "+maxNumQ;
        
        System.out.println("Query: " + strQuery);

        return getDetailedQuestions(strQuery);
    }
}
