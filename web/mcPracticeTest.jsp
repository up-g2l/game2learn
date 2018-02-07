<%-- 
    Document   : mcPracticeTest
    Created on : Jun 13, 2014, 4:23:16 PM
    Author     : upendraprasad
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
            var jsonArrQ={}; 
            var onQNum = 0;
            var numCorrect = 0;
            var answered = 0;
            var score = 0;
  
            $(function(){
                jsonArrQ = eval($('#allQData').val());
                console.log(jsonArrQ[0]);
                
                $('#numOfQ').text("Numer of questions: "+jsonArrQ.length);
                loadQ(0);
                 
                $('input[type=radio]').change(function(){ 
                    var currQ = jsonArrQ[onQNum];
                    if(currQ.choice==""){
                        $(':radio + span').css("border","1px solid #CCCCCC");
                        $(this).next().css("border","2px solid green");
                        currQ.choice = $(this).val();
                        if(currQ.ansCorr !=currQ.choice){
                             $(this).next().css("border","2px solid red");
                             var radEle = $('input[value="'+currQ.ansCorr+'"]');
                             radEle.next().css("border","2px solid green");                              
                           }
                           else{numCorrect +=1;}
                    }   
                    $('#numOfCorr').text("Correct: "+numCorrect);
                    $('input[type=radio]').attr('disabled',true);
                });
                
                $('#aBtnResetAns').click(function(){
                    numCorrect -=1;
                    $(':radio + span').css("border","1px solid #CCCCCC");
                    $('input[type=radio]').attr('checked',false);
                    jsonArrQ[onQNum].choice = "";
                    $('#numOfCorr').text("Correct: "+numCorrect);
                });
            });
            
            function loadQ(nxt){
                var qIndex=onQNum + nxt;
                
                if(jsonArrQ[qIndex].choice==""){$('input[type=radio]').attr('disabled',false);}
                else{$('input[type=radio]').attr('disabled',true);}
                
                if(qIndex > jsonArrQ.length-1){ $('#pMsg').text("You have reached to the last question.");
                    $('#helpMessage').show(); setTimeout(function(){$('#helpMessage').hide();},2000); return false;
                }
                if(qIndex < 0){ $('#pMsg').text("You are  on the first question now.");
                    $('#helpMessage').show(); setTimeout(function(){$('#helpMessage').hide();},2000); return false;
                }
                
                $('#previewQText').html("Q"+(qIndex+1)+": "+jsonArrQ[qIndex].qText);
                $('#imgQFig').attr('src','uploadedImages/'+jsonArrQ[qIndex].figName);
                var ansEle = $('#divAnsBox').children('span');
                ansEle.eq(0).text(jsonArrQ[qIndex].ansA);
                ansEle.eq(1).text(jsonArrQ[qIndex].ansB);
                ansEle.eq(2).text(jsonArrQ[qIndex].ansC);
                ansEle.eq(3).text(jsonArrQ[qIndex].ansD);
                ansEle.eq(4).text(jsonArrQ[qIndex].ansE);
                
                $('input[type=radio]').attr('checked',false).next().css("border","1px solid #CCCCCC");
                //$(':radio + span').css("border","1px solid #CCCCCC");
                
                if(jsonArrQ[qIndex].choice!=""){
                    var radEle = $('input[value="'+jsonArrQ[qIndex].ansCorr+'"]');
                     radEle.next().css("border","2px solid green");
                    if(jsonArrQ[qIndex].ansCorr !=jsonArrQ[qIndex].choice){ //console.log( $('input[value="'+jsonArrQ[qIndex].choice+'"]').val());
                        radEle = $('input[value="'+jsonArrQ[qIndex].choice+'"]');
                        radEle.next().css("border","2px solid red");
                        radEle.attr('checked',true);
                    }
                    else{
                        var radEle = $('input[value="'+jsonArrQ[qIndex].choice+'"]');
                        radEle.next().css("border","2px solid green");
                        radEle.attr('checked',true);
                    }
                }
                
                onQNum = qIndex;    
                MathJax.Hub.Queue(['Typeset',MathJax.Hub,'divQBox']);
            }
            
            function loadPrevious(){
                if(onQNum == 1){ $('#pMsg').text("You are  on the first question now.");
                    $('#helpMessage').show(); setTimeout(function(){$('#helpMessage').hide();},2000); return false;
                }
                onQNum -= 1; 
                $('#previewQText').text("Q"+(onQNum)+": "+jsonArrQ[onQNum-1].qText);
                var ansEle = $('#divAnsBox').find('span');
                ansEle.eq(0).text(jsonArrQ[onQNum-1].ansA);
                ansEle.eq(1).text(jsonArrQ[onQNum-1].ansB);
                ansEle.eq(2).text(jsonArrQ[onQNum-1].ansC);
                ansEle.eq(3).text(jsonArrQ[onQNum-1].ansD);
                ansEle.eq(4).text(jsonArrQ[onQNum-1].ansE);
                $('#imgQFig').attr('src','uploadedImages/'+jsonArrQ[onQNum-1].figName);
                
                if(jsonArrQ[onQNum].choice!=""){
                    if(jsonArrQ[onQNum].ansCorr !=jsonArrQ[onQNum].choice){
                        console.log( $('input[value="'+jsonArrQ[onQNum].choice+'"]').val());
                        $('input[value="'+jsonArrQ[onQNum].choice+'"]').next().css("border","2px solid red");
                    }
                    else{
                        $('input[value="'+jsonArrQ[onQNum].choice+'"]').next().css("border","2px solid green");
                    }
                }
                else{$(':radio + span').css("border","1px solid #CCCCCC");$('input[type=radio]').attr('checked',false);}
                MathJax.Hub.Queue(['Typeset',MathJax.Hub,'divQBox']);     
            }


        </script>
        <style>
            input[type=radio]{width: 50px; size: 50px; }
            .spanAns1{display: inline-block; width: 300px;background-color: #EEEEEE; margin: 4px;padding: 5px;
                      border: 1px solid #CCCCCC; font-size: 12px; color: #888888;}
            </style>
        </head>

        <body>
            <jsp:include page="gameMenuBar.jsp" />
            <br>
            <div style="width:900px;margin: auto;" > 
            <div style="font-weight: bold;color: #444444;padding:5px;border-radius:5px;"> 
                <span id="numOfQ">  Number of Questions: </span>&nbsp;&nbsp;|&nbsp;&nbsp;
                <span id="numOfCorr">Correct:0</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; <span id="score">Score:</span>
                <a id="aBtnSubmitTest" class="miniLink" style="float:right;">Submit Practice Data</a>
            </div>    
            <div style="box-shadow: 0px 0px 2 px 4px #666666; border-top: 4px solid #666666;border-bottom: 4px solid #666666;">  
                <form name="qListForm">
                    <input type="hidden" value="3" name="stage" id="stage" />
                    <input id="selectedQ" type="hidden" value="<c:out value='${requestScope.selectedQ}' />" name="selectedQ" />
                    <input type="hidden" id="allQData" name="allQData" value="<c:out value='${requestScope.strQList}' />"/>
                    <table style="margin:auto;vertical-align: top;">
                        <tr>
                            <td>
                                <img  style="width: 80px"  src="./icons/leftArrow.png" id="btnPrev"  onclick="loadQ(-1)" />
                            </td>
                            <td><div style="width: 700px;height: 450px;overflow-y: auto;vertical-align: middle;">
                                    <div class="divQBox" id="divQBox">
                                        <p id="previewQText">Q</p>
                                        <div style="width:100%;position: relative;display: inline-block; ">
                                            <div style=" width: 380px; float: left;" id="divAnsBox">
                                                <input type="radio" name="radQAns" value="A" /><span class="spanAns1">(A)&nbsp;</span>
                                                <input type="radio" name="radQAns" value="B" /><span class="spanAns1">(B)&nbsp;</span>
                                                <input type="radio" name="radQAns" value="C" /><span class="spanAns1">(C)&nbsp;</span>
                                                <input type="radio" name="radQAns" value="D" /><span class="spanAns1">(D)&nbsp;</span>
                                                <input type="radio" name="radQAns" value="E" /><span class="spanAns1">(E)&nbsp;</span>
                                            </div>
                                            <div class="qFigBox">  
                                                <img src="uploadedImages/0.jpg" class="thumbQFig" id="imgQFig"/>
                                            </div>
                                        </div>
                                        <div style="width:100%;text-align: left;">
                                            <a id="aBtnSaveAns" class="miniLink">Save Answer</a>&nbsp;
                                            <!--<a id="aBtnResetAns" class="miniLink">Reset Answer</a>-->
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <img  style="width: 80px"  src="./icons/rightArrow.png" id="btnNext"  onclick="loadQ(1);" />
                            </td>
                        </tr>
                    </table>
                </form>
            </div> 
        </div>
    </body>
</html>

