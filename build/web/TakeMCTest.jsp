<%-- 
    Document   : TakeMCTest
    Created on : Mar 26, 2013, 12:57:00 AM
    Author     : upendraprasad
--%>

<%@page import="util.TestMC"%>
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
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <title>g2l: Practice</title>

        
 <script type="text/x-mathjax-config">
  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']], displayMath: [['\\[','\\]'], ['$$','$$']]},
                       styles: { ".MathJax": { color: "#0000FF"}} ,
                       extensions: ["tex2jax.js"],    
                       "HTML-CSS": { scale: 100}  
                    });
                   
</script>

 <% 
 String testId = request.getParameter("testId");
 
 DataAccess da =new DataAccess();
 TestMC testMC = da.fetchTestMC(testId);
 
 String[] qidList = testMC.getqIdList();

              /*  String tagPar = request.getParameter("tags");
                String qType =request.getParameter("subSelect");
                String qSource = request.getParameter("qSource");
                String provider = request.getParameter("qProvider");
                provider = "";
                //qSource="";
 * */
                List<MCQuestion> qBeans = da.fetchQuestionsByIdList(qidList);
                
                 JSONArray qDB  = new JSONArray();
                 JSONObject qObj;
                 MCQuestion qb;
                
                for ( int i = 0; i < qBeans.size(); i++ ) {
                   qb =  qBeans.get(i);
                   qObj  = new JSONObject();
                   qObj.put("qID", qb.getqId());
                    qObj.put("qText", qb.getqText());
                     qObj.put("ansA", qb.getAnsA());
                      qObj.put("ansB", qb.getAnsB());
                       qObj.put("ansC", qb.getAnsC());
                        qObj.put("ansD", qb.getAnsD());
                         qObj.put("ansE", qb.getAnsE());
                           qObj.put("ansCorr", qb.getAnsCorrect());
                           qDB.put(qObj);                                          
                }
         
        %>
<script>
   var jsonQDB = <%=qDB.toString() %>;  
   var qShowIndex = 0;
   var numCorrect = 0;
   var answered = 0;
   var score = 0;
  


function loadQuestion(next){//alert('Loading Question #'+qShowIndex);
 
   var qCell = document.getElementById('qCellTest')
   var ansCell =  document.getElementById('ansCellTest');
    if(next){qShowIndex +=1;    answered = 0; //alert('Loading Question #'+qShowIndex);
        if(qShowIndex > jsonQDB.length){ $('#pMsg').text("You have reached to the last question.");$('#helpMessage').show();
            setTimeout(function(){$('#helpMessage').hide();},1000); qShowIndex -=1; return false;}
        
       qCell.innerHTML = 'Q'+ qShowIndex +': '+jsonQDB[qShowIndex-1].qText;        
       ansCell.innerHTML = '<a id="ansA" class="miniLink2"  onclick="verifyAnswer(\'A\');">(A) '+jsonQDB[qShowIndex-1].ansA+'</a>'+
                            '<a id="ansB" class="miniLink2"   onclick="verifyAnswer(\'B\');">(B)  '+jsonQDB[qShowIndex-1].ansB+'</a>'+
                             '<a id="ansC" class="miniLink2"   onclick="verifyAnswer(\'C\');">(C)  '+jsonQDB[qShowIndex-1].ansC+'</a>'+
                             '<a id="ansD" class="miniLink2"   onclick="verifyAnswer(\'D\');">(D)  '+jsonQDB[qShowIndex-1].ansD+'</a>'+
                             '<a id="ansE" class="miniLink2"   onclick="verifyAnswer(\'E\');">(E)  '+jsonQDB[qShowIndex-1].ansE+'</a>';
    }
    else{
        qShowIndex -=1;    answered = 2;   //alert('Loading Question #'+qShowIndex);
        if(qShowIndex ==0){ $('#pMsg').text("You are on the first question.");$('#helpMessage').show();
           setTimeout(function(){$('#helpMessage').hide();},1000); qShowIndex +=1; return false;}
        
        qCell.innerHTML = 'Q'+ qShowIndex +': '+jsonQDB[qShowIndex].qText;        
        ansCell.innerHTML = '<a id="ansA" class="miniLink2"   onclick="verifyAnswer(\'A\');">(A) '+jsonQDB[qShowIndex-1].ansA+'</a>'+
                            '<a id="ansB" class="miniLink2"   onclick="verifyAnswer(\'B\');">(B)  '+jsonQDB[qShowIndex-1].ansB+'</a>'+
                             '<a id="ansC" class="miniLink2"   onclick="verifyAnswer(\'B\');">(C)  '+jsonQDB[qShowIndex-1].ansC+'</a>'+
                             '<a id="ansD" class="miniLink2"   onclick="verifyAnswer(\'B\');">(D)  '+jsonQDB[qShowIndex-1].ansD+'</a>'+
                             '<a id="ansE" class="miniLink2" onclick="verifyAnswer(\'B\');">(E)  '+jsonQDB[qShowIndex-1].ansE+'</a>';
    }
    MathJax.Hub.Queue(['Typeset',MathJax.Hub,'questionTable']);
}

function verifyAnswer(strAns){
    if(answered < 1){ answered = 1;
    //alert('You Clicked: '+strAns);
    //alert('CorrectAnswer is: '+jsonQDB[qShowIndex-1].ansCorr);
        $('#ans'+strAns).css("background-color","red");//Make all answeres red
        if(jsonQDB[qShowIndex-1].ansCorr == strAns){
            numCorrect+=1;score+=5; $('#numOfCorr').text('Correct: '+numCorrect);   $('#score').text('Score: '+score);      
            }
        $('#ans'+jsonQDB[qShowIndex-1].ansCorr).css("background-color","lightgreen");//Make the correct green
    }
}


  </script>
    </head>
    
    <body onload="loadQuestion(true)">
<%
HttpSession sesn1 = request.getSession();
GPMember member = (GPMember)sesn1.getAttribute("member");
%>
<jsp:include page="gameMenuBar.jsp" />
   
        <div style="width:500px;margin: auto;" > 
                <div style="font-weight: bold;color: #444444;padding:5px;border-radius:5px;"> 
                    <span>  Number of Questions <%=qBeans.size() %> </span>&nbsp;&nbsp;|&nbsp;&nbsp;
                    <span id="numOfCorr">Correct:0</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; <span id="score">Score:</span>
                </div>    
                <div style="font-weight: bold;background-color: green;color: white;padding:5px;border-radius:5px;">  </div>
            <form name="qListForm">
                <table style="margin:auto;vertical-align: top;">
                    <tr>
                      <td><img  style="width: 50px"  src="./icons/leftArrow.png" id="btnPrev"  onclick="loadQuestion(false)" /></td>
                      <td>
                           <table  id="questionTable" class="" style="width: 400px; border: 1px solid green;padding: 5px;font: bold large fantasy;border-radius: 10px;" >
                            <tbody>
                                <tr><td id="qCellTest">&nbsp;</td></tr>
                                <tr> <td id="ansCellTest" style="padding: 4px;">&nbsp;</td></tr>   
                            </tbody>
                           </table>
                        </td>
                      <td>
                            <img  style="width: 50px"  src="./icons/rightArrow.png" id="btnNext"  onclick="loadQuestion(true)" />
                      </td>
                    </tr>
                </table>
            </form>
                 <div style="font-weight: bold;background-color: green;color: white;padding:5px;border-radius:5px;">  </div> 
        </div>
    </body>
</html>

