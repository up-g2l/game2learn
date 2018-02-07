<%-- 
    Document   : user_account
    Created on : Feb 28, 2013, 12:25:42 PM
    Author     : upendraprasad
--%>

<%@page import="java.util.List"%>
<%@page import="dao.DataAccess"%>
<%@page import="util.GPMember"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <link rel="stylesheet"  type="text/css" href="../css/g2l_spring.css">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>     
        <script type="text/javascript" src="../js/gameJScript3.js" ></script>
        <script type="text/javascript" src="../js/jsUtil.js" ></script>

        <title>g2l: Login</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            $(function() {
                $( document ).tooltip();
            });
        </script>
        <%DataAccess da = new DataAccess();
            System.out.println("Tags Fetched");
            List<String> tags = da.fetchAllTags();
            System.out.println("Tags Fetched");
            List<String> sources = da.fetchAllSources();
            System.out.println("Sources Fetched");
        %>
        <script>            
            var allTags=[
            <% for (int i = 0; i < tags.size() - 1; i = i + 1) {%>
                       "<%=(String) tags.get(i)%>",
            <%}%>
                        "Cauchy Integral", "Cauchy Theorem","Cauchy-Riemann Equation","Vector Operations","Lines","Planes",
                        "Quadric Surfaces","Center of Mass","Curvature","Tangent Plane","Normal Acceleration","Polar Coordinates",
                        "Polar Equations","Polar Curves", "Polar","Polar Integrals","Arc Length","Multiple Integral",
                        "Spherical System","Spherical Geometry","Change of variables","Vector Fields"];
        
                    var allSources=[
            <% for (int i = 0; i < sources.size() - 1; i = i + 1) {%>
                        "<%=(String) sources.get(i)%>",
            <%}%>
                        "Putnam Exam", "IIT JEE"];
        </script>

        <script>
 
            $(function() {    
                $( "#tag1" ).autocomplete({ source: allTags });
                $( "#qSource" ).autocomplete({source: allSources});    
            });
  
  
            function performTask(index){
                $('#divCover').show();

                switch(index){
                    case 'contributeQ':
                        $('#selQType2').show(); $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','/g2l/EnterQuestions.jsp');
                        break;
              
                    case 'makeTest':
                        $('#selQType1').show();  $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../CreateMCTest.jsp');
                        break;
                 
                    case 'accessQB':
                        $('#selQType1').show();  $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../AccessQBank.jsp');
                        break;
                 
                    case 'correctQ':
                        $('#selQType1').show(); $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../QuestionCorrection.jsp');
                        break;
                 
                    case 'game1':
                        $('#selQType1').show(); $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../game1.jsp');
                        break;
                 
                 
                    case 'practice':
                        $('#selQType1').show();  $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../PracticeQuestions.jsp');
                        break;
                 
                    case 'flash-card':
                        $('#selQType1').show(); $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../flashCards.jsp');
                        break;
                 
                    case 'take-test':
                        $('#selQType1').show();  $('#mcTest').slideDown('slow');
                        $('#frmQ').attr('action','../TakeTest.jsp');
                        break;
                 
                    case 'game2':
                        $('#selQType1').show();  $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../Game2.jsp');
                        break;
                    case 'TakeMCTest':
                        $('#selQType1').show();  $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../TakeMCTest.jsp');
                        break;     

                    case 'flashGRE':
                        $('#flashGRE').show(); $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../TakeMCTest.jsp');
                        break;     
                    default:
                }      
            }
  
            function performTaskV2(index){
                $('#divCover').show();
                $('#selQType').hide();

                switch(index){
                    case 'contributeQ':
                        $('#selQType').slideDown('slow');$('#selQType2').toggle();
                        $('#frmQ').attr('action','./EnterQuestionsV2.jsp');
                        break;
              
                    case 'makeTest':
                        $('#selQType1').slideDown(); $('#selQType2').toggle(); $('#selQType').slideDown();$('#frmQ').attr('action','..AccessQBank2.jsp');
                        break;
                 
                    case 'accessQB':
                        $('#selQType1').slideDown(); $('#selQType2').toggle(); $('#selQType').slideDown('slow');$('#frmQ').attr('action','../AccessQBank.jsp');
                        break;
                 
                    case 'correctQ':
                        $('#selQType1').slideDown(); $('#selQType2').toggle(); $('#selQType').slideDown('slow');$('#frmQ').attr('action','../QuestionCorrection.jsp');
                        break;
                 
                    case 'game1':
                        $('#selQType1').slideDown(); $('#selQType2').toggle(); $('#selQType').slideDown('slow');$('#frmQ').attr('action','../game1.jsp');
                        break;        
                 
                    case 'practice':
                        $('#selQType1').slideDown(); $('#selQType2').toggle(); $('#selQType').slideDown('slow');$('#frmQ').attr('action','../PracticeQuestions.jsp');
                        break;
                 
                    case 'flash-card':
                        $('#selQType1').slideDown(); $('#selQType2').toggle(); $('#selQType').slideDown('slow');$('#frmQ').attr('action','../flashCards.jsp');
                        break;
                 
                    case 'take-test':
                        $('#mcTest').slideDown(); $('#selQType').slideDown('slow'); $('#frmQ').attr('action','../TakeMCTest.jsp');
                        break;
                 
                    case 'game2':
                        $('#selQType1').slideDown(); $('#selQType2').toggle(); $('#selQType').slideDown('slow');$('#frmQ').attr('action','../Game2.jsp');
                        break;
                 
                    case 'TakeMCTest':
                        $('#mcTest').slideDown();  $('#selQType').slideDown('slow');
               
                        break;     

                    case 'flashGRE':
                        $('#flashGRE').slideDown(); $('#selQType').slideDown('slow');
                        $('#frmQ').attr('action','../TakeMCTest.jsp');
                        break;     
                    default:
                }      
            }
  
        </script>

        <style>
            label {
                display: inline-block;
                width: 5em;
            }
        </style>
    </head>
    <body onload="loadComboBoxes('../menu_combo_box.xml');">
       <!-- <%
            HttpSession sesn1 = request.getSession();
            GPMember member = (GPMember) sesn1.getAttribute("member");
            System.out.println("Session Info Fetched");
        %>-->
   <jsp:include page="../gameMenuBar.jsp" />
        <div id="outerDiv1" style="position:relative;">
            <div id="divCover"></div>
            <table id="outerTbl1">
                <tr>
                    <td style="width:350px;vertical-align: top;"> <br>
                        <table id="tblLeftMenu" >
                            <tr><td>                                
                                    <a class="mainLink" onclick="$('.allUserMenu').slideUp('slow'); $('#divQB').slideDown('slow');" style="background-color:#555555;color:white;">Math: Question Bank </a> 
                                    <div  class="allUserMenu" id="divQB"   style="">
                                        <a class="mainLink"  onclick="performTask('contributeQ');">Contribute Questions</a><br>
                                        <a class="mainLink"  onclick="performTask('makeTest');">Make a Test</a><br>
                                        <a class="mainLink"  onclick="performTask('accessQB');">Access Question Bank</a><br>
                                        <a class="mainLink"  onclick="performTask('correctQ');">Verification and Corrections</a><br>
                                    </div>
                                    <a  class="mainLink" onclick="$('.allUserMenu').slideUp('slow'); $('#divPG').slideDown('slow');"  style="background-color:#555555;color:white;">Math: Practice and Learn</a>          
                                    <div  class="allUserMenu" id="divPG"  style="display:none">
                                        <a class="mainLink"  onclick="performTask('TakeMCTest');">Take a Test</a><br>
                                        <a class="mainLink"  onclick="performTask('practice');">Practice and Learn</a><br>
                                        <a class="mainLink"  onclick="performTask('flash-card');">Flash Card</a><br>
                                    </div>
                                    <a  class="mainLink" onclick="$('.allUserMenu').slideUp('slow'); $('#divPP').slideDown('slow');"  style="background-color:#555555;color:white;">Math: Game and Learn</a>          
                                    <div  class="allUserMenu" id="divPP" style="display:none">
                                        <a class="mainLink"  onclick="performTask('game1');">Play Chutes and Ladders</a><br>
                                        <a class="mainLink"  href="/g2l/games/BubblePops.jsp">Bubble Pops</a><br>
                                        <a class="mainLink"  onclick="$('#underCons').toggle();">Play Jeopardy</a><br>
                                    </div>
                                    <a  class="mainLink" onclick="$('.allUserMenu').slideUp('slow'); $('#divExam').slideDown('slow');"  style="background-color:#555555;color:white;">Vocabulary Practice</a>          
                                    <div  class="allUserMenu" id="divExam" style="display:none">
                                        <a class="mainLink"  onclick="performTask('game1');">GRE/GMAT Words Practice</a><br>
                                        <a class="mainLink"  onclick="performTask('game1');">GRE/GMAT Words Test</a><br>
                                        <a class="mainLink"  onclick="performTask('flashGRE');">GRE/GMAT Words Flash Card</a><br>
                                    </div>
                                </td></tr>
                        </table>

                    </td>          
                    <td style="width:auto;vertical-align: top;">
                        <br/>
                        <div  id="selQType" class="divSelectOptions" >
                            <p class="caption" onclick="$('#selQType').hide();$('.divSelect').hide();$('#divCover').hide();">(X) Search Criteria</p>

                            <form id="frmQ">
                                <div  id="selQType1" class="divSelect" >   

                                    <table>
                                        <tr>
                                            <td style="width:100px;vertical-align: top;">Topic tag</td>
                                            <td><input id="tag1" class ="ip2" type="text"   name="tag" />
                                                <input id="btnAdd" type="button" value="+ &raquo;"  onclick="$('#tags').val($('#tags').val()+$('#tag1').val()+'; ');$('#tag1').val('');" />
                                                <br><input id="tags" class ="ip1" type="text"   name="tags" />   
                                            </td>

                                        </tr>
                                        <tr> 
                                            <td style="width:100px;vertical-align: top;">Source</td><td colspan="2">
                                                <input id="qSource" class ="ip1"  type="text"   name="qSource"/></td>
                                        </tr>
                                        <tr>      <td style="width:100px;vertical-align: top;">Number of questions</td>                          
                                            <td colspan="2">
                                                <select id="level" name="howManyQ">  <option value="10">10</option> 
                                                    <option value="20"> 20</option>
                                                    <option value="50">50</option>
                                                    <option value="100">100</option>
                                                    <option value="200">200</option>
                                                </select>                                          
                                            </td>
                                        </tr>
                                    </table> 


                                </div>

                                <div  id="selQType2" class="divSelect" >
                                    <table>
                                        <tr> <td style="width:100px;vertical-align: top;">Select Options<input id="subSelect" type="hidden"   name="subSelect" /></td>
                                            <td>
                                                <select id="class_level">  <option value="10">Standard</option> </select>
                                                <select id="diff" >  <option value="3">Difficulty Level</option>   </select>
                                                <select id="subjects" onchange="setSubArea($('#subAreas'),'sub_area');">  <option>Subject</option> </select>
                                                <select id="subAreas" onchange="setQType();" disabled="disabled">  <option>Subject Area</option> </select><br>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div style="margin:auto;text-align: center;"> 
                                    <input id="btnSubmit" class ="" type="button" value="SUBMIT"  name="tags" onclick="submit()"/>                                 
                                </div>
                            </form>


                            <div id="underCons" style="color: white;position: absolute;top: 200px;left: 400px;" class="divSelect">
                                <img src="../icons/flagGreen.png"/>
                            </div>
                            <div id="mcTest"  class="divSelect">                        
                                <form name="frmMCTest" action="/g2l/TakeMCTest.jsp">
                                    Provide the test number<br>
                                    <input type="text" id="testId" name="testId" />
                                    <input type="button" value="Submit" onclick="submit();"/>
                                </form>
                            </div>
                            <div id="flashGRE" class="divSelect">                       
                                <form name="frmFlashGRE" action="/g2l/GREFlash.jsp">
                                    Initial alphabet<br>
                                    <input type="text" id="regEx" name="regEx"/> <br>
                                    Has substring<br>
                                    <input type="text" id="regEx2" name="regEx2" />
                                    <input type="button" value="Submit" onclick="if($('#regEx').val()!='' || $('#regEx2').val()!='' ){submit()};"/>
                                </form>
                            </div>
                        </div>
                        <br/>   

                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>

