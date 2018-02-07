<%-- 
    Document   : flashCard
    Created on : Mar 7, 2013, 3:58:24 PM
    Author     : upendraprasad
--%>



<%@page import="g2l.util.GPMember"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="g2l.util.GPMember"%>
<%@page import="java.util.List"%>
<%@page import="g2l.util.MCQuestion"%>
<%@page import="g2l.dao.DataAccess"%>
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
  


function loadQuestion(next){//alert('Loading Question #'+qShowIndex);
 
   var qCellFC = document.getElementById('qCellFC')
   var ansCellFC =  document.getElementById('ansCellFC');
    if(next){qShowIndex +=1;    answered = 0; //alert('Loading Question #'+qShowIndex);
        if(qShowIndex > jsonQDB.length){ //alert('There are no more questions:'+jsonQDB.length+', and '+qShowIndex);
            qShowIndex -=1; return false;}
        
       qCellFC.innerHTML = 'Question '+ qShowIndex +': '+jsonQDB[qShowIndex-1].qText;        
       ansCellFC.innerHTML = '<a id="ansA" class="miniLink2"  onclick="verifyAnswer(\'A\');">(A) '+jsonQDB[qShowIndex-1].ansA+'</a><br>'+
                            '<a id="ansB" class="miniLink2"   onclick="verifyAnswer(\'B\');">(B)  '+jsonQDB[qShowIndex-1].ansB+'</a><br>'+
                             '<a id="ansC" class="miniLink2"   onclick="verifyAnswer(\'C\');">(C)  '+jsonQDB[qShowIndex-1].ansC+'</a><br>'+
                             '<a id="ansD" class="miniLink2"   onclick="verifyAnswer(\'D\');">(D)  '+jsonQDB[qShowIndex-1].ansD+'</a><br>'+
                             '<a id="ansE" class="miniLink2"   onclick="verifyAnswer(\'E\');">(E)  '+jsonQDB[qShowIndex-1].ansE+'</a><br>';
    }
    else{
        qShowIndex -=1;    answered = 2;   //alert('Loading Question #'+qShowIndex);
        if(qShowIndex ==0){ //alert('YOu are on the first Question');
            return false;}
        
        qCellFC.innerHTML = 'Question '+ qShowIndex +': '+jsonQDB[qShowIndex].qText;        
        ansCellFC.innerHTML = '<a id="ansA" class="miniLink2"   onclick="verifyAnswer(\'A\');">(A) '+jsonQDB[qShowIndex-1].ansA+'</a><br>'+
                            '<a id="ansB" class="miniLink2"   onclick="verifyAnswer(\'B\');">(B)  '+jsonQDB[qShowIndex-1].ansB+'</a><br>'+
                             '<a id="ansC" class="miniLink2"   onclick="verifyAnswer(\'B\');">(C)  '+jsonQDB[qShowIndex-1].ansC+'</a><br>'+
                             '<a id="ansD" class="miniLink2"   onclick="verifyAnswer(\'B\');">(D)  '+jsonQDB[qShowIndex-1].ansD+'</a><br>'+
                             '<a id="ansE" class="miniLink2" onclick="verifyAnswer(\'B\');">(E)  '+jsonQDB[qShowIndex-1].ansE+'</a><br>';
    }
    MathJax.Hub.Queue(['Typeset',MathJax.Hub,'questionTable']);
}

function verifyAnswer(strAns){
    if(answered < 1){ answered = 1;
    //alert('You Clicked: '+strAns);
    //alert('CorrectAnswer is: '+jsonQDB[qShowIndex-1].ansCorr);
        $('#ans'+strAns).css("background-color","red");
        if(jsonQDB[qShowIndex-1].ansCorr == strAns){
            numCorrect+=1; $('#numOfCorr').text('Correct: '+numCorrect);        
            }
        $('#ans'+jsonQDB[qShowIndex-1].ansCorr).css("background-color","lightgreen");
    }
}

 
  $(function() {
    $( "#tag1" ).autocomplete({
      source: allTags
    });
        $( "#qSource" ).autocomplete({
      source: allSources
    });
    
  });
  </script>
    </head>
    
    <body onload="loadQuestion(true)" style="margin: auto;">
<%
HttpSession sesn1 = request.getSession();
GPMember member = (GPMember)sesn1.getAttribute("member");
%>
      <jsp:include page="gameMenuBar.jsp" />
       
        <!--  <div id="bannerGame2Learn" class="gameBanner" >g2l</div>-->
        <br>
        <div style="width:600px;margin: auto;">
            <form name="qListForm">
                <table style="margin:auto;">
                    <tbody>
                        <tr>
                            <td><img onmouseover="this.style.opacity='0.8'" src="./icons/left1.jpeg" id="btnPrev"  onclick="loadQuestion(false)" /></td>
                            <td>
        <table  id="questionTable" class="qTbl2" style="border: 1px solid green;border-radius: 10px;margin: auto;" >
            <thead>
                <tr >
                    <th id="numOfCorr"></th>
                </tr>
            </thead>
            <tbody>
                <tr><td >
                        <div onclick="$(this).toggle('slow');$('#ansCellFC').toggle('slow');" id="qCellFC" style=" height: 250px;display: display;"></div> 
                        <div id="ansCellFC" onclick="$(this).toggle('slow');$('#qCellFC').toggle('slow');" style="height:250px;display: none"></div></td></tr>    
            </tbody>
        </table> 
                                
                            </td>
                            <td><img  onmouseover="this.style.opcity='0.8'"   src="./icons/right1.jpeg" id="btnNext"  onclick="loadQuestion(true)" /></td>
                        </tr>
                    </tbody>
                </table>

                
            </form>
</div>
    </body>
</html>


