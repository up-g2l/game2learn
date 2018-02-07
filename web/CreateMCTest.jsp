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
        <%
            HttpSession sesn1 = request.getSession();
            if (sesn1 == null) {
                System.out.println("Session Expired");
                response.sendRedirect("/g2l/index.jsp?status=session_expired");
            }
            GPMember member = (GPMember) sesn1.getAttribute("member");
            QuestionDAO qd = new QuestionDAO();
        %>

        <jsp:include page="gameMenuBar.jsp" />
        <div>
            <form id="qListForm" action="PreviewMCTest.jsp" method="GET">
                <br>
                <div style="margin:0 auto;width: 800px;">        
                    <div class="divFixedBox">
                        <img src="./images/spring/btnPreviewTest1.png" onclick="collectQ();" class="btn-image"/>
                        <img src="./images/spring/btnCreateTest1.png" onclick="createTest();" class="btn-image" />
                     Selected Questions &nbsp;
                        <input id="selectedQ" type="text"   value="None" name="selectedQ" disabled style="border:0px; background-color: white;width: 180px;"/>
                    </div>
                    <table  id="questionTable" class="tblQList">
                        <tbody>
<%  
    String tagPar = request.getParameter("tags");System.out.println("tags: "+tagPar);
    String qType = request.getParameter("subSelect");System.out.println("qType: "+qType);
    String qSource = request.getParameter("qSource");System.out.println("qSource: "+qSource);
    String qStatus = request.getParameter("qStatus");System.out.println("qStatus "+qStatus);
    String qProvider = request.getParameter("qProvider");System.out.println("qProvider "+qProvider);
    String fromDate = request.getParameter("qAprvlDate");System.out.println("From Date "+fromDate);

    GPMember gm = (GPMember)request.getSession().getAttribute("member");
    if(qProvider !=null){qProvider = gm.getId();}
    String figName="";
    MCQuestion qb ;
//qSource="";
    List<MCQuestion> qBeans = qd.fetchQuestions(qType, qSource,tagPar, qProvider, "5", fromDate, true);
    for (int i = 0; i < qBeans.size(); i++) {
        qb = qBeans.get(i); figName=qb.getFigure().getFigSaveName();
%>
                            <tr>
                                <td style="width:20px;"><input type="checkbox"  class="selQCheck" value="<%=qb.getqId()%>"/> 
                                </td><td>Question <%= i + 1%> &nbsp; (id: <%=qb.getqId()%>)</td> 
                            </tr>
                            <tr>
                                <td colspan="2">
                    <div class="divQBox" id="divQBox<%=qb.getqId()%>">
                        <p id="previewQText">&nbsp;<%=qb.getqText()%></p>
                        <div style="width:100%;position: relative;display: inline-block; ">
                            <div style=" width: 300px; float: left;">
                                <span class="spanAns">(A)&nbsp;<%=qb.getAnsA()%></span>
                                <span class="spanAns">(B)&nbsp;<%=qb.getAnsB()%></span>
                                <span class="spanAns">(C)&nbsp;<%=qb.getAnsC()%></span>
                                <span class="spanAns">(D)&nbsp;<%=qb.getAnsD()%></span>
                                <span class="spanAns">(E)&nbsp;<%=qb.getAnsE()%></span><br>
                                <span class="spanCorrAns">CORRECT ANSWER:&nbsp;<%=qb.getAnsCorrect()%></span>
                            </div>
                            <div class="qFigBox">  
                                <img src="uploadedImages/<%=figName%>" class="thumbQFig"/>
                                <span class="figCaption">Figure <%=i+1%>:&nbsp;<%=qb.getFigure().getFigCaption()%></span>
                            </div>
                        </div>
                    </div> 
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>            
                </div>
            </form>
        </div>
        <div  id="QEditDiv" style="display: none;position: fixed;z-index: 12; ">
            <img src="images/closeX.jpeg"  style="position: absolute; top: 4px; right: 4px;width: 20px;" onclick="coverToGrayOut1(true); $('#QEditDiv').hide();"/>
            <form id="frmQ">
                <table id="qEntryTbl" width="700px">
                    <tr> <td><a onclick="$('#allSel').toggle();">Select</a></td><td><div id="allSel" style="display: none;">
                                <select id="level">  <option value="10">Grade</option> </select>
                                <select id="diff" >  <option value="3">Difficulty</option>   </select>
                                <select id="subjects" onchange="setSubArea($('#subAreas'),'sub_area');">  <option>Subject</option> </select>
                                <select id="subAreas" onchange="setQType();" disabled="disabled">  <option>Subject Area</option> </select>
                            </div>
                        </td>
                    </tr>
                    <tr> <td colspan="2" style="text-align:right;"><span id="updateQStatus" style="color:green;font-weight: bold;"></span>
                            <a class="miniLink" onclick="validateDataEntry();">|&nbsp;&nbsp;Validate &nbsp;&raquo;</a>&nbsp;
                            <a class="miniLink"   onclick="showMessage('Coming Soon', 0, 0, 3000);">|&nbsp;&nbsp;Macros &nbsp;&raquo;</a>&nbsp;
                            <a  class="miniLink"  onclick="showInstruction(this);">|&nbsp;&nbsp; Instructions&nbsp;&raquo;</a>
                        </td>
                    </tr>
                    <tr><td><label for="question" >Question #1 (id:)</label></td>
                        <td><textarea id="question"  name="question" maxlength="4000" style="width: 400px;"></textarea>
                        </td>                     
                    </tr>

                    <tr><td colspan="2" >
                            <!--<a style="padding: 5px"> Multiple Choices?</a><input type="checkbox" id="checkMC" onchange="$('#div4Answer').toggle();" />-->
                            <div id="div4Answer"  style="display: display;margin-top: 0px; padding:10px; border:1px solid #8AC007; border-radius: 10px;">
                                <table ><tr><td> Ans A</td><td>                                  
                                            <input id="ansA" class ="ip1" type="text"  name="ansA" maxlength="50"/></td>
                                        <td><input type="radio" name="corr" id="radA"  value="A"/></td>

                                        <td>Ans B</td><td><input id="ansB"  class ="ip1" type="text"  name="ansB" maxlength="50"/></td>
                                        <td><input type="radio" name="corr" id="radB"   value="B"/></td>

                                        <td>Ans C</td><td><input id="ansC"  class ="ip1" type="text" name="ansC" maxlength="50"/></td>
                                        <td><input type="radio" name="corr" id="radC" value="C"/></td>

                                    </tr>
                                    <tr>  <td>Ans D</td><td ><input id="ansD" class ="ip1"  type="text" name="ansD" value="All" maxlength="50"/></td>
                                        <td><input type="radio" name="corr" id="radD"  value="D"/></td>

                                        <td >Ans E</td><td ><input id="ansE"  class ="ip1" type="text" name="ansE" value="None" maxlength="50"/></td>
                                        <td><input type="radio" name="corr" id="radE"  value="E" checked="checked" /></td>
                                    </tr>
                                </table>
                            </div></td>
                    <tr><td>Tags</td><td> 
                            <input id="tag1" class ="ip2" type="text"   name="tags" />
                            <input id="btnAddTag" class ="btnMini" type="button" value="+&nbsp;&raquo;" name="tags" onclick="$('#tags').val($('#tags').val()+$('#tag1').val()+'; ');$('#tag1').val('');" />
                            <input id="tags" class ="ip1" type="text"   name="tags" />              
                        </td></tr>
                    <tr> 
                        <td>Source</td>
                        <td colspan="2">
                            <input id="qSource" class ="ip1"  type="text"  name="source"/>
                        </td>
                    </tr>

                    <tr> 
                        <td>Help Links </td><td>
                            <input id="helpLink" class ="ip1"  type="text"  name="helpLink"/></td></tr>

                    <tr> <td><label for="explanation" title="Click for providing explanation." onclick="$('#tAreaDiv').toggle();">Explanation</label></td><td>
                            <div id="tAreaDiv" style="display: none;position: relative;">
                                <textarea id="explanation"  name="explanation" maxlength="500"> </textarea></div></td></tr>

                    <tr> 
                        <td colspan="2" style="text-align:center;">
                            <!--  <input  id="resetQ" type="button" onclick="$('#qNum').val('');$('#qId').val('0');$('#updateQ').attr('disabled','true');reset();" value="Reset for New Question"/>
                              <input   id="saveQ" onclick="saveNewQuestion();" type="button"  value="Save as a new Question"/>-->
                            <input id="updateQ" onclick="qUpdate();" type="button"  value="Update Question"/>
                            <input id="qId" type="hidden" name="qId" value="0"/>
                            <input id="qNum" type="hidden" name="qNum" />
                            <input id="subSelect" type="hidden" value="" />                                  
                        </td>
                    </tr>
                </table>
            </form>            
        </div> 
    </body>
</html>
