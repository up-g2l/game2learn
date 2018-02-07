<%-- 
    Document   : AccessQBank
    Created on : Mar 2, 2013, 8:10:03 PM
    Author     : upendraprasad
--%>

<%@page import="g2l.dao.QuestionDAO"%>
<%@page import="g2l.util.VocabEng"%>
<%@page import="g2l.util.GPMember"%>
<%@page import="java.util.List"%>
<%@page import="g2l.util.MCQuestion"%>
<%@page import="g2l.dao.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>    
    <style type="text/css">
      #divQList{margin: auto; alignment-adjust: central;width: 780px; padding: 10px;border: 1px green solid;}
    </style>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>

    <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
    <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
    <script type="text/javascript" src="/g2l/js/gameJScript3.js" ></script>
    <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>  



    <script type="text/x-mathjax-config">
      MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']],
      displayMath: [['\\[','\\]'], ['$$','$$']]},
      styles: {
      ".MathJax": {
      color: "#0000FF"
      }
      }

      });
    </script>

    <script>
      $(document).ready(function(){
                
        MathJax.Hub.Queue(['Typeset',MathJax.Hub,'questionTable']);
        //$('#questionTable tr:odd').css("background-color","#CCCCCC");
        // $('#questionTable tr:odd').css("text-align","center");
        $("#btnClose").mouseover(function() { 
          //var src = $(this).attr("src").match(/[^\.]+/) + "over.gif";
          var src = $(this).attr("src").replace("1.png", "X.png");
          $(this).attr("src", src);
        }).mouseout(function() {
          var src = $(this).attr("src").replace("X.png", "1.png");
          $(this).attr("src", src);
        }).mousedown(function() {
          coverToGrayOut1(true); $('#QEditDiv').hide();
        }); 
        //  onmouseover="this.src='images/closeX.jpeg'" onmouseout="this.src='icons/Close1.png'" onclick="coverToGrayOut1(true); $('#QEditDiv').hide();
                
      });
            
            
           
      function coverToGrayOut1(openAlready){ //uses css file having 'coverToGrayOut' as a className
  
        var body = document.body,  html = document.documentElement;
        var heightDoc = Math.max( body.scrollHeight, body.offsetHeight,  html.clientHeight, html.scrollHeight, html.offsetHeight );  
        if(!openAlready){
          coverEle = document.createElement('div');
          coverEle.id='coverToGrayOut'; 
          coverEle.style.className='coverToGrayOut';
          coverEle.style.width = window.innerWidth+'px';
          coverEle.style.height = heightDoc+'px';
          document.getElementsByTagName('body')[0].appendChild(coverEle);
          //alert('HOHO');
        }else{
          //coverEle = document.getElementById('coverToGrayOut');
          //coverEle.style.zIndex='-10';
          document.getElementsByTagName('body')[0].removeChild(coverEle);                       
        }
      }     

      function editQuestion(qId){
        //alert('Question Id is: '+qId);
        fetchQuestionDetails(qId);
    
        X = window.innerWidth;
        Y = window.innerHeight;
                
        boxWidth = 800;
        boxHeight = 500;
                
        boxLeft = (X - boxWidth)/2;
        boxTop = (Y - boxHeight)/2;
        coverToGrayOut1(false);
        qEditEle = document.getElementById('QEditDiv');
        qEditEle.style.top =boxTop+'px';
        qEditEle.style.left =boxLeft+'px';
        qEditEle.style.display = 'block';
      }

      function fetchQuestionDetails(qId){
        $.get("QFetcher?id="+qId,
        function(data,status){var qObj = eval(data);
         // alert("Data: " + qObj.qText + "\nStatus: " + status);
          $('#qId').val(qObj.qId);
          //$('#qNum').val(qNum);
          $('#question').val(qObj.qText);
          $('#ansA').val(qObj.ansA);
          $('#ansB').val(qObj.ansB);
          $('#ansC').val(qObj.ansC);
          $('#ansD').val(qObj.ansD);
          $('#ansE').val(qObj.ansE);
          $('#qSource').val(qObj.source);
          $('#tags').val(qObj.tags);
          $('#helpLink').val(qObj.helpLink);
          $('#subSelect').val(qObj.qType);
          $('#imgId').val(qObj.figId);
          $('#imgQEntry').attr("src","uploadedImages/"+qObj.figName);
          $('#simQid').val(qObj.simQid);
          var idRad = '#rad'+qObj.ansCorr;
          $(idRad).attr("checked","checked");  
          $('label[for="question"]').text('Question (id:'+qObj.qId+')');
          if(qObj.figId!='0'){$('#imgSel').attr("checked","checked");}
        });
      }
            
      function refreshQuestionDetails(qId){
        $.get("QFetcher?id="+qId,function(data,status){var qObj = eval(data);
          // alert("Data: " + qObj.qText + "\nStatus: " + status);
          $('#previewQid').val(qObj.qId);
          //$('#qNum').val(qNum);
          $('#previewQText').text('Question: '+qObj.qText);
          $('#previewAnsA').text('(A) '+qObj.ansA);
          $('#previewAnsB').text('(B) '+qObj.ansB);
          $('#previewAnsC').text('(C) '+qObj.ansC);
          $('#previewAnsD').text('(D) '+qObj.ansD);
          $('#previewAnsE').text('(E) '+qObj.ansE);
          $('#previewSource').text(qObj.source);
          $('#previewTags').text(qObj.tags);
          $('#previewHelp').text(qObj.helpLink);
          $('#previewQImg').html('<img class="imgFig" src="uploadedImages/'+qObj.figId+'"/>');
          //$('#subSelect').val(qObj.qType);
          //  var idRad = '#rad'+qObj.ansCorr;
          // $(idRad).attr("checked","checked");  
          // $('label[for="question"]').text('Question (id:'+qObj.qId+')');
          MathJax.Hub.Queue(['Typeset',MathJax.Hub,'questionTable']);
        });
      }
  
      function qUpdate(){
        //alert('step1');
        if(!validateDataEntry()){  return false;}
        else{ 
          var valRadio = $("input[@name=corr]:checked").val();
          //if($('#qNum').val()==''){alert('Save the question first.'); return false;}
          $.post("QEntry",
          {   qId:$('#qId').val(),
            question: $('#question').val(),
            ansA: $('#ansA').val(),
            ansB : $('#ansB').val(),
            ansC :$('#ansC').val(),        
            ansD : $('#ansD').val(),
            ansE: $('#ansE').val(),
            subSelect: $('#subSelect').val(),       
            correct:valRadio,
            helpLink:$('#helpLink').val(),
            tags: $('#tags').val(),
            source: $('#qSource').val()
          },
          function(data,status){     
            $('#updateQStatus').text('Question Update Status: '+status);
            // showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,true,true ); 
            if(status=='success'){
                            
              var divQEle =document.getElementById('divQBox'+$('#qId').val());                            
              $(divQEle).find('p').text($('#question').val());
              var allSpan = $(divQEle).find('span');//alert(allSpan.eq(1).text());
              allSpan.eq(0).text("(A) "+$('#ansA').val());
              allSpan.eq(1).text("(B) "+$('#ansB').val());
              allSpan.eq(2).text("(C) "+$('#ansC').val());
              allSpan.eq(3).text("(D) "+$('#ansD').val());
              allSpan.eq(4).text("(E) "+$('#ansE').val());
                            
              MathJax.Hub.Queue(['Typeset',MathJax.Hub,divQEle.id]);
              //$('#previewQImg').html('<img class="imgFig" src="uploadedImages/'+qObj.figId+'"/>');
            }
          });
        }
      }
       
    </script>
    <style>
      #question{width: 400px;height: 130px;}
    </style>
    <title>g2l: Access Question Bank</title>

  </head>
  <body>
    <%
      System.out.println("On Question Correction Page");
      HttpSession sesn1 = request.getSession();
      if (sesn1 == null) {
        System.out.println("Session Expired");
        response.sendRedirect("/g2l/index.jsp?status=session_expired");
      }
      GPMember member = (GPMember) sesn1.getAttribute("member");
      DataAccess da = new DataAccess();

      QuestionDAO qd = new QuestionDAO();
      //VocabEng ve = new VocabEng();
          //ve.
%>

    <jsp:include page="gameMenuBar.jsp" />
    <div>
      <br>
      <div style="background-color: #8AC007; color: white;width: 780px;margin: auto;padding: 5px;" >Following is the list of questions with the provided criteria.</div>
      <!-- List of Questions-->
      <div style="position: relative;">
        <br><div id="divQList">

          <% String tagPar = request.getParameter("tags");
            System.out.println("tags: " + tagPar);
            String qType = request.getParameter("subSelect");
            System.out.println("qType: " + qType);
            String qSource = request.getParameter("qSource");
            System.out.println("qSource: " + qSource);
            String qStatus = request.getParameter("qStatus");
            System.out.println("qStatus " + qStatus);
            String qProvider = request.getParameter("qProvider");
            System.out.println("qProvider " + qProvider);
            String fromDate = request.getParameter("qAprvlDate");
            System.out.println("From Date " + fromDate);

            GPMember gm = (GPMember) request.getSession().getAttribute("member");
            if (qProvider != null) {
              qProvider = gm.getId();
            }
            //qSource="";
            List<MCQuestion> qBeans = qd.fetchQuestions(qType, qSource, tagPar, qProvider, qStatus, fromDate,20,false, false);
            String figName = "";

            for (int i = 0; i < qBeans.size(); i++) {
              figName = qBeans.get(i).getFigure().getFigSaveName();
          %>
          <div class="divQBox" id="divQBox<%=qBeans.get(i).getqId()%>">
            <a  onclick="editQuestion(<%=qBeans.get(i).getqId()%>);" class="miniLink">Edit Question</a>
            <p id="previewQText">Question <%= i + 1%>:&nbsp;<%=qBeans.get(i).getqText()%></p>
            <div style="width:100%;position: relative;display: inline-block; ">
              <div style=" width: 400px; float: left;">
                <span class="spanAns">(A)&nbsp;<%=qBeans.get(i).getAnsA()%></span>
                <span class="spanAns">(B)&nbsp;<%=qBeans.get(i).getAnsB()%></span>
                <span class="spanAns">(C)&nbsp;<%=qBeans.get(i).getAnsC()%></span>
                <span class="spanAns">(D)&nbsp;<%=qBeans.get(i).getAnsD()%></span>
                <span class="spanAns">(E)&nbsp;<%=qBeans.get(i).getAnsE()%></span>
              </div>
              <div class="qFigBox">  
                <img src="uploadedImages/<%=figName%>" class="thumbQFig"/>
              </div>
            </div>
            <span class="spanQInfo">Correct Answer: &nbsp;<%=qBeans.get(i).getAnsCorrect()%></span>
            <span class="spanQInfo">Question Source:  &nbsp;<%=qBeans.get(i).getSource()%></span>
            <span class="spanQInfo">Related Tags:  &nbsp;<%=qBeans.get(i).getTags()%></span>
            <span class="spanQInfo">Help:  &nbsp;<%=qBeans.get(i).getHelpLink()%></span>
          </div>        
          <%
            }
          %>
          There are no more questions with the given search criteria.
        </div>
      </div>           
      <div  id="QEditDiv" class="QEditDiv">
        <img src="images/close1.png" class="btnCloseX" id="btnClose"/>
        <form id="frmQ">
          <span id="updateQStatus" style="color:green;font-weight: bold;"></span>

          <br>
          <!--
          <label for="question" >Question #1 (id:)</label>
               <div style="width: 410px;">
                 <textarea id="question"  name="question" maxlength="4000" style="width: 400px;height: 100px;"></textarea>
              </div><br>
          <div style="display: flex;border:1px solid #8AC007; border-radius: 10px; margin: 10px; padding:10px;">

          <div id="div4Answer"  style="width: 250px; ">
              Ans A<input id="ansA" class ="ip1" type="text"  name="ansA" maxlength="50"/>
              <input type="radio" name="corr" id="radA"  value="A"/><br>

              Ans B<input id="ansB"  class ="ip1" type="text"  name="ansB" maxlength="50"/>
              <input type="radio" name="corr" id="radB"   value="B"/><br>

              Ans C<input id="ansC"  class ="ip1" type="text" name="ansC" maxlength="50"/>
              <input type="radio" name="corr" id="radC" value="C"/><br>
              Ans D<input id="ansD" class ="ip1"  type="text" name="ansD" value="All" maxlength="50"/>
              <input type="radio" name="corr" id="radD"  value="D"/><br>

              Ans E<input id="ansE"  class ="ip1" type="text" name="ansE" value="None" maxlength="50"/>
              <input type="radio" name="corr" id="radE"  value="E" checked="checked" /><br>
          </div>
           <div>
          <input id="tag1" class ="ip2" type="text"   name="tags" placeholder="Enter a tag and add"/>
          <input id="btnAddTag" class ="btnMini" type="button" value="+&nbsp;&raquo;" name="tags" onclick="$('#tags').val($('#tags').val()+$('#tag1').val()+'; ');$('#tag1').val('');" />
          <input id="tags" class ="ip1" type="text"   name="tags"  placeholder="Tags" />  <br>          
          <input id="qSource" class ="ip1"  type="text"  name="source"  placeholder="Source of the question"/><br> 
          <input id="helpLink" class ="ip1"  type="text"  name="helpLink"  placeholder="Link for Help"/><br>
          </div>
          </div>


          <label for="explanation" title="Click for providing explanation." onclick="$('#tAreaDiv').toggle();">Explanation</label>
          <div id="tAreaDiv" style="display: none;position: relative;">
              <textarea id="explanation"  name="explanation" maxlength="500"> </textarea>
          </div>-->
          <!--  <input  id="resetQ" type="button" onclick="$('#qNum').val('');$('#qId').val('0');$('#updateQ').attr('disabled','true');reset();" value="Reset for New Question"/>
            <input   id="saveQ" onclick="saveNewQuestion();" type="button"  value="Save as a new Question"/>-->
          <input id="qId" type="hidden" name="qId" value="0"/>
          <input id="qNum" type="hidden" name="qNum" />
          <input id="subSelect" type="hidden" value="" />
          <div style="overflow:hidden;">
            <div style=" padding: 10px;text-align: left;float: left;width: 400px; height:160px;"> 
              <label for="question" >Question #1 (id:)</label><br>
              <textarea id="question"  name="question" maxlength="1500" placeholder="Enter the text of the question here. Use instructions link below for help with typing math."></textarea>

            </div>
            <div id="uploadedImage" style="float:left;width: 300px;position: relative; height:160px;">                                
              <div id="divQImg" class="qFigBox">
                <img id="imgQEntry" src="uploadedImages/0.jpg" class="thumbQFig"/>
                <input type="hidden" value="0" id="imgId" name="imgId" />
              </div>
            </div>
            <div style="width:700px;height: 30px;float:left;vertical-align: middle;">
              <a onclick="popImgUploader()" class="miniLink">Upload Image</a> <!--<a  class="miniLink"  onclick="showInstruction(this);"> Instructions</a>&nbsp;-->
              <a class="miniLink" onclick="validateDataEntry();">Validate</a>                             
              <span style="float:right;"><input type="checkbox" id="imgSel" name="imgSel" disabled="disabled" /> Include this figure in the question?</span>
            </div>
            <div id="div4Answer"  style="float:left; width:300px; padding:10px;">
              (A) <input id="ansA" class ="ip1" type="text"  name="ansA" maxlength="200"/> <input type="radio" name="corr" id="radA" class="radio1" value="A"/><br>
              (B) <input id="ansB"  class ="ip1" type="text"  name="ansB" maxlength="200"/> <input type="radio" name="corr" id="radB" class="radio1"  value="B"/> <br>
              (C) <input id="ansC"  class ="ip1" type="text" name="ansC" maxlength="200"/> <input type="radio" name="corr" id="radC" class="radio1" value="C"/><br>
              (D) <input id="ansD" class ="ip1"  type="text" name="ansD" value="All" maxlength="200"/> <input type="radio" name="corr" id="radD" class="radio1" value="D"/><br>
              (E) <input id="ansE"  class ="ip1" type="text" name="ansE" value="None" maxlength="200"/> <input type="radio" name="corr" id="radE" class="radio1" value="E" checked="checked" />
            </div>    
            <div style="width: 200px;float: left;">                                                         
              <label for="simQid">This Question is similar to.</label>
              <input id="simQid" type="text" name="simQid" value="0"/>
              <input id="tag1" class ="ip2" type="text"   name="tag1" placeholder="Add a tag"/>
              <input id="btnAddTag"  class="btnMini button primary"  type="button" value="+&nbsp;&raquo;" name="tags" onclick="$('#tags').val($('#tags').val()+$('#tag1').val()+'; ');$('#tag1').val('');" />
              <input id="tags" class ="ip1" type="text"   name="tags" placeholder="Enter tag above and press add +" disabled="disabled"/>
              <input id="qSource" class ="ip1"  type="text"  name="source" placeholder="Source of the question"/> 
              <input id="helpLink" class ="ip1"  type="text" name="helpLink" placeholder="Helping Links"/>
            </div>
          </div>  
          <div style="text-align: center;"><input id="updateQ" onclick="qUpdate();" type="button"  value="Update Question"/></div>                                
        </form>            
      </div> 
    </div>
  </body>
</html>
