<%-- 
    Document   : mcTestChoose
    Created on : Jun 3, 2014, 9:19:09 AM
    Author     : upendraprasad
--%>

<%-- 
    Document   : AccessQBank
    Created on : Mar 2, 2013, 8:10:03 PM
    Author     : upendraprasad
--%>

<%@page import="g2l.dao.QuestionDAO"%>
<%@page import="g2l.util.GPMember"%>
<%@page import="java.util.List"%>
<%@page import="g2l.util.MCQuestion"%>
<%@page import="g2l.dao.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>

        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
        <script type="text/javascript" src="/g2l/js/gameJScript3.js" ></script>
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>  
        <style>
            
        </style>

        <script type="text/x-mathjax-config">
            MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']], displayMath: [['\\[','\\]'], ['$$','$$']]},
            styles: { ".MathJax": { color: "#0000FF"}} ,
            extensions: ["tex2jax.js"],    
            "HTML-CSS": { scale: 100}  
            });
        </script>

        <script>
            var strQID = ''; 
            $(document).ready(function(){
                $('#questionTable tr:odd').css("background-color","#CCCCCC");                
                
                
                $('.selQCheck').change(function(){strQID='';
                    $(this).parent().next().css("background-color","white");
                    $('.selQCheck:checked').each(function() { 
                        //$('#selectedQ').append(';'+$(this).val());
                        strQID = strQID + $(this).val() +';';
                        $(this).parent().next().css("background-color","#5ca941");
                    });
                    $('#selectedQ').val(strQID); 
                });
                
                $('#imgBtnTestPreview').click(function(){
                    var chkVal="";
                    $('.selQCheck').each(function() { 
                        //$('#selectedQ').append(';'+$(this).val());
                        if($(this).is(":not(:checked)")){chkVal = $(this).val(); $("#divQBox"+chkVal).hide();}
                        // strQID = strQID + $(this).val() +';';
                        // $(this).parent().next().css("background-color","#5ca941");
                    });
                    // if($('#selectedQ').val()==''){alert('You have not selected any questions.');return;}
                    // $('#selectedQ').attr('disabled',false);
                    // $('#qListForm').attr('action','MCTestGen');
                    // $('#qListForm').submit();
                });
                
                $(":radio[value=selQ]").click(function(){
                    $(".divQBox").show();
                    var chkVal="";
                    $('.selQCheck').each(function() { 
                        if($(this).is(":not(:checked)")){chkVal = $(this).val(); $("#divQBox"+chkVal).hide();}
                    });
                });
                
                $(":radio[value=nselQ]").click(function(){
                    $(".divQBox").show();
                    var chkVal="";
                    $('.selQCheck').each(function() { 
                        if($(this).is(":checked")){chkVal = $(this).val(); $("#divQBox"+chkVal).hide();}
                    });
                });
                
                $(":radio[value=allQ]").click(function(){  $(".divQBox").show();    });
               
                /*$('#imgBtnTestCreate').click(function(){
                    if(!window.confirm("Are you sure you want to create a test with ids:"+$("#selectedQ").val())){ return false;}
                    console.log('Stage1');
                    var formEle = $('form[name=formQId]').eq(0);console.log('Stage2'+formEle.name);
                    formEle.attr('action','MCTestGen');console.log('Stage3'+formEle.action);
                    formEle.submit();
                });*/
                
                
            });
            
            function collectQ1(){                

                if(confirm('Ready to preview the test?')){
                    $('#qListForm').submit();
                }
            }
            
            function createTest(){                
                var strQID = ''; 
                $('.selCheck:checked').each(function() { 
                    //$('#selectedQ').append(';'+$(this).val());
                    strQID = strQID + $(this).val() +';';
                });
                $('#selectedQ').val(strQID); 
                
                $('#qListForm').attr('action','MCTestCreation.jsp');                

            }
            
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
                
                boxWidth = 700;
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
                $.get("QFetcher?id="+qId,function(data,status){var qObj = eval(data);
                    // alert("Data: " + qObj.qText + "\nStatus: " + status);
                    $('#qId').val(qObj.qId);
                    $('#qNum').val(qNum);
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
                    var idRad = '#rad'+qObj.ansCorr;
                    $(idRad).attr("checked","checked");  
                    $('label[for="question"]').text('Question (id:'+qObj.qId+')');
                });
            }
  
            function qUpdate(){
                //alert('step1');
                if(!validateDataEntry()){  return false;}
                else{ 
                    var valRadio = $("input[@name=corr]:checked").val();
                    if($('#qNum').val()==''){alert('Save the question first.'); return false;}
                    $.post("QuestionEntry",
                    {    qId:$('#qId').val(),
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
                       
                    });
                }
            }
       
        </script>
        <title>g2l: Access Question Bank</title>


    </head>
    <body onload="MathJax.Hub.Queue(['Typeset',MathJax.Hub,'questionTable']);">
        <jsp:include page="gameMenuBar.jsp" />
        <div>           
            <br>
            <div style="margin:0 auto;width: 800px;">        
                <div class="divFixedBox">
                    <form id="formQId" action="" method="GET">
                        Show questions &nbsp;<br><input type="radio" name="shownQs" value="allQ" checked="checked" /> &nbsp;All &nbsp;
                        &nbsp;<br><input type="radio" name="shownQs" value="selQ"  /> &nbsp;Selected  &nbsp;
                        &nbsp; <br><input type="radio" name="shownQs" value="nselQ"  />  &nbsp; Unselected<br><br>
                        <!-- <img src="./images/spring/btnPreviewTest1.png" class="btn-image" id="imgBtnTestPreview"/>   -->                    
                        Question Selection &nbsp;<br>
                        <input type="hidden" value="3" name="stage" id="stage" />
                        <input id="selectedQ" type="text" placeholder="No questions selected so far"  value="" name="selectedQ"  style="border:0px; background-color: white;width: 180px;"/>
                       <!-- <img src="./images/spring/btnCreateTest1.png" class="btn-image" id="imgBtnTestCreate" />-->
                       <input type="submit" value="Create Test" />
                    </form>
                </div>
                <form id="qListForm" action="" method="GET">
                    <table  id="questionTable" class="tblQList">
                        <tbody>
                            <c:forEach items="${requestScope.qList}" var="qb" varStatus="loop">
                                <tr>
                                    <td style="width:20px;"><input type="checkbox"  class="selQCheck" value="${qb.qId}" /> 
                                    </td><td>Question <c:out value="${loop.index+1}"></c:out> &nbsp; (id:<c:out value='${qb.qId}' default="No id"/>)</td> 
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div class="divQBox" id="divQBox${qb.qId}">
                                            <p id="previewQText">&nbsp;<c:out value='${qb.qText}' default="No text."/></p>
                                            <div style="width:100%;position: relative;display: inline-block; ">
                                                <div style=" width: 300px; float: left;">
                                                    <span class="spanAns">(A)&nbsp;<c:out value='${qb.ansA}' /></span>
                                                    <span class="spanAns">(B)&nbsp;<c:out value='${qb.ansB}' /></span>
                                                    <span class="spanAns">(C)&nbsp;<c:out value='${qb.ansC}' /></span>
                                                    <span class="spanAns">(D)&nbsp;<c:out value='${qb.ansD}' /></span>
                                                    <span class="spanAns">(E)&nbsp;<c:out value='${qb.ansE}' /></span><br>
                                                    <span class="spanCorrAns">CORRECT ANSWER:&nbsp;<c:out value='${qb.ansCorrect}' /></span>
                                                </div>
                                                <div class="qFigBox">  
                                                    <img src="uploadedImages/${qb.figure.figSaveName}" class="thumbQFig"/>
                                                </div>
                                            </div>
                                        </div> 
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>  
                </form>
            </div>
        </div>
    </body>
</html>
