<%-- 
    Document   : mcTestPreview
    Created on : Jun 3, 2014, 11:49:52 AM
    Author     : upendraprasad
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 
    Document   : TakeMCTest
    Created on : Mar 26, 2013, 12:57:00 AM
    Author     : upendraprasad
--%>

<%@page import="g2l.util.TestMC"%>
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
            var jsonQDB={}; 
            var qShowIndex = 0;
            var numCorrect = 0;
            var answered = 0;
            var score = 0;
  
            $(document).ready(function(){
                jsonQDB = eval($('#allQData').val());
                console.log(jsonQDB);
                $('#previewQText').text(jsonQDB[0].qText);
                var ansEle = $('#divAnsBox').find('span');
                ansEle.eq(0).text(jsonQDB[0].ansA);
                ansEle.eq(1).text(jsonQDB[0].ansB);
                ansEle.eq(2).text(jsonQDB[0].ansC);
                ansEle.eq(3).text(jsonQDB[0].ansD);
                ansEle.eq(4).text(jsonQDB[0].ansE);
                $('#imgQFig').attr('src','uploadedImages/'+jsonQDB[0].figName);
                qShowIndex = 1;
                 
                $('#aBtnCreateTest').click(function(){
                    if(!window.confirm("Are you sure you want to create the test?")){return false;}
                    var formEle = $('form[name=qListForm]');
                    formEle.attr('action','MCTestGen');
                    formEle.submit();
                });
            });
            
            function loadNext(){
                if(qShowIndex == jsonQDB.length){ $('#pMsg').text("You have reached to the last question.");
                    $('#helpMessage').show();
                    setTimeout(function(){$('#helpMessage').hide();},2000); return false;
                }
                $('#previewQText').text(jsonQDB[qShowIndex].qText);
                var ansEle = $('#divAnsBox').find('span');
                ansEle.eq(0).text(jsonQDB[qShowIndex].ansA);
                ansEle.eq(1).text(jsonQDB[qShowIndex].ansB);
                ansEle.eq(2).text(jsonQDB[qShowIndex].ansC);
                ansEle.eq(3).text(jsonQDB[qShowIndex].ansD);
                ansEle.eq(4).text(jsonQDB[qShowIndex].ansE);
                $('#imgQFig').attr('src','uploadedImages/'+jsonQDB[qShowIndex].figName);
                qShowIndex += 1;    
                MathJax.Hub.Queue(['Typeset',MathJax.Hub,'divQBox']);
            }
            
            function loadPrevious(){
                if(qShowIndex == 1){ $('#pMsg').text("You are  on the first question now.");
                    $('#helpMessage').show();
                    setTimeout(function(){$('#helpMessage').hide();},2000); return false;
                }
                qShowIndex -= 1; 
                $('#previewQText').text(jsonQDB[qShowIndex-1].qText);
                var ansEle = $('#divAnsBox').find('span');
                ansEle.eq(0).text(jsonQDB[qShowIndex-1].ansA);
                ansEle.eq(1).text(jsonQDB[qShowIndex-1].ansB);
                ansEle.eq(2).text(jsonQDB[qShowIndex-1].ansC);
                ansEle.eq(3).text(jsonQDB[qShowIndex-1].ansD);
                ansEle.eq(4).text(jsonQDB[qShowIndex-1].ansE);
                $('#imgQFig').attr('src','uploadedImages/'+jsonQDB[qShowIndex-1].figName);
                MathJax.Hub.Queue(['Typeset',MathJax.Hub,'divQBox']);     
            }


        </script>
    </head>

    <body>
        <jsp:include page="gameMenuBar.jsp" />

        <div style="width:900px;margin: auto;" > 
            <a id="aBtnCreateTest" class="miniLink"> Create Test</a>&nbsp;<a onclick="window.history.back()" class="miniLink"> Go back</a><br><br>
            <div style="font-weight: bold;color: #444444;padding:5px;border-radius:5px;"> 
                <span>  Number of Questions </span>&nbsp;&nbsp;|&nbsp;&nbsp;
                <span id="numOfCorr">Correct:0</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; <span id="score">Score:</span>
            </div>    
            <div style="box-shadow: 0px 0px 2 px 4px #666666; border-top: 4px solid #666666;border-bottom: 4px solid #666666;">  
                <form name="qListForm">
                    <input type="hidden" value="3" name="stage" id="stage" />
                    <input id="selectedQ" type="hidden" value="<c:out value='${requestScope.selectedQ}' />" name="selectedQ" />
                    <input type="hidden" id="allQData" name="allQData" value="<c:out value='${requestScope.strQList}' />"/>
                    <table style="margin:auto;vertical-align: top;">
                        <tr>
                            <td>
                                <img  style="width: 80px"  src="./icons/leftArrow.png" id="btnPrev"  onclick="loadPrevious()" />
                            </td>
                            <td>
                                <div class="divQBox" id="divQBox">
                                    <p id="previewQText">Q</p>
                                    <div style="width:100%;position: relative;display: inline-block; ">
                                        <div style=" width: 300px; float: left;" id="divAnsBox">
                                            <span class="spanAns">(A)&nbsp;</span>
                                            <span class="spanAns">(B)&nbsp;</span>
                                            <span class="spanAns">(C)&nbsp;</span>
                                            <span class="spanAns">(D)&nbsp;</span>
                                            <span class="spanAns">(E)&nbsp;</span><br>
                                            <span class="spanCorrAns">CORRECT ANSWER:&nbsp;</span>
                                        </div>
                                        <div class="qFigBox">  
                                            <img src="uploadedImages/0.jpg" class="thumbQFig" id="imgQFig"/>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <img  style="width: 80px"  src="./icons/rightArrow.png" id="btnNext"  onclick="loadNext();" />
                            </td>
                        </tr>
                    </table>
                </form>
            </div> 
        </div>
    </body>
</html>

