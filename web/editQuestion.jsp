<%-- 
    Document   : editQuestion
    Created on : Jul 30, 2014, 12:44:50 AM
    Author     : upendraprasad
--%>

<%-- 
    Document   : AccessQBank
    Created on : Mar 2, 2013, 8:10:03 PM
    Author     : upendraprasad
--%>

<%@page import="g2l.dao.QuestionDAO"%>
<%@page import="g2l.util.VocabEng"%>
<%@page import="g2l.util.GPMember"%>
<%@page import="java.util.List"%>
<%@page import="g2l.util.MCQuestion"%>
<%@page import="g2l.dao.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
    <head>    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/fig_upload.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/q_entry.css">

        <title>g2l: Access Question Bank</title>
        <style type="text/css">
            #divQList{margin: auto; alignment-adjust: central;width: 780px; padding: 10px;border: 1px green solid;}
            #question{width: 400px;height: 80px;}
        </style>

    </head>
    <body>

        <jsp:include page="gameMenuBar.jsp" />
        <div>
            <br>
            <div style="background-color: #8AC007; color: white;width: 780px;margin: auto;padding: 5px;" >Following is the list of questions with the provided criteria.</div>
            <!-- List of Questions-->
            <div style="position: relative;">
                <br><div id="divQList">

                    <c:forEach items="${requestScope.qList}" var="qb" varStatus="loop">                  
                        <div class="divQBox" id="divQBox${qb.qId}">
                            <a  onclick="editQuestion(${qb.qId})" class="miniLink">Edit Question</a>
                            <p id="previewQText">Question ${loop.index}:&nbsp;${qb.qText}</p>
                            <div style="width:100%;position: relative;display: inline-block; ">
                                <div style=" width: 400px; float: left;">
                                    <span class="spanAns">(A)&nbsp;<c:out value='${qb.ansA}' /></span>
                                    <span class="spanAns">(B)&nbsp;<c:out value='${qb.ansB}' /></span>
                                    <span class="spanAns">(C)&nbsp;<c:out value='${qb.ansC}' /></span>
                                    <span class="spanAns">(D)&nbsp;<c:out value='${qb.ansD}' /></span>
                                    <span class="spanAns">(E)&nbsp;<c:out value='${qb.ansE}' /></span>
                                </div>
                                <div class="qFigBox">  
                                    <img src="uploadedImages/${qb.figure.figSaveName}" class="thumbQFig"/>
                                </div>
                            </div>
                            <span class="spanQInfo">Correct Answer: &nbsp;${qb.ansCorrect}</span>
                            <span class="spanQInfo">Question Source:  &nbsp;${qb.source}</span>
                            <span class="spanQInfo">Related Tags:  &nbsp;${qb.tags}</span>
                            <span class="spanQInfo">Help:  &nbsp;${qb.helpLink}</span>
                        </div>        
                    </c:forEach>
                    There are no more questions with the given search criteria.
                </div>
            </div>           

            <!-- Box for Editign question--><!--
            <div  id="QEditDiv" class="QEditDiv">
                <img src="images/close1.png" class="btnCloseX" id="btnClose"/>
                <form id="frmQ">
                    <span id="updateQStatus" style="color:green;font-weight: bold;"></span>

                    <br>
                    <input id="qId" type="hidden" name="qId" value="0"/>
                    <input id="qNum" type="hidden" name="qNum" />
                    <input id="subSelect" type="hidden" value="" />
                    <div style="overflow:hidden;">
                        <div style=" padding: 10px;text-align: left;float: left;width: 400px; height:160px;"> 
                            <label for="question" >Question #1 (id:)</label><br>
                            <textarea id="question"  name="question" maxlength="1500" placeholder="Enter the text of the question here. Use instructions link below for help with typing math."></textarea>

                        </div>
                        <div id="uploadedImage" style="float:left;width: 300px;position: relative; height:160px;">                                
                            <div id="divQImg" class="qFigBox">
                                <img id="imgQEntry" src="uploadedImages/0.jpg" class="thumbQFig"/>
                                <input type="hidden" value="0" id="imgId" name="imgId" />
                            </div>
                        </div>
                        <div style="width:700px;height: 30px;float:left;vertical-align: middle;">
                            <a onclick="popImgUploader()" class="miniLink">Upload Image</a> 
                            <a class="miniLink" onclick="validateDataEntry();">Validate</a>                             
                            <span style="float:right;"><input type="checkbox" id="imgSel" name="imgSel" disabled="disabled" /> Include this figure in the question?</span>
                        </div>
                        <div id="div4Answer"  style="float:left; width:300px; padding:10px;">
                            (A) <input id="ansA" class ="ip1" type="text"  name="ansA" maxlength="200"/> <input type="radio" name="corr" id="radA" class="radio1" value="A"/><br>
                            (B) <input id="ansB"  class ="ip1" type="text"  name="ansB" maxlength="200"/> <input type="radio" name="corr" id="radB" class="radio1"  value="B"/> <br>
                            (C) <input id="ansC"  class ="ip1" type="text" name="ansC" maxlength="200"/> <input type="radio" name="corr" id="radC" class="radio1" value="C"/><br>
                            (D) <input id="ansD" class ="ip1"  type="text" name="ansD" value="All" maxlength="200"/> <input type="radio" name="corr" id="radD" class="radio1" value="D"/><br>
                            (E) <input id="ansE"  class ="ip1" type="text" name="ansE" value="None" maxlength="200"/> <input type="radio" name="corr" id="radE" class="radio1" value="E" checked="checked" />
                        </div>    
                        <div style="width: 200px;float: left;">                                                         
                            <label for="simQid">This Question is similar to.</label>
                            <input id="simQid" type="text" name="simQid" value="0"/>
                            <input id="tag1" class ="ip2" type="text"   name="tag1" placeholder="Add a tag"/>
                            <input id="btnAddTag"  class="btnMini button primary"  type="button" value="+&nbsp;&raquo;" name="tags" onclick="$('#tags').val($('#tags').val()+$('#tag1').val()+'; ');$('#tag1').val('');" />
                            <input id="tags" class ="ip1" type="text"   name="tags" placeholder="Enter tag above and press add +" disabled="disabled"/>
                            <input id="qSource" class ="ip1"  type="text"  name="source" placeholder="Source of the question"/> 
                            <input id="helpLink" class ="ip1"  type="text" name="helpLink" placeholder="Helping Links"/>
                        </div>
                    </div>  
                    <div style="text-align: center;"><input id="updateQ" onclick="qUpdate();" type="button"  value="Update Question"/></div>                                
                </form>            
            </div> 
            -->
            <!-- Question Edit Box-->
            <div id="divPopContainer">
                <div id="popHeader">Question Editing<img src="/g2l/icons/closeBWRound.png" class="imgClosePop" /></div>
                <div id="qEntryMsg"></div>
                    <form id="frmQ">
                        <input id="qId" type="hidden" name="qId" value="0"/>                                                  
                        <input id="qNum" type="hidden" name="qNum" />
                        <input id="subSelect" type="hidden" value="<c:out value='${param.subSelect}' default='MAGE'/>" /> 
                        <br>
                        
                        <select id="class_level">  <option value="10">Standard</option> </select>
                        <select id="diff" >  <option value="3">Difficulty Level</option>   </select>
                        <select id="subjects" onchange="setSubArea($('#subAreas'),'sub_area');">  <option>Subject</option> </select>
                        <select id="subAreas" onchange="setQType();" disabled="disabled">  <option>Subject Area</option> </select><br>
                        <div style="overflow:hidden;display: table;">
                            <div style=" padding: 10px;text-align: left;float: left;width: 400px; height:160px;"> 
                                <label for="question" >Question #1 (id:)</label><br>
                                <textarea id="question"  name="question" maxlength="1500" placeholder="Enter the text of the question here. Use instructions link below for help with typing math."></textarea>
                                <div style="width:385px;height: 30px;float:left;vertical-align: middle;">
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
                            <div style="width: 340px;float: left;">                                                         
                                <label for="simQid">This Question is similar to.</label>
                                <input id="simQid" type="text" name="simQid" value="0"/><br>
                                <input id="tag1" class ="ip2" type="text"   name="tag1" placeholder="Add a tag"/>
                                <input id="btnAddTag"  class="btnMini button primary"  type="button" value="+&nbsp;&raquo;" name="tags" onclick="$('#tags').val($('#tags').val()+$('#tag1').val()+'; ');$('#tag1').val('');" />
                                <input id="tags" class ="ip1" type="text"   name="tags" placeholder="Enter tag above and press add +" disabled="disabled"/>
                                <input id="qSource" class ="ip1"  type="text"  name="source" placeholder="Source of the question"/> <br>
                                <input id="helpLink" class ="ip1"  type="text" name="helpLink" placeholder="Helping Links"/>
                            </div>
                        </div>  
                        <div style="text-align: center;">                            
                            <img class="btn-image"  src="images/btnUpdateQ2.png"  id="updateQ" onclick="updateQData();" />                            
                        </div><br>
                        <!-- <label for="explanation" title="Click for providing explanation." onclick="$('#tAreaDiv').toggle();">Explanation</label>
                         <div id="tAreaDiv" style="display: none;position: relative;"><textarea id="explanation" name="explanation" maxlength="500"> </textarea></div>
                        -->
                    </form>
            </div>
                        
                            <!-- Popup for image Selection -->
        <div id="popDivImgUpload5" class="divPopContainer">
            <div id="popHeader">Figure Selection: Click on the image.<img src="/g2l/icons/closeBWRound.png" class="imgClosePop" /></div>
            <div style="border-radius: 5px;width: 800px; height: 360px;padding: 20px;overflow-y: auto;">
                <div style="font-size: 14px;font-weight: bold;height: 30px;">Following is the list of images you have uploaded to date. 
                    <span style="color:blue;">Click on the image to select.</span>                    
                </div>
                <c:forEach items="${requestScope.allFig}" var="fig" varStatus="loop">
                    <img src="/g2l/uploadedImages/${fig.figSaveName}" class="imgThumbUploaded" onclick="useImage(${fig.figId}, '${fig.figSaveName}');"/>
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

        </div>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>   
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <script type="text/javascript" src="/g2l/js/fig_upload.js" ></script>
        <script type="text/javascript" src="/g2l/js/q_entry.js" ></script>
        <script  type="text/javascript"  
                 src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">            
        </script>

        <script type="text/x-mathjax-config">
            MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']],
            displayMath: [['\\[','\\]'], ['$$','$$']]},
            styles: { ".MathJax": { color: "#0000FF"}}
            });
        </script>
           <script>
            var strTags = '${requestScope.allTags}';console.log("Tags: "+strTags);                                       
            var strSources = '${requestScope.allSources}';console.log("Sources: "+strSources);                 
        </script>

        <script>
            $(document).ready(function(){
                
                //MathJax.Hub.Queue(['Typeset',MathJax.Hub,'questionTable']);
                //$('#questionTable tr:odd').css("background-color","#CCCCCC");
                // $('#questionTable tr:odd').css("text-align","center");
                $("#btnClose").mouseover(function() { 
                    //var src = $(this).attr("src").match(/[^\.]+/) + "over.gif";
                    var src = $(this).attr("src").replace("1.png", "X.png");
                    $(this).attr("src", src);
                }).mouseout(function() {
                    var src = $(this).attr("src").replace("X.png", "1.png");
                    $(this).attr("src", src);
                }).mousedown(function() {
                    coverToGrayOut1(true); $('#QEditDiv').hide();
                }); 
                //  onmouseover="this.src='images/closeX.jpeg'" onmouseout="this.src='icons/Close1.png'" onclick="coverToGrayOut1(true); $('#QEditDiv').hide();
                
            });
            
            
           
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

            function editQuestion1(qId){
                //alert('Question Id is: '+qId);
                fetchQuestionDetails(qId);
    
                X = window.innerWidth;
                Y = window.innerHeight;
                
                boxWidth = 800;
                boxHeight = 500;
                
                boxLeft = (X - boxWidth)/2;
                boxTop = (Y - boxHeight)/2;
                coverToGrayOut1(false);
                qEditEle = document.getElementById('QEditDiv');
                qEditEle.style.top =boxTop+'px';
                qEditEle.style.left =boxLeft+'px';
                qEditEle.style.display = 'block';
            }
            function editQuestion(qId){
                //alert('Question Id is: '+qId);
                fetchQuestionDetails(qId);
                $('#divPopContainer').css("display","table"); 
                coverScreenGray();
    
            }

            function fetchQuestionDetails(qId){
                $.get("QFetcher?id="+qId,
                function(data,status){var qObj = eval(data);
                    // alert("Data: " + qObj.qText + "\nStatus: " + status);
                    $('#qId').val(qObj.qId);
                    //$('#qNum').val(qNum);
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
                    $('#imgId').val(qObj.figId);
                    $('#imgQEntry').attr("src","uploadedImages/"+qObj.figName);
                    $('#simQid').val(qObj.simQid);
                    var idRad = '#rad'+qObj.ansCorr;
                    $(idRad).attr("checked","checked");  
                    $('label[for="question"]').text('Question (id:'+qObj.qId+')');
                    if(qObj.figId!='0'){$('#imgSel').attr("checked","checked");}
                });
            }
            
            function refreshQuestionDetails(qId){
                $.get("QFetcher?id="+qId,function(data,status){var qObj = eval(data);
                    // alert("Data: " + qObj.qText + "\nStatus: " + status);
                    $('#previewQid').val(qObj.qId);
                    //$('#qNum').val(qNum);
                    $('#previewQText').text('Question: '+qObj.qText);
                    $('#previewAnsA').text('(A) '+qObj.ansA);
                    $('#previewAnsB').text('(B) '+qObj.ansB);
                    $('#previewAnsC').text('(C) '+qObj.ansC);
                    $('#previewAnsD').text('(D) '+qObj.ansD);
                    $('#previewAnsE').text('(E) '+qObj.ansE);
                    $('#previewSource').text(qObj.source);
                    $('#previewTags').text(qObj.tags);
                    $('#previewHelp').text(qObj.helpLink);
                    $('#previewQImg').html('<img class="imgFig" src="uploadedImages/'+qObj.figId+'"/>');
                    //$('#subSelect').val(qObj.qType);
                    //  var idRad = '#rad'+qObj.ansCorr;
                    // $(idRad).attr("checked","checked");  
                    // $('label[for="question"]').text('Question (id:'+qObj.qId+')');
                    MathJax.Hub.Queue(['Typeset',MathJax.Hub,'questionTable']);
                });
            }
  
            function qUpdate(){
                //alert('step1');
                if(!validateDataEntry()){  return false;}
                else{ 
                    var valRadio = $("input[@name=corr]:checked").val();
                    //if($('#qNum').val()==''){alert('Save the question first.'); return false;}
                    $.post("QEntry",
                    {   qId:$('#qId').val(),
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
                        if(status=='success'){
                            
                            var divQEle =document.getElementById('divQBox'+$('#qId').val());                            
                            $(divQEle).find('p').text($('#question').val());
                            var allSpan = $(divQEle).find('span');//alert(allSpan.eq(1).text());
                            allSpan.eq(0).text("(A) "+$('#ansA').val());
                            allSpan.eq(1).text("(B) "+$('#ansB').val());
                            allSpan.eq(2).text("(C) "+$('#ansC').val());
                            allSpan.eq(3).text("(D) "+$('#ansD').val());
                            allSpan.eq(4).text("(E) "+$('#ansE').val());
                            
                            MathJax.Hub.Queue(['Typeset',MathJax.Hub,divQEle.id]);
                            //$('#previewQImg').html('<img class="imgFig" src="uploadedImages/'+qObj.figId+'"/>');
                        }
                    });
                }
            }
       
        </script>

    </body>
</html>
