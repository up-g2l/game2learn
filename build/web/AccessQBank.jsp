<%-- 
    Document   : AccessQBank
    Created on : Mar 2, 2013, 8:10:03 PM
    Author     : upendraprasad
--%>

<%@page import="g2l.dao.DataAccess"%>
<%@page import="g2l.util.GPMember"%>
<%@page import="g2l.util.MCQuestion"%>
<%@page import="java.util.List"%>

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

        <script>
            $(document).ready(function(){
                $('#questionTable tr:odd').css("background-color","#CCCCCC");
                $('#questionTable tr:odd').css("text-align","center");
                
            });
            
            function collectQ(){
                $(':checked').each(function() { 
                    $('#selectedQ').append(', '+$(this).val());
                });
            }
        </script>

        <script type="text/x-mathjax-config">
            MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']], displayMath: [['\\[','\\]'], ['$$','$$']]},
            styles: { ".MathJax": { color: "#0000FF"}} ,
            extensions: ["tex2jax.js"],    
            "HTML-CSS": { scale: 100}  
            });
        </script>

        <script>
           
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
            DataAccess da = new DataAccess();
        %>

        <jsp:include page="gameMenuBar.jsp" />
        <div>
            <form name="qListForm" action="SetupTest.jsp">
                <br>

                <!--  <div id="optionSetTest">        Setup Test 
                   <input type="radio" name="functionQB" value="makeTest" onselect="('#optionSetTest').toggle('slow');" />
                  <input type="radio" name="functionQB" value="Edit" />
                  <input type="radio" name="functionQB" value="Verify" />
                  <input type="button" id="chooseQ" value="Submit" onclick="alert('Ho Hey');"> Test Options:
                  QuestionList <img onclick="collectQ();" style="cursor: pointer;width: 30px;"  src="./images2/refresh.png"/> 
                  <input id="selectedQ" type="text"  value=""/>
                  <a class="btnLinkM"> Preview Questions</a></div>-->

                <div>
                    <br>


                    <table  id="questionTable" class="tblQList">
                        <thead style="background-color: green;color:white;">
                            <tr>
                                <th> Select</th>
                                <th> Questions</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% String tagPar = request.getParameter("tags");
                                String qType = request.getParameter("subSelect");
                                String qSource = request.getParameter("qSource");
                                String provider = request.getParameter("qProvider");
                                provider = "";
                            //qSource="";
                                List<MCQuestion> qBeans = da.fetchQuestions(qType, qSource, tagPar, provider);
                                for (int i = 0; i < qBeans.size(); i++) {
                            %>
                            <tr>
                                <td><input type="checkbox"  value="<%=qBeans.get(i).getqId()%>"/> 
                                </td><td>Question <%= i + 1%></td> <td> <a onclick="editQuestion(<%=qBeans.get(i).getqId()%>);">Edit</a></td>
                            </tr>
                            <tr>
                                <td></td><td>
                                    <%=qBeans.get(i).getqText()%><hr>
                                    (A)&nbsp;<%=qBeans.get(i).getAnsA()%>,&nbsp;
                                    (B)&nbsp;<%=qBeans.get(i).getAnsB()%>,&nbsp;
                                    (C)&nbsp;<%=qBeans.get(i).getAnsC()%>,&nbsp;
                                    (D)&nbsp;<%=qBeans.get(i).getAnsD()%>,&nbsp;
                                    (E)&nbsp;<%=qBeans.get(i).getAnsE()%>
                                </td><td></td>
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
