/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


    // window.onbeforeunload = function() { return "Are you sure you want to leave or reload? Current Data will no longer be available."; } 

            var imageId=0;
            var imgJson={};
            var jsonFigure={};
            var previewQJson={};
            var allTags=[];
            var allSources=[];
            var req;
            var isIE;
            var completeField;
            var completeTable;
            var autoRow;
            var eleStatus;
            var qEntryMsg = "";
            var qDB = [];
            var qObj={};
 
$(function() {
                loadComboBoxes('/g2l/menu_combo_box.xml');    
                
                //MathJax.Hub.Typeset();
                    
                allTags = strTags.split(";");   
                allSources= strSources.split(";");
                    
                $( "#tag1" ).autocomplete({ source: allTags });
                    
                $( "#qSource" ).autocomplete({source: allSources });
                
                $('#aNewFigQ').click(function(){
                    $('#divFigMsg').html("Message: Select an image file (size < 1MB), provide details and save.");
                    $('#popDivImgUpload5').css("display","none");
                    $('#popDivImgUpload6').css('display','table');
                });
                    
                $('#btnUseImg').click(function(){
                    $('#imgQEntry').attr("src","uploadedImages/"+imgJson.qImgName); 
                    $('#imgId').val(imgJson.qImgId);
                    $('#imgSel').attr('disabled','');
                    $('#imgSel').attr('checked','checked');
                });
                
  
                $('#aQEdit').click(function(){  
                    
                    $("span[class|='qNum']").css("background-color","green"); 
                                $("span[id|='q"+previewQJson.qId+"']").css("background-color","#E3E3DE");
                                
                    $('#qId').val(previewQJson.qId);
                    $('#question').val(previewQJson.qText);
                    $('#ansA').val(previewQJson.ansA);
                    $('#ansB').val(previewQJson.ansB);
                    $('#ansC').val(previewQJson.ansC);
                    $('#ansD').val(previewQJson.ansD);
                    $('#ansE').val(previewQJson.ansE);
                    $('#qSource').val(previewQJson.source);
                    $('#explantion').val(previewQJson.explanation);
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
                $('form[id*="frmQ"]')[0].reset();
                $('#qNum').val('');$('#qId').val('0');
                $('#simQid').val('0'); 
                $('#imgQEntry').attr("src","uploadedImages/0.jpg");
                $('#imgId').val('0');
            }
    

            function qPreview1(qId){
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
            
            function qPreview(qId){
                //alert('Question Id is: '+qId);
                fetchQuestionDetails(qId);
    
                $('#divPopContainer').css("display","table"); 
                //$('#divPopContainer').show();
                coverScreenGray();               
                //MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
               //alert($('#previewQText').text());
               setTimeout(function(){MathJax.Hub.Queue(["Typeset",MathJax.Hub,"divQBPreview"]); },300);
               
                               
            }

            function fetchQuestionDetails(qId){
                $.get("QFetcher?id="+qId,function(data,status){
                    if(status==="success"){
                        previewQJson = eval(data);
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
                    $('#previewExplanation').text("Explanation :"+previewQJson.explanation);
                    $('#previewTags').text(previewQJson.tags);
                    $('#previewHelp').text(previewQJson.helpLink);
                    $('#previewQImg').attr("src", "/g2l/uploadedImages/"+previewQJson.figName);
                    }            
                    else{alert("FAIL");}
                });
            }
            
            function updateQData(){
                var valRadio, imgId=0;
                if($('#qId').val()=='0'){alert($('#qId').val()+': Save the question first.'); return false;}
                if(!validateDataEntry()){  return false;}
                valRadio = $("input[name='corr']:checked").val();    console.log("Selected Answer: "+valRadio);  
                if($('#imgSel').attr("checked")==true){imgId =$('#imgId').val(); }
                $.post("QuestionEntry?act=save",
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
                function(data,status){
                    if(data!="FAIL"){qEntryMsg="Question updated successfully.";}
                    else {qEntryMsg="Failure in question updation.";}
                    $('#qEntryMsg').show();
                    $('#qEntryMsg').text(qEntryMsg);
                    setTimeout(function(){
                        $('#qEntryMsg').hide();
                    }, 10000);
                    
                    // showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,true,true ); 
                });
                return true;
            }
            
            //Validate the data enetered for a question
            function validateDataEntry(){
                var isDataValid=true;
                qEntryMsg ='Data validation: '
       
                $(':input').css("background-color",""); //alert('Step1');//Change background color to original  
                
                if($('#subSelect').val()==''){ 
                    $('#subAreas').css("background-color","#FCBDBD");
                    isDataValid=false;
                    qEntryMsg += 'Subject Area not selected; ';
                }
                //Highlight Empty text boxes which must not be. 
                if($('#question').val()==''){ 
                    $('#question').css("background-color","#FCBDBD");
                    isDataValid=false;
                    qEntryMsg += 'Question text not provided; ';
                }    
                // Make sure answers are not empty.
                //if($('#checkMC').attr("checked")==true){    
                $(":text[id^='ans']").each(function(){
                    if($(this).val()==''){
                        $(this).css("background-color","#FCBDBD");
                        isDataValid=false;
                        qEntryMsg += $(this).get(0).id + ' is empty; ';
                    }
                });
                //Check if for duplicate correct Answers.
                var valRadio = $(":radio[name='corr']:checked").val(); //alert('Step122');
                var selVal = $('#ans'+valRadio).val();
                if($(':text[value="'+selVal+'"]').length > 1){ 
                    $(':text[value="'+selVal+'"]').css("background-color","#FCBDBD");
                    isDataValid=false;
                    qEntryMsg += 'Duplicate correct answers provided; ';
                }    
                // }

   
                $('#qEntryMsg').show();
                $('#qEntryMsg').text(qEntryMsg);
                setTimeout(function(){
                    $('#qEntryMsg').hide();
                }, 10000);
    
                return isDataValid;
            }

            //Save a newly entered question
            function saveNewQuestion(){
                var subS = $('#subSelect').val();
                if(validateDataEntry()){ //alert('He Ho: Data is Good.');
                    var valRadio, imgId=0;
                    // var checkMC = $('#checkMC').val();if($('#checkMC').attr("checked")==true){ subS = subS+'1'; alRadio = $("input[name='corr']:checked").val();}
                    // else{           subS = subS+'0';            valRadio='E';        }
        
                    if($('#imgSel').attr("checked")==true){imgId =$('#imgId').val(); }
                    subS = subS+'1'; //Multiple Choice Question
                    valRadio = $("input[name='corr']:checked").val();
                    $('#qId').val('0');
                    $('#qNum').val('');
            
                    $.post("QuestionEntry?act=save", {
                        qId:$('#qId').val(),   
                        question: $('#question').val(), 
                        ansA: $('#ansA').val(),
                        ansB : $('#ansB').val(),
                        ansC :$('#ansC').val(),        
                        ansD : $('#ansD').val(),
                        ansE: $('#ansE').val(),
                        subSelect: subS,       
                        source: $('#qSource').val(),
                        correct: valRadio,
                        helpLink:$('#helpLink').val(),
                        explanation:$('#explanation').val(),
                        tags: $('#tags').val(),
                        figId:imgId, 
                        simQid: $('#simQid').val()
                    },
                    function(data,status){
                        console.log(data);
                        if(status=="error"){ 
                            $('#qEntryMsg').show();
                            $('#qEntryMsg').text("Failure in saving data.");
                            setTimeout(function(){
                                $('#qEntryMsg').hide();
                            }, 10000);
                        }
                        if (status=="success"){
                    
                            if(data=="FAIL"){
                                $('#qEntryMsg').show();
                                $('#qEntryMsg').text("Failure in saving data.");
                                setTimeout(function(){
                                    $('#qEntryMsg').hide();
                                }, 10000); 
                            }else{
                                $('#qEntryMsg').show();
                                $('#qEntryMsg').text("Question saved successfully. ");
                                setTimeout(function(){
                                    $('#qEntryMsg').hide();
                                }, 10000);
                    
                                $('#qEntered').append('<span id="q'+data+'" class="qNum" onclick="qPreview('+data+')">'+data+'</span>');
                                
                                $("span[class|='qNum']").css("background-color","green"); 
                                $("span[id|='q"+data+"']").css("background-color","#E3E3DE");
                                $('#qId').val(data);
                                if($('#simQid').val()=='0'){
                                    $('#simQid').val(data);
                                }
                                $('label[for="question"]').text('Question (id:'+data+')');
                            }  
                        }
                    });
                }
            }
            
            function useImage(figId,figName){
                $('#imgQEntry').attr("src","uploadedImages/"+figName); 
                $('#imgId').val(figId);
                $('#imgSel').attr('disabled','');
                $('#imgSel').attr('checked','checked');
                $("#popDivImgUpload5").hide();                
                coverScreenGray();
            }
            
            function useNewImage(){
                $('#imgQEntry').attr("src",$("#imgUpdate").attr("src")); 
                $('#imgId').val($('#figId').val());
                $('#imgSel').attr('disabled','');
                $('#imgSel').attr('checked','checked');      
                $("#popDivImgUpload6").hide();
                coverScreenGray();
            }
            
            function uploadImage1(){
                //alert('step1');   
                if($('#fileName').attr('disabled')){updateImageData(); return;}
                var formData = new FormData($('form')[0]);
                
                $.ajax({
                    url: 'FigureUploader',  //server script to process data
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    dataType:'json',
                    success: function(data) { jsonFigure = eval(data);
                        if(jsonFigure.figUpload=="SAVED"){                            
                            //$('#imgUpdate').attr("src","uploadedImages/"+jsonFigure.figName); 
                            $('#figId').val(jsonFigure.figId);
                            $('#figId').parent().next().text(jsonFigure.figId); 
                            $('#message').show();
                            $('#message').html("Message: Image Uploaded Successfully.");
                            setTimeout(function(){
                                document.getElementById("imgUpdate").src="uploadedImages/"+jsonFigure.figName+"?"+ new Date().getTime();}, 2000);
                            
                        }else{
                            $('#message').show();
                            $('#message').html(jsonFigure.message);
                        }                        
                    },
                    error: function(jqXHR, textStatus, errorMessage) {
                        console.log(errorMessage); // Optional
                    }
                });
            }