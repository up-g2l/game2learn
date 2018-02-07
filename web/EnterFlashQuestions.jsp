<%-- 
    Document   : start
    Created on : Jan 21, 2013, 12:41:45 AM
    Author     : upendraprasad
<script type="text/javascript">

--%>

<%@page import="java.util.List"%>
<%@page import="g2l.dao.DataAccess"%>
<%@page import="g2l.util.GPMember"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="ErrorPage.jsp"  %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>g2l:Enter Questions</title>


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
         <%
            System.out.println("In EnterQuestion Page");DataAccess da = new DataAccess();
            
            String allTags=da.getAllQTags();//System.out.println("Tags Fetched");
            String allSources = da.getAllQSources();  //System.out.println("Sources Fetched");
         %>
                var strTags = "<%=allTags%>";console.log("Tags: "+strTags);
                var allTags = strTags.split(";");
                        
                var strSources = "<%=allSources%>";console.log("Sources: "+strSources);
                var allSources= strSources.split(";");
        </script>
        <style>
            label{display: inline-block; text-align: left;}
            #qEntryMsg{position: absolute; width: 100%; top: 0px; left: 0px;z-index: 15;padding: 2px;
                       text-align: center; display: none; background-image: url(images/greenBG5.jpeg);
                       font:bold 14px/18px sans-serif;color: #777777;}
            .qNum{display: inline-block; width: 30px; background-color: green;margin: 1px;
                  color: white; padding: 2px;text-align: center;border:1px solid #444444;}
            .qNum:hover{ background-color: white;color: green; cursor: pointer;}
            #popDivImgUpload,#popDivImgUpload2,#popDivQEdit{position: absolute; display: none; 
                                                            background-color: #61A220;
                                                            border: 1px green solid;  z-index: 11;padding: 2px;}

            #question{    height:120px;    width:400px;    border:1px solid; border-color:green; }

            .imgClosePop{position: absolute; top: -5px; right: -5px;width: 25px;}
        </style>

    </head>
    <%
        String subSelect = request.getParameter("subSelect");
        System.out.println("In EnterQuestion Page: Subselect= " + subSelect);
    %>
    <body>
    <%--    <jsp:include page="/g2l/gameMenuBar.jsp" />     --%>
        <div id="outerDiv1" style="text-align: center;position: relative;" align="center"><div id="qEntryMsg"></div>  <br> 
            <div id="mainContentDiv" align="center">
                <!-- Main content for questWhation entry. -->
                <div  id="QEntryDiv"> 
                    <form id="frmQ">
                        <input id="qId" type="hidden" name="qId" value="0"/>                                                  
                        <input id="qNum" type="hidden" name="qNum" />
                        <input id="subSelect" type="hidden" value="<%=subSelect%>" /> 

                        <div style="width: 680px;margin: auto;padding: 5px;">
                            <span>Questions entered so far (Click to edit).</span>
                            <div id="qEntered" style="width: auto; background-color: #8AC007">                                
                            </div>                            
                        </div>  
                        <br>    
                        <div style="text-align: center;">
                            <img class="btn-image"  src="images/btnSaveNewQ2.png" id="saveQ" onclick="saveNewQuestion();"/>
                            <img class="btn-image"  src="images/btnUpdateQ2.png"  id="updateQ" onclick="qUpdate();" />
                            <img class="btn-image"  src="images/btnReset4NewQ2.png"  id="resetQ" onclick="resetQData();" />
                        </div><br>
                        <div style="overflow:hidden;">
                            <div style=" padding: 10px;text-align: left;float: left;width: 360px; height:160px;"> 
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
                                <a onclick="popImgUploader()" class="miniLink">Upload Image</a> <!--<a  class="miniLink"  onclick="showInstruction(this);"> Instructions</a>&nbsp;-->
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
                            <div style="width: 300px;float: left;">                                                         
                                <label for="simQid">This Question is similar to.</label>
                                <input id="simQid" type="text" name="simQid" value="0"/>
                                <input id="tag1" class ="ip2" type="text"   name="tag1" placeholder="Add a tag"/>
                                <input id="btnAddTag"  class="btnMini button primary"  type="button" value="+&nbsp;&raquo;" name="tags" onclick="$('#tags').val($('#tags').val()+$('#tag1').val()+'; ');$('#tag1').val('');" />
                                <input id="tags" class ="ip1" type="text"   name="tags" placeholder="Enter tag above and press add +" disabled="disabled"/>
                                <input id="qSource" class ="ip1"  type="text"  name="source" placeholder="Source of the question"/> 
                                <input id="helpLink" class ="ip1"  type="text" name="helpLink" placeholder="Helping Links"/>
                            </div>
                        </div>  
                       <!-- <label for="explanation" title="Click for providing explanation." onclick="$('#tAreaDiv').toggle();">Explanation</label>
                        <div id="tAreaDiv" style="display: none;position: relative;"><textarea id="explanation" name="explanation" maxlength="500"> </textarea></div>
                       -->
                    </form>
                </div>                                               
            </div>                      
        </div>

        <!-- Popup for image upload -->
        <div id="popDivImgUpload">
            <span style="padding-left: 10px;padding-bottom: 10px;color: white; font: 12px normal;"> Image Upload</span>
            <img id="closeImgUpload" src="icons/closeBWRound.png" class="imgClosePop"/>
            <div style="background-color: white;border-radius: 5px;width: 720px; height: 420px;padding: 20px;">
                <form  method="post" name="uploadForm" id="frmImgUpload" enctype="multipart/form-data">                    
                    <input id="uploadFile" name="uploadFile" type="file"  style="padding: 6px;"/><br><br>   
                    <div style="position: relative;display: inline-block;width: 100%;">                        
                        <div style="float:left;width:400px;height:300px;">
                            <input type="text" name="imgCaption" id="imgCaption" placeholder="Caption" /><br>
                            <input type="text" name="imgAltText" id="imgAltText" placeholder="Alternate Text"  /><br>
                            <input type="text" name="imgKeywords"  id="imgKeywords" placeholder="Key Words"/><br>
                            <input type="text"  name="imgSource" id="imgSource" placeholder="Image Source" /><br><br>
                        </div>
                        <div class="qFigBox">  
                             <img id="qImgUpload"  class="thumbQFig" src="./uploadedImages/0.jpg"/>
                        </div>
                    </div>
                    <div style="width:500px; margin: auto; text-align: center;" >
                        <img  class="btn-image"   onclick="uploadImage();" src="images/spring/btnUpload2.png"/>
                        <img  class="btn-image"   onclick="updateImageData()" src="images/spring/btnSaveData2.png"/>
                        <img  class="btn-image"  id="btnUseImg" src="images/spring/btnUseImg2.png"/>
                    </div>
                </form>
            </div>   
        </div>

        <!-- Popup for Question Preview -->
        <div id="popDivQEdit">Question Preview
            <img id="closeQPreview" src="icons/closeBWRound.png"  class="imgClosePop" />
            <br>
            <div class="divQBox">
                <a class="miniLink" id="aQEdit">Edit Question</a>&nbsp;<a class="miniLink" id="aQDiscard">Discard Question</a>
                <p id="previewQText" style="display: block;padding: 10px;">Question</p>
                <div style="width:100%;position: relative;display: inline-block; ">
                    <div style=" width: 400px; float: left;">
                        <span id="previewAnsA" class="spanAns"></span>
                        <span id="previewAnsB" class="spanAns"></span>
                        <span id="previewAnsC" class="spanAns"></span>
                        <span id="previewAnsD" class="spanAns"></span>
                        <span id="previewAnsE" class="spanAns"></span>
                    </div>
                    <div class="qFigBox">  
                        <img id="previewQImg"  class="thumbQFig" src="./uploadedImages/0.jpg"/>
                    </div>
                </div>
                <span class="spanQInfo">Correct Answer:  &nbsp;<span id="previewCorrAns"></span></span>
                <span class="spanQInfo">Related Tags: &nbsp;<span id="previewTags"></span></span>
                <span class="spanQInfo">Question Source:  &nbsp;<span id="previewSource"></span></span>
                <span class="spanQInfo">Help Link:  &nbsp;<span id="previewHelp"></span></span>
            </div> 
        </div>  
        <!-- END -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <script type="text/javascript"   src="https://c328740.ssl.cf1.rackcdn.com/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
        <script type="text/javascript" src="/g2l/js/qEntry.js" ></script>
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <script>
            
            $(document).ready(function(){
                $("#closeImgUpload, #closeQPreview").mouseover(function() {                     
                    var src = $(this).attr("src").replace("BW", "GW");
                    $(this).attr("src", src);
                }).mouseout(function() {
                    var src = $(this).attr("src").replace("GW", "BW");
                    $(this).attr("src", src);
                }).mousedown(function(){
                    coverToGrayOut1(true); $(this).parent().hide();
                });
            });
            // style="position: absolute; top: -8px; right: -8px;width: 25px;" onmouseover="this.src='images/closeXGreen.png'" onmouseout="this.src='icons/Close1.png'" onclick="coverToGrayOut1(true); $(this).parent().hide();

             
            var imageId=0;
            var imgJson={};
            var previewQJson={};
            
                $(function() {
                    
                    $( "#tag1" ).autocomplete({
                        source: allTags
                    });
                    
                    $( "#qSource" ).autocomplete({
                        source: allSources
                    });
                    
                    $('#btnUseImg').click(function(){
                        $('#imgQEntry').attr("src","uploadedImages/"+imgJson.qImgName); 
                        $('#imgId').val(imgJson.qImgId);
                        $('#imgSel').attr('disabled','');
                        $('#imgSel').attr('checked','checked');
                    });
                    
                    $('#aQEdit').click(function(){                        
                        $('#qId').val(previewQJson.qId);
                        $('#question').val(previewQJson.qText);
                        $('#ansA').val(previewQJson.ansA);
                        $('#ansB').val(previewQJson.ansB);
                        $('#ansC').val(previewQJson.ansC);
                        $('#ansD').val(previewQJson.ansD);
                        $('#ansE').val(previewQJson.ansE);
                        $('#qSource').val(previewQJson.source);
                        $('#tags').val(previewQJson.tags);
                        $('#helpLink').val(previewQJson.helpLink);
                        $('#subSelect').val(previewQJson.qType);
                        $('#imgId').val(previewQJson.figId);
                        $('#imgQEntry').attr("src","uploadedImages/"+previewQJson.figName);
                        $('#simQid').val(previewQJson.simQid);
                        var idRad = '#rad'+previewQJson.ansCorr;
                        $(idRad).attr("checked","checked");  
                        $('label[for="question"]').text('Question (id:'+previewQJson.qId+')');
                        if(previewQJson.figId!='0'){$('#imgSel').attr("checked","checked");}
                    });
    
                });
            
           
        </script>
                <script>
            // window.onbeforeunload = function() { return "Are you sure you want to leave or reload? Current Data will no longer be available."; } 

            function uploadImage(){
                //alert('step1');               
                var formData = new FormData($('form')[1]);
                
                $.ajax({
                    url: 'ImageUploader',  //server script to process data
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    dataType:'json',
                    success: function(data) { imgJson = eval(data);
                                  $('#qImgUpload').attr("src","uploadedImages/"+imgJson.qImgName); 
                                             },
                    error: function(jqXHR, textStatus, errorMessage) {
                        console.log(errorMessage); // Optional
                    }
                })//.done(function(data) {       $('#uploadedImage').html(data);          });
            }
  
            function updateImageData(){
                //alert('step1');              
                
                // if(false){alert('Please upload the image first.');}
                // else{
                //  var formData = new FormData($('form')[1]);
                $.ajax({
                    url: 'ImageDataUploader',  //server script to process data
                    type: 'POST',
                    data: {imgId:$('#imgId').val(),
                        imgCaption:$('#imgCaption').val(),
                        imgKeyWords:$('#imgKeyWords').val(),
                        imgAltText:$('#imgAltText').val(),
                        imgSource:$('#imgSource').val()                        
                    },
                    success: function(data) {
                        $('#imgPreview').html("Data Uploaded Successfully.");
                        //alert("Image Id is:"+$('#imgId').val());
                    },
                    error: function(jqXHR, textStatus, errorMessage) {
                        $('#imgPreview').html("Failure in data updation.");
                        console.log(errorMessage); // Optional
                    }
                })//.done(function(data) {       $('#uploadedImage').html(data);          });
                // }
            }
            function popImgUploader(){
    
                X = window.innerWidth;
                Y = window.innerHeight;
                
                boxWidth = 720;
                boxHeight = 480;
                
                boxLeft = (X - boxWidth)/2;
                boxTop = (Y - boxHeight)/2;
                coverToGrayOut1(false);
                qEditEle = document.getElementById('popDivImgUpload');
                qEditEle.style.top =boxTop+'px';
                qEditEle.style.left =boxLeft+'px';
                qEditEle.style.display = 'block';                
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
            
            function resetQData(){
                $('form')[0].reset();
                $('#qNum').val('');$('#qId').val('0');$('#updateQ').attr('disabled','true');
                $('#simQid').val('0'); $('#divQImg').empty();
            }
    

            function qPreview(qId){
                //alert('Question Id is: '+qId);
                fetchQuestionDetails(qId);
    
                X = window.innerWidth;
                Y = window.innerHeight;
                
                boxWidth = 750;
                boxHeight = 500;
                
                boxLeft = (X - boxWidth)/2;
                boxTop = (Y - boxHeight)/2;
                coverToGrayOut1(false);
                qEditEle = document.getElementById('popDivQEdit');
                qEditEle.style.top =boxTop+'px';
                qEditEle.style.left =boxLeft+'px';
                qEditEle.style.display = 'block';
                MathJax.Hub.Queue(['Typeset',MathJax.Hub]);
            }

            function fetchQuestionDetails(qId){
                $.get("QFetcher?id="+qId,function(data,status){ previewQJson = eval(data);
                    // alert("Data: " + previewQJson.qText + "\nStatus: " + status);
                    $('#previewQid').val(previewQJson.qId);
                    //$('#qNum').val(qNum);
                    $('#previewQText').text('Question: '+previewQJson.qText);
                    $('#previewAnsA').text('(A) '+previewQJson.ansA);
                    $('#previewAnsB').text('(B) '+previewQJson.ansB);
                    $('#previewAnsC').text('(C) '+previewQJson.ansC);
                    $('#previewAnsD').text('(D) '+previewQJson.ansD);
                    $('#previewAnsE').text('(E) '+previewQJson.ansE);
                    $('#previewCorrAns').text(previewQJson.ansCorr);
                    $('#previewSource').text(previewQJson.source);
                    $('#previewTags').text(previewQJson.tags);
                    $('#previewHelp').text(previewQJson.helpLink);
                    $('#previewQImg').attr("src", "uploadedImages/"+previewQJson.figName);
                });
            }
            
       function qUpdate(){
                var valRadio, imgId=0;
                if($('#qId').val()=='0'){alert($('#qId').val()+': Save the question first.'); return false;}
              //  if(!validateDataEntry()){  return false;}
                     valRadio = $("input[@name=corr]:checked").val();    console.log("1: "+valRadio);  
                    if($('#imgSel').attr("checked")==true){imgId =$('#imgId').val(); }
                    $.post("QEntry",
                    {   
                        qId:$('#qId').val(),   
                        question: $('#question').val(), 
                        ansA: $('#ansA').val(),
                        ansB : $('#ansB').val(),
                        ansC :$('#ansC').val(),        
                        ansD : $('#ansD').val(),
                        ansE: $('#ansE').val(),
                        subSelect: $('#subSelect').val(),       
                        source: $('#qSource').val(),
                        correct: valRadio,
                        helpLink:$('#helpLink').val(),
                        explanation:$('#explanation').val(),
                        tags: $('#tags').val(),
                        figId:imgId, 
                        simQid: $('#simQid').val()
                    },
                    function(data,status){  console.log("2");    
                                $('#qEntryMsg').show();
                                $('#qEntryMsg').text(qEntryMsg);
                                setTimeout(function(){
                                    $('#qEntryMsg').hide();
                                }, 10000);
                        // showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,true,true ); 
                        });
            }
            
        </script> 
    </body>
</html>
