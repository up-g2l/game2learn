<%-- 
    Document   : enterQ
    Created on : Jul 19, 2014, 10:34:54 AM
    Author     : upendraprasad
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="g2l.dao.DataAccess"%>
<%@page import="g2l.util.GPMember"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="ErrorPage.jsp"  %>
<!DOCTYPE html>
<html>
    <head>
         <script>
            var strTags = '${requestScope.allTags}';console.log("Tags: "+strTags);                                       
            var strSources = '${requestScope.allSources}';console.log("Sources: "+strSources);                 
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/fig_upload.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/q_entry.css">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/> 
        <script  type="text/javascript"  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
         <script type="text/x-mathjax-config">
            MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']],
                                          displayMath: [['\\[','\\]'], ['$$','$$']]},
                                 styles: { ".MathJax": { color: "#0000FF"}},
                                 skipStartupTypeset: true,
                                 showProcessingMessages: true
            });

        </script>

        <title>g2l:Enter Questions</title>
    </head>
    <body>
        <jsp:include page="gameMenuBar.jsp" /> 
        <!-- Main content for question entry. -->
        <div id="outerDiv1" style="text-align: center;position: relative;" align="center">
            <div id="qEntryMsg"></div>  <br> 
            <div id="mainContentDiv" align="center">                
                <div  id="QEntryDiv"> 
                    <form id="frmQ">
                        <input id="qId" type="hidden" name="qId" value="0"/>                                                  
                        <input id="qNum" type="hidden" name="qNum" />
                        <input id="subSelect" type="hidden" value="<c:out value='${param.subSelect}' default='MAGE'/>" /> 
                        <div id="qEntered" style="background-color: #8AC007;min-height: 20px;overflow-x: auto;">Questions so far:  </div>
                        <br>    
                        <div style="text-align: center;">
                            <img class="btn-image"  src="images/btnSaveNewQ2.png" id="saveQ" onclick="saveNewQuestion();"/>
                            <img class="btn-image"  src="images/btnUpdateQ2.png"  id="updateQ" onclick="updateQData();" />
                            <img class="btn-image"  src="images/btnReset4NewQ2.png"  id="resetQ" onclick="resetQData();" />
                        </div><br>
                        <div>
                        <select id="class_level">  <option value="10">Standard</option> </select>
                        <select id="diff" >  <option value="3">Difficulty Level</option>   </select>
                        <select id="subjects" onchange="setSubArea($('#subAreas'),'sub_area');">  <option>Subject</option> </select>
                        <select id="subAreas" onchange="setQType();" disabled="disabled">  <option>Subject Area</option> </select>
                        <br>
                        <div style="overflow:hidden;display: table;">
                            <div style=" padding: 10px;text-align: left;float: left;width: 400px; height:160px;"> 
                                <label for="question" >Question #1 (id:)</label>
                                <label for="simQid">This Question is similar to.</label>
                                <input id="simQid" type="text" name="simQid" value="0"/><br>
                                <textarea id="question"  name="question" maxlength="1500" placeholder="Enter the text of the question here. Use instructions link below for help with typing math."></textarea>
                                <div style="width:380px;height: 30px;float:left;vertical-align: middle;">
                                    <a onclick="$('#popDivImgUpload5').css('display','table');coverScreenGray();" class="miniLink">Provide Figure</a> <!--<a  class="miniLink"  onclick="showInstruction(this);"> Instructions</a>&nbsp;-->
                                    <a class="miniLink" onclick="validateDataEntry();">Validate</a>                             
                                    <span style="float:right;"><input type="checkbox" id="imgSel" name="imgSel" disabled="disabled" /> Use figure?</span>
                                </div>
                            </div>
                            <div id="uploadedImage" style="float:left;width: 340px;position: relative; height:160px;">                                
                                <div id="divQImg" class="qFigBox">
                                    <img id="imgQEntry" src="uploadedImages/0.jpg" class="thumbQFig"/>
                                    <input type="hidden" value="0" id="imgId" name="imgId" />
                                </div>
                            </div>                            
                            <div id="div4Answer"  style="float:left; width:400px; padding:10px;">
                                (A) <input id="ansA" class ="ip1" type="text"  name="ansA" maxlength="200"/> <input type="radio" name="corr" id="radA" class="radio1" value="A"/><br>
                                (B) <input id="ansB"  class ="ip1" type="text"  name="ansB" maxlength="200"/> <input type="radio" name="corr" id="radB" class="radio1"  value="B"/> <br>
                                (C) <input id="ansC"  class ="ip1" type="text" name="ansC" maxlength="200"/> <input type="radio" name="corr" id="radC" class="radio1" value="C"/><br>
                                (D) <input id="ansD" class ="ip1"  type="text" name="ansD" value="All" maxlength="200"/> <input type="radio" name="corr" id="radD" class="radio1" value="D"/><br>
                                (E) <input id="ansE"  class ="ip1" type="text" name="ansE" value="None" maxlength="200"/> <input type="radio" name="corr" id="radE" class="radio1" value="E" checked="checked" />
                            </div> 
                            <!--<div><label for="explanation" title="Click for providing explanation." onclick="$('#tAreaDiv,#div4Answer').toggle();">Explanation</label>
                                <div id="tAreaDiv" style="display: none;position: relative;float:left; width:400px; padding:10px;">
                                    <textarea id="explanation" name="explanation" maxlength="1000" style="width: 350px;height:150;"> </textarea>
                                </div>
                            </div>-->
                            <div style="width: 340px;float: left;">                                                         
                                <textarea id="explanation" name="explanation" maxlength="1000"  style="width: 350px;height:80px;"  placeholder="Answer and explanation"> </textarea>
                                <input id="tag1" class ="ip2" type="text"   name="tag1" placeholder="Add a tag"/>
                                <input id="btnAddTag"  class="btnMini button primary"  type="button" value="+&nbsp;&raquo;" name="tags" onclick="$('#tags').val($('#tags').val()+$('#tag1').val()+'; ');$('#tag1').val('');" />
                                <input id="tags" class ="ip2" type="text"   name="tags" placeholder="Enter tag above and press add +" disabled="disabled"/>
                                <input id="qSource" class ="ip2"  type="text"  name="source" placeholder="Source of the question"/>
                                <input id="helpLink" class ="ip2"  type="text" name="helpLink" placeholder="Helping Links"/>
                            </div>
                        </div>                           
                    </form>
                </div>                                               
            </div>                      
        </div>

        <!-- Popup for image Selection -->
        <div id="popDivImgUpload5" class="divPopContainer">
            <div id="popHeader">Figure Selection: Click on the image.<img src="/g2l/icons/closeBWRound.png" class="imgClosePop" /></div>
            <div style="border-radius: 5px;width: 800px; height: 360px;padding: 20px;overflow-y: auto;">
                <div style="font-size: 14px;font-weight: bold;height: 30px;">Following is the list of images you have uploaded to date. 
                    <span style="color:blue;">Click on the image to select.</span>
                    <a class="miniLink" id="aNewFigQ" style="float:right;">Upload New Image</a>
                </div>
                <c:forEach items="${requestScope.allFig}" var="fig" varStatus="loop">
                    <img src="/g2l/uploadedImages/${fig.figSaveName}" class="imgThumbUploaded" onclick="useImage(${fig.figId}, '${fig.figSaveName}');" title="${fig.figCaption}"/>
                </c:forEach>

            </div>
        </div>
        <!-- Popup for new image upload -->
        <div id="popDivImgUpload6" class="divPopContainer">
            <div id="popHeader">Image Data Modification<img src="/g2l/icons/closeBWRound.png" class="imgClosePop" /></div>
            <div id="editFigBox" class="popContent">
                <div id="divFigMsg"></div>          
                <form action="/FigureUpload?act=data" method="post" enctype="multipart/form-data">
                    <div style="float: left;width: 450px;">
                        <table>
                            <tbody>                                    
                                <tr>
                                    <td><label for="figId">Id </label><input name="figId" id="figId" class="ip1" type="hidden"/></td>
                                    <td >None</td>
                                </tr>
                                <tr>
                                    <td><label for="fileName">Select Image File </label>
                                    </td><td><input id="fileName" type="file" name="fileName"/></td>                                    
                                </tr>
                                <tr>
                                    <td><label for="figCaption">Captions</label></td>
                                    <td><input name="figCaption" id="figCaption" class="ip1" type="text"/></td>
                                </tr>
                                <tr>
                                    <td><label for="figKey">Key Words</label></td>
                                    <td><input name="figKey" id="figKey" class="ip1" type="text"/></td>
                                </tr>
                                <tr>
                                    <td><label for="figSource">Source</label></td>
                                    <td><input name="figSource" id="figSource" class="ip1" type="text"/></td>
                                </tr>
                                <tr>
                                    <td><label for="figStatus">Status</label></td>
                                    <td><select name="figStatus" id="figStatus">
                                            <option value=""> Leave Unchanged</option>
                                            <option value="0">Needs Approval</option>
                                            <option value="1">Needs Editing</option>
                                            <option value="2">Approved</option>                                                
                                            <option value="3">Discard</option>
                                        </select></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <img src="images/spring/btnSave1.png" class="btn-image" onclick="uploadImage();"/>
                                        <div id="divLinkContainer">
                                            <a class="miniLink" id="aUseNewFig" style="float:right;" onclick="useNewImage();">Use this figure</a>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>  
                    <div class="qFigBox"> <img src="/g2l/uploadedImages/0.jpg" class="thumbQFig" id="imgUpdate" /></div> 
                </form>
            </div>
        </div>

        <!-- Popup for Question Preview -->
        <div id="divPopContainer">
            <div id="popHeader">Question Preview<img src="/g2l/icons/closeBWRound.png" class="imgClosePop" /></div>
            <a class="miniLink" id="aQEdit">Edit Question</a>&nbsp;<a class="miniLink" id="aQDiscard">Discard Question</a>
            <div class="divQBox" id="divQBPreview">

                <p id="previewQText" style="display: block;padding: 10px;">Question:$\sin{x}$</p>
                <div style="width:100%;position: relative;display: inline-block; ">
                    <div style=" width: 400px; float: left;">
                        <span id="previewAnsA" class="spanAns"></span>
                        <span id="previewAnsB" class="spanAns"></span>
                        <span id="previewAnsC" class="spanAns"></span>
                        <span id="previewAnsD" class="spanAns"></span>
                        <span id="previewAnsE" class="spanAns"></span><br>
                        <span class="spanQInfo">Correct Answer:  &nbsp;<span id="previewCorrAns"></span></span>
                        <span class="spanQInfo">Related Tags: &nbsp;<span id="previewTags"></span></span>
                        <span class="spanQInfo">Question Source:  &nbsp;<span id="previewSource"></span></span>
                        <span class="spanQInfo">Help Link:  &nbsp;<span id="previewHelp"></span></span>
                    </div>
                    <div class="qFigBox">  
                        <img id="previewQImg"  class="thumbQFig" src="./uploadedImages/0.jpg"/>
                    </div>
                <p id="previewExplanation" style="display: block;padding: 10px;">Explanation:</p>
                </div>

            </div> 
        </div>  
        <!-- END -->

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>   
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <script type="text/javascript" src="/g2l/js/fig_upload.js" ></script>
        <script type="text/javascript" src="/g2l/js/q_entry.js" ></script>
    </body>
</html>

