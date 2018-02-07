<%-- 
    Document   : user_account
    Created on : Feb 28, 2013, 12:25:42 PM
    Author     : upendraprasad
--%>

<%@page import="java.util.List"%>
<%@page import="g2l.dao.DataAccess"%>
<%@page import="g2l.util.GPMember"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>     
      <!--  <script type="text/javascript" src="../js/gameJScript3.js" ></script>-->
        <script type="text/javascript" src="../js/jsUtil.js" ></script>
        <script type="text/javascript" src="../js/account.js" ></script>

        <title>g2l: Login</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            <%DataAccess da = new DataAccess();
                String allTags = da.getAllQTags();//System.out.println("Tags Fetched");
                String allSources = da.getAllQSources();  //System.out.println("Sources Fetched");
%>
    var strTags = "<%=allTags%>";//console.log("Tags: "+strTags);
    var allTags = strTags.split(";");
                        
    var strSources = "<%=allSources%>";//console.log("Sources: "+strSources);
    var allSources= strSources.split(";");
        </script>

        <style>
            label { display: inline-block;       height:30px;     }
            th{background-color: #88EE77;width: 150px; }
            td{width: 150px; padding: 4px;}
            #qb,#pnl,#gnl,#vp{background-color:#555555;color:white;}
            #divRightCont{display: table; min-height: 600px; min-width: 500px; margin-left: 20px; padding: 10px;}
            .spanNoti{display: block;height: 30px;}
            .divNoti{ float: left; box-shadow: 0px 0px 3px 1px #AAAAAA;margin: 5px;font-size: 12px;min-height: 130px;}
            .ui-tooltip {
                background:#666;
                color: white;
                font-size: 14;
                border: none;
                padding: 10px;
                opacity: 1;
            }
        </style>
    </head>
    <body onload="loadComboBoxes('../menu_combo_box.xml');">
        <!-- <%
            HttpSession sesn1 = request.getSession();
            GPMember member = (GPMember) sesn1.getAttribute("member"); 
            if(member.getUserType().equals("10")){
                RequestDispatcher rd = request.getRequestDispatcher("/g2l/student/index.html");
                        rd.forward(request, response);}
            System.out.println("Session Info Fetched for "+member.getName());
        %>-->
        <jsp:include page="../gameMenuBar.jsp" />         
        <div id="divCover" class="divCover"></div> <br>
        <div class="outerDiv1" style="position:relative; margin: auto;display:block;">
            <!-- Main Left Menu on User Account place-->
            <div id="divLeftMenu" >                              
                <a class="mainLink" id="qb">Question Bank </a> 
                <div  class="allUserMenu" id="divQB">
                    <a class="mainLink" id="aFigUpload" href="/g2l/FigManager" >Figure Upload </a><br>
                    <a class="mainLink" id="aQCont"  href="/g2l/QuestionEntry">Question Contribution</a><br>                    
                    <a class="mainLink" id="aQCorr" href="/g2l/QuestionEdit">Question Correction</a><br>
                    <a class="mainLink" id="aQAprvl" href="/g2l/QStatusChange.jsp">Question Approval </a><br>  
                    <a class="mainLink" id="aMakeTest" href="/g2l/MCTestGen?stage=1">Make a Test</a><br>
                </div>
                <a  class="mainLink" id="pnl"  >Students and Learners</a>          
                <div  class="allUserMenu" id="divPG">
                    <a class="mainLink"  id="aMCTest">Take a Test</a><br>
                    <a class="mainLink"  id="aPracticeTest1" onclick="window.location='/g2l/MCPracticeOptions.jsp'">Practice and Learn</a><br>
                    <a class="mainLink"  id="aPracticeFlash">Flash Card Practice</a><br>
                    <a class="mainLink" id="aFormulas">Formulas</a><br>        
                    <!--<a class="mainLink"  onclick="performTask('game1');">Play Chutes and Ladders</a><br>
                    <a class="mainLink"  href="/g2l/games/BubblePops.jsp">Bubble Pops</a><br>-->
                </div>
                <a  class="mainLink" id="vp">Vocabulary Practice</a>          
                <div  class="allUserMenu" id="divExam">
                    <a class="mainLink"  onclick="performTask('game1');">GRE/GMAT Words Practice</a><br>
                    <a class="mainLink"  onclick="performTask('game1');">GRE/GMAT Words Test</a><br>
                    <a class="mainLink"  onclick="performTask('flashGRE');">GRE/GMAT Words Flash Card</a><br>
                </div>
            </div>               
            <!-- Right content -->
            <div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>SAT</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Vocabulary Practice</td>
                            </tr>
                            <tr>
                                <td>Math Practice</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>GRE</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Vocabulary Practice</td>
                            </tr>
                            <tr>
                                <td>Math Practice</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>GMAT</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Vocabulary Practice</td>
                            </tr>
                            <tr>
                                <td>Math Practice</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>IIT-JEE</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Physics</td>
                            </tr>
                            <tr>
                                <td>Chemistry</td>
                            </tr>
                            <tr>
                                <td>Mathematics</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>AIPMT</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Biology</td>
                            </tr>
                            <tr>
                                <td>Chemistry</td>
                            </tr>
                            <tr>
                                <td>Physics</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>MCA-Entrance</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Comp Sci.</td>
                            </tr>
                            <tr>
                                <td>Math Practice</td>
                            </tr>
                            <tr>
                                <td>English</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>Science Today</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Do you know?</td>
                            </tr>
                            <tr>
                                <td>Math Practice</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>Current Affairs</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Vocabulary Practice</td>
                            </tr>
                            <tr>
                                <td>Math Practice</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="divNoti">
                    <table>
                        <thead> <tr> <th>History</th></tr></thead>
                        <tbody>
                            <tr>
                                <td>Vocabulary Practice</td>
                            </tr>
                            <tr>
                                <td>Math Practice</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
            </div>
            <!-- Search option PopUp after screen greyout-->
            <div  id="divPopContainer" >
                <div id="popHeader">Question Data Modification<img src="/g2l/icons/closeBWRound.png" class="imgClosePop" /></div>
                <form id="frmQ" method="post">
                    <div  id="selQType1" class="divSelect" >
                        <br><br>
                        <label for="qProvider"> Display my entries only</label> 
                        <input type="checkbox" id="qProvider" name="qProvider" value="1" title="Check if you want to search from your question database only."/><br>
                        <label for="qAprvlDate">Display entries after date</label> 
                        <input id="qAprvlDate" class ="ip2" type="text"   name="qAprvlDate"  placeholder="YYYY-MM-DD"/>
                        <img id="imgDatePick" src="../icons/datePick2.png" class="btn-image" style="margin-bottom: -8px;" title="Display only the most recent entries."/><br>
                        <label for="tags"> Topic Tags</label> <input id="tag1" class ="ip2" type="text" name="tag1" title="Tags help in searching. You can attach several tags to the same question. Enter a new Tag or choose from the auto-complete list and click the add button."/>
                        <input id="btnAddTag" type="button" value="+ &raquo;" />
                        <input id="tags" class ="ip1" type="text"   name="tags"  value="" /> <br> 
                        <label for="qSource">Source</label><input id="qSource" class ="ip1"  type="text"   name="qSource" title="If this questions has been taken from somewhere, please provide the source."/><br>
                        <label for="qStatus">Question Status</label> 
                        <select id="qStatus" name="qStatus" style="width:200px;">  
                            <option value="">All considerable types</option>
                            <option value="0">Un-reviewed questions</option> 
                            <option value="1">Ready for re-editing</option>
                            <option value="2">Figure related problems</option>
                            <option value="3">Flagged questions</option>
                            <option value="4">Ready for Approval</option>
                            <option value="5">Approved questions</option>                                    
                        </select>  <br>
                        <label for="subSelect">Subject area</label>
                        <input id="subSelect" type="hidden"   name="subSelect" />
                        <select id="class_level">  <option value="10">Standard</option> </select>
                        <select id="diff" >  <option value="3">Difficulty Level</option>   </select>
                        <select id="subjects" onchange="setSubArea($('#subAreas'),'sub_area');">  <option>Subject</option> </select>
                        <select id="subAreas" onchange="setQType();" disabled="disabled">  <option>Subject Area</option> </select><br>
                        <br>
                        <div style="width:100%;position: relative;text-align: center;">
                            <img src="../images/spring/btnSubmit2.png" id="imgbtnSubmit" class="btn-image" onclick="submit();"/>
                        </div>
                    </div> 
                </form>
                <!-- Multiple choice questions-->
                <div id="mcTest"  class="divSelect">                        
                    <form name="frmMCTest" action="/g2l/mcTestTaking_1.jsp">
                        Provide the test number
                        <input type="hidden" id="activity" name="activity" value="testTake"/>
                        <input type="text" id="testId" name="testId" />
                        <input type="button" value="See Details" onclick="getTestInfo();"/>
                        <input type="button" value="Proceed to take test" onclick="submit();"/>
                        <div id="mcTestDetail"></div></form>
                </div>
                <!-- Vocabulary-->
                <div id="flashGRE" class="divSelect">                       
                    <form name="frmFlashGRE" action="/g2l/GREFlash.jsp">
                        Initial alphabet
                        <input type="text" id="regEx" name="regEx"/> <br>
                        Has substring
                        <input type="text" id="regEx2" name="regEx2" /><br>
                        <input type="button" value="Submit" onclick="if($('#regEx').val()!='' || $('#regEx2').val()!='' ){submit()};"/>
                    </form>
                </div>
                <div id="underCons" style="color: white;position: absolute;top: 200px;left: 400px;" class="divSelect">
                    <img src="../icons/flagGreen.png"/>
                </div>
            </div>
        </div>
    </body>
</html>

