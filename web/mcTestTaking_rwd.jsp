<%-- 
    Document   : mcTestTaking
    Created on : Sep 21, 2015, 4:54:44 PM
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
        <!--   <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">-->
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <style>
            #divPracQBox{width:80%;margin:auto;}
            
            @viewport {    width: device-width;    zoom: 1;}


            @media only screen and  (max-width: 1080px){
                body{font-size: 2.5vw;}
                #divPracQBox{width:90%;margin:auto;}
                .spanAns1{display: inline-block; width:70%; background-color: #EEEEEE; padding: 4px;
                          border: 1px solid #DDDDDD; font-size: 30; color: #888888;}
                #previewQText,.qAprvlInstruction{color:#666666; display: block;padding: 10px;font: normal 24px/30px sans-serif;
                                                 background-color: #EEEEEE;border: 1px solid #CCCCCC;margin: 0px; }
                .qFigBox{position: absolute; right:0px; bottom:4px;width: auto;height:25vh;padding: 3px;flex-order: 3;
                         border: 4px solid #DDDDDD;z-index: 5; background-color: #DDDDDD;box-shadow: 0 0 3px #888888;}    
                .divQBox{background-color:#B2E0C2; text-align: left;width: available;margin: auto;order:3;
                         padding: 10px;margin: 10px; box-shadow: 0px 0px 4px  #666666; height: auto;}
                .thumbQFig{  position:relative; width:auto;height:auto; max-width: 120px; max-height: 160px;margin: 0px;margin-bottom: -5px; }
                .thumbQFig:hover{ width:auto;height:auto; max-width: 640px; max-height: 380px;}
                #divPracIns,#divSubmitInfo{position: absolute;padding: 1vw; width:90%; 
                                           height: fit-content; display: none;color: #444444;
                                           z-index: 20;margin:0;background-color:  rgba(194,231,194,1.0);}

                #divPracIns li{display: list-item; font-size: 4vw/6vw; color: #666666;  margin: 1vw; padding: 1vw;}

                #divPracIns ul{list-style-type: square;font-size: 4vw;}
                #qEntryMsg{position: absolute; width: 100%; top: 0px; left: 0px;z-index: 15;padding: 2px;
                           text-align: center; display: none; background-image: url(images/greenBG5.jpeg);
                           font:bold 14px/18px sans-serif;color: #777777;}
                #imgBtnSubmitTest,#imgPracIns{height:5vw;width: auto;}
                #divAnsBox{width: 100%;order:2; height: fit-content;}
                #divQText{height:30vh; overflow-y: auto;margin: 0;}
                
            }

        </style>
    </head>

    <body>

        <div style="width:95%;margin: auto;" > 
            <!-- Title bar-->
            <div style="font-weight: bold;color: #444444;padding:5px;vertical-align: bottom;"> 
                <!--   <span>
                       <img title="Click to hide/show the menu" src="./icons/menu3.jpeg" style="margin-bottom:-8px;width: 40px;" onclick="$('#divMenuHider').slideToggle('slow');" />
                   </span>&nbsp;&nbsp;-->&nbsp;&nbsp;
                <span id="numOfQ">Questions: </span>&nbsp;&nbsp;|&nbsp;&nbsp;
                <span id="numOfCorr">Correct:0</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; 
                <!-- <input type="checkbox" name="chkMark" id="chkMark"/><label for="chkMark">&nbsp;Checkmark?</label>&nbsp;&nbsp;|&nbsp;&nbsp;-->
                <span id="spanSaveBtn">
                    <img style="margin-bottom: -5px;" src="./images/spring/btnSubmit1.png" class="btn-image" id="imgBtnSubmitTest"/>
                </span>
                <img id="imgPracIns" src="/g2l/icons/info.png" style="float: right;width: 40px;" />
                <!-- The i-Symbol -->
                <div style="position:relative;top:5px;right:20px;">		
                    <div id="insMessage" onclick="$(this).hide();">
                        <p class="triangle-border top" id="pIns">I am your assistant. I provide suggestions when you need them.
                        </p>
                    </div>
                </div>
            </div>    
            <div style="border-top: 4px solid #666666;border-bottom: 4px solid #666666;"> 
                <!-- When submit is made-->
                <div id="divSubmitInfo">
                    <span id="spanSubmitInfo"> </span><br><br>
                    <div style="margin:auto;width: 400px;" id="submitInfo">
                        <a class="miniLink" onclick="$('#divSubmitInfo').hide();">Review Practice</a>&nbsp;&nbsp; 
                        <a class="miniLink" onclick="window.location='/g2l/login/user_account.jsp';">Go Home</a>
                    </div>                    
                </div>
                <!--Instructions -->
                <div id="divPracIns"> 
                    <span style="display:block; font:bolder 18px;">INSTRUCTIONS</span>
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
                        <a class="miniLink" onclick="$('#divPracIns').slideUp('slow');">START</a></div>
                </div>
                <form name="qListForm">
                    <div>
                        <div class="divQBox" id="divPracQBox">
                            <div id="divQText">
                                <p id="previewQText">Q.</p>
                            </div>
                            <div style="width:100%; height:50%; position: relative;display: flex;flex-direction:column;">
                                <div style="order: 1;"><a id="aBtnSaveAns" class="miniLink" > Show/hide Answer</a></div><br>
                                <div id="divAnsBox">
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
                        </div>
                    </div>
                    <img  src="./icons/leftArrow.png" id="btnPrev"  onclick="loadQ(-1)" style="float: left;" />
                    <img  src="./icons/rightArrow.png" id="btnNext"  onclick="loadQ(1);" style="float: right;" />
                </form>
            </div> 
        </div>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
        <script type="text/javascript" src="/g2l/js/mcTest.js" ></script>
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <script type="text/x-mathjax-config">
            MathJax.Hub.Config({tex2jax: {  inlineMath: [['$','$'], ['\\(','\\)']],
            displayMath: [['\\[','\\]'], ['$$','$$']]},
            styles: {".MathJax": { color: "#0000FF"}}
            });
        </script>
        <script>
            var qString = '${pageContext.request.queryString}';
            console.log("Quesry String: "+qString);
        </script>
    </body>
</html>
