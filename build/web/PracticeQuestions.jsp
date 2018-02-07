<%-- 
    Document   : PracticeQuestions
    Created on : Mar 7, 2013, 9:40:42 AM
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
<style>
    #questionTable{height:auto; border: 1px solid green;font: bold large fantasy;border-radius: 10px;}
 </style>

 <%DataAccess da =new DataAccess();

                String tagPar = request.getParameter("tags");
                String qType =request.getParameter("subSelect");
                String qSource = request.getParameter("qSource");
                String provider = request.getParameter("qProvider");
                provider = "";
                //qSource="";
                List<MCQuestion> qBeans = da.fetchQuestions(qType,qSource,tagPar,provider);
                
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
 
   var qCell = document.getElementById('pracQCell')
   var ansCell =  document.getElementById('pracAnsCell');
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
      <!--  <div id="bannerGame2Learn" class="gameBanner" >g2l</div>-->
        <br>
        
        <div style="width:500px;margin: auto;" > 

               
            <form name="qListForm">
                <table style="margin:auto;vertical-align: top;">
                    <tr><td colspan="3">
                          <div style="font-weight: bold;background-color: green;color: white;padding:5px;border-radius:5px;"> 
                            <span>  Number of Questions <%=qBeans.size() %> </span>&nbsp;&nbsp;|&nbsp;&nbsp;
                            <span id="numOfCorr">Correct:0</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; 
                            <span id="score">Score:</span>
                          </div><br>
                        </td></tr>
                    <tr>
                      <td>
                          <img  style="width: 50px"  src="./icons/leftArrow.png" id="btnNext"  onclick="loadQuestion(false)" />
                      </td>
                        <td>
                           <table  id="questionTable" >
                            <tbody>
                                <tr><td id="pracQCell"></td></tr>
                                <tr><td id="pracAnsCell" style="padding: 4px;"></td></tr>   
                            </tbody>
                           </table>
                        </td>
                      <td>
                            <img  style="width: 50px"  src="./icons/rightArrow.png" id="btnPrev"  onclick="loadQuestion(true)" />
                      </td></tr>
                </table>
            </form>
         </div>
    </body>
</html>

