<%-- 
    Document   : mcPracticeTest1
    Created on : Jun 14, 2014, 11:16:53 PM
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
        <title>g2l: Practice</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
    </head>

    <body>
        <div style="display: none;" id="divMenuHider">
            <jsp:include page="gameMenuBar.jsp" />
        </div>    
        <div style="width:920px;margin: auto;" > 
            <div style="font-weight: bold;color: #444444;padding:5px;vertical-align: bottom;"> 
                <span>
                    <img title="Click to hide/show the menu" src="./icons/menu3.jpeg" style="margin-bottom:-8px;width: 40px;" onclick="$('#divMenuHider').slideToggle('slow');" />
                </span>&nbsp;&nbsp;&nbsp;&nbsp;
                <span id="numOfQ">  Number of Questions: </span>&nbsp;&nbsp;|&nbsp;&nbsp;
                <span id="numOfCorr">Correct:0</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; 
                <input type="checkbox" name="chkMark" id="chkMark"/><label for="chkMark">&nbsp;Checkmark?</label>&nbsp;&nbsp;|&nbsp;&nbsp;
                <span id="spanSaveBtn">
                    <img style="margin-bottom: -5px;" src="./images/spring/btnSaveData1.png" class="btn-image" id="imgBtnSubmitPrac"/>
                </span>
                <img id="imgPracIns" src="/g2l/icons/info.png" style="float: right;width: 40px;" />
                <div style="position:relative;top:5px;right:20px;">		
                    <div id="insMessage" onclick="$(this).hide();">
                        <p class="triangle-border top" id="pIns">I am your assistant. I provide suggestions when you need them.
                        </p>
                    </div>
                </div>
            </div>    
            <div style="border-top: 4px solid #666666;border-bottom: 4px solid #666666;"> 
                <div id="divSubmitInfo">
                    <span id="spanSubmitInfo"> </span><br><br>
                    <div style="margin:auto;width: 400px;" id="submitInfo">
                        <a class="miniLink" onclick="$('#divSubmitInfo').hide();">Review Practice</a>&nbsp;&nbsp; 
                        <a class="miniLink" onclick="window.location='/g2l/login/user_account.jsp';">Go Home</a>
                    </div>                    
                </div>
                <!--Instructions -->
                <div id="divPracIns"> 
                    <span style="display:block; font:bolder 18px;">Instructions</span>
                    <ul>
                        <li><img src="./icons/menu3.jpeg" style="width:30px;margin-bottom: -10px;"/>: Menu symbol  on the left can be used to show/hide the menu.</li>
                        <li><img src="./icons/info.png" style="width:30px;margin-bottom: -10px;"/>: Info button could be used to show/hide the instructions. </li>
                        <li><span style="font-weight: bold;">Figures</span> can be enlarged on hovering/touching. Touch/click somewhere else on the screen for original size. </li>
                        <li>You can register an answer by clicking on the radio button.</li>
                        <li>Correct answer is then displayed with green border and wrong answer with red.</li>
                        <li>You <span style="font-weight: bold;">can not change</span> the answer once it has been registered.</li>
                        <li>You can use the buttons on the left and right to move to adjacent questions.</li>
                        <li>Question with a <span style="font-weight: bold;">checkmark</span> show more frequently on memory-plus practice.</li>
                        <li>Do not forget to press <span style="font-weight: bold;">Save Data</span> for your practice. This is useful in the memory-plus practice.</li>
                    </ul>
                    <div style="margin: auto; width: 100px;">
                        <a class="miniLink" onclick="$('#divPracIns').slideUp('slow');">PRACTICE</a></div>
                </div>
                <form name="qListForm">
                    <table style="margin:2px;background-color: #EEEEEE;border: 1px solid #BBBBBB;">
                        <tr>
                            <td style="width:100px;">
                                <img  src="./icons/leftArrow.png" id="btnPrev"  onclick="loadQ(-1)" />
                            </td>
                            <td><!-- Question Box -->
                                <div style="width: 700px;">
                                    <div class="divQBox" id="divPracQBox">
                                        <div style="height: 170px; overflow-y: auto;margin: 0;" id="mcqDiv">
                                            <p id="previewQText">Q.</p>
                                        </div>
                                        <div style="width:100%;position: relative;display: inline-block; margin-bottom:-6px;" id="mcaDiv" >
                                            <div style=" width: 500px; float: left;height: 230px;overflow-y: auto;" id="divAnsBox">
                                                <input type="radio" name="radQAns" value="A" /><span class="spanAns1">(A)&nbsp;</span>
                                                <input type="radio" name="radQAns" value="B" /><span class="spanAns1">(B)&nbsp;</span>
                                                <input type="radio" name="radQAns" value="C" /><span class="spanAns1">(C)&nbsp;</span>
                                                <input type="radio" name="radQAns" value="D" /><span class="spanAns1">(D)&nbsp;</span>
                                                <input type="radio" name="radQAns" value="E" /><span class="spanAns1">(E)&nbsp;</span>                        
                                            </div>
                                            <div style="position:absolute;right: 15px;top:10px;"><a id="aBtnSaveAns" class="miniLink"> Answer</a></div>
                                            <div class="qFigBox">                         
                                                <img src="uploadedImages/0.jpg" class="thumbQFig" id="imgQFig"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td style="width:100px;">
                                <img  src="./icons/rightArrow.png" id="btnNext"  onclick="loadQ(1);" />
                            </td>
                        </tr>
                    </table>
                </form>
            </div> 
        </div>
   <!--     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>-->
        <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
        <script src="/g2l/js/jquery.flip.js"></script>
        <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
        <script type="text/javascript" src="/g2l/js/practice.js" ></script>
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <script type="text/x-mathjax-config">
            MathJax.Hub.Config({tex2jax: {  inlineMath: [['$','$'], ['\\(','\\)']],
            displayMath: [['\\[','\\]'], ['$$','$$']]},
            styles: {".MathJax": { color: "#0000FF"}}
            });
        </script>
        <script>
            var qString = '${pageContext.request.queryString}';
            
        </script>
    </body>
</html>

