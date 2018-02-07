<%-- 
    Document   : GREFlash
    Created on : Mar 18, 2013, 10:50:10 PM
    Author     : upendraprasad
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dao.DataEntry1"%>
<%-- 
    Document   : flashCard
    Created on : Mar 7, 2013, 3:58:24 PM
    Author     : upendraprasad
--%>



<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="util.GPMember"%>
<%@page import="java.util.List"%>
<%@page import="util.MCQuestion"%>
<%@page import="dao.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

        <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
        <script type="text/javascript" src="/g2l/js/gameJScript3.js" ></script>
        <script type="text/javascript" src="./js/jsUtil.js" ></script>
        <script type="text/javascript" src="./flip/jqflippy.js" ></script>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <title>G2L: Flash Cards</title>



 <% 
 String regEx = request.getParameter("regEx");
 String regEx2 = request.getParameter("regEx2");
 DataAccess da =new DataAccess();
 DataEntry1 de1 = new DataEntry1();
 Connection conn = de1.getConn();
 
 String query = "SELECT * from APP.TBL_ENG_WORDS WHERE WORD LIKE '"+regEx.trim()+"%' AND WORD LIKE '%"+regEx2.trim()+"%'";

      Statement st  = conn.createStatement();
      ResultSet rs = st.executeQuery(query);
 
                
                 JSONArray qDB  = new JSONArray();
                 JSONObject qObj;
       while(rs.next()){
           qObj  = new JSONObject();
           qObj.put("word", rs.getString("WORD"));
           qObj.put("meaning", rs.getString("meaning"));
           qDB.put(qObj);     
       }
         
        %>
<script>
   var jsonWordDB = <%=qDB.toString() %>;  
   var qShowIndex = 0;
   var numCorrect = 0;
   var answered = 0;
  
function loadQuestion(next){//alert('Loading Question #'+qShowIndex);
   $('#ansCell').hide();   $('#qCell').show(); //Show the word card.
   
   var qCell = document.getElementById('qCell')
   var ansCell =  document.getElementById('ansCell');
   
    if(next && qShowIndex <= jsonWordDB.length){qShowIndex +=1;       }
    if(!next && qShowIndex > 0){qShowIndex -=1;}
        
        qCell.innerHTML = '<span class="word">Word '+ qShowIndex +': '+jsonWordDB[qShowIndex-1].word+'</span>';        
        ansCell.innerHTML = '<ul><li><span id="ansA"   onclick="verifyAnswer(\'A\');">'+jsonWordDB[qShowIndex-1].meaning.replace(/;/g,"</li><li> ")+'</span></li></ul>';  

 

}


function verifyAnswer(strAns){
    if(answered < 1){ answered = 1;
    //alert('You Clicked: '+strAns);
    //alert('CorrectAnswer is: '+jsonWordDB[qShowIndex-1].ansCorr);
        $('#ans'+strAns).css("background-color","red");
        if(jsonWordDB[qShowIndex-1].ansCorr == strAns){
            numCorrect+=1; $('#numOfCorr').text('Correct: '+numCorrect);        
            }
        $('#ans'+jsonWordDB[qShowIndex-1].ansCorr).css("background-color","lightgreen");
    }
}

  </script>
  <style>
      #qCell,#ansCell{background-color: #EEEEEE;width: 492px;font-size: 40px;
                        padding:25px; position: relative; height: 236px;
                        text-align: left;vertical-align: top;font-size: 20px; line-height: 28px;background-image: url(./images/Grid5.gif)
                     }
      .flashBar{background-color: green;color: white;padding-left:5px;border-radius:5px;vertical-align: middle;}
      
      .flashGRE{position: relative;border: 1px solid cornflowerblue;}
      .word{display: block; background-color: #dddddd; font-size: 40px;padding: 5px; }
      li{display: list-item; background-color: #dddddd; font-size: 20px;padding: 2px;margin: 2px;}
  </style>
    </head>
    
    <body onload="loadQuestion(true)" style="margin: auto;">

      <jsp:include page="gameMenuBar.jsp" />
        <br>
        <div style="width:700px;margin: auto;">
            <form name="qListForm">
                <div class="flashBar"> 
                    Mark on&nbsp;&nbsp;<input type="radio" name="markOnOff" value="on" />&nbsp;&nbsp;
                    off&nbsp;&nbsp;<input type="radio" name="markOnOff" value="off" />&nbsp;&nbsp;
                    normal&nbsp;&nbsp;<input type="radio" name="markOnOff" value="" checked="checked"/>
                </div>
                <table style="margin:auto;text-align: center;vertical-align: middle;">
                    <tbody>
                        <tr>
                            <td>
                                <img   style="width: 80px" src="./icons/leftArrow.png" id="btnPrev"  onclick="loadQuestion(false)" />
                            </td>
                            <td><div class="flashGRE">
                                    <div onclick="$(this).hide();$('#ansCell').toggle();" id="qCell"></div> 
                                    <div id="ansCell" onclick="$(this).hide();$('#qCell').toggle();" style="display: none;"></div>
                                 </div>
                            </td>
                            <td>
                                <img  style="width: 80px"  src="./icons/rightArrow.png" id="btnNext"  onclick="loadQuestion(true);" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="flashBar"> 
                Number of words: <%=qDB.length() %></div>
            </form>
</div>
    </body>
</html>


