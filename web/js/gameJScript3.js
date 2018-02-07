var req;
var isIE;
var completeField;
var completeTable;
var autoRow;
var eleStatus;

var qDB = new Array();
var qObj={};
 

function init() { 
initAccordion();

   // eleStatus = document.getElementById('message');

    
    // changestart: function(event, ui) {$("#message").text(ui.newHeader.find("a").text() was activated, " + ui.oldHeader.find("a").text()+
               // " was closed").fadeOut(5000, function(){ $(this).remove(); });}
               // 
   // completeField = document.getElementById("b2");MathJax.Hub.Queue([\'Typeset\',MathJax.Hub,\'nofQ'+nofQ+'\']);
   // completeTable = document.getElementById("complete-table");
  //  autoRow = document.getElementById("div1");
   // completeTable.style.top = getElementY(autoRow) + "px";
}

function initAccordion(){
     var iconChoice= {
      "header": "ui-icon-circle-arrow-e",
      "headerSelected": "ui-icon-circle-arrow-s"
    };
        $( "#qListAccordion" ).accordion({ 
                                      disabled: false,  
                                      heightStyle: "content" , 
                                      icons:iconChoice,
                                      collapsible:true
                                     
                                  });
}
function setActiveAcco(qIndex){
     // getter var active = $( ".selector" ).accordion( "option", "active" );
 
        // setter
        $("#qListAccordion").accordion( "option", "active", qIndex );
}

function validateDataEntry(){
    var isDataValid=true;
    var qText = $('#question').val();
    //Change background color to original
              $(':input').css("background-color",""); //alert('Step1');
   //Highlight Empty text boxes which must not be.         
    if($('#subSelect').val()==''){ $('#subAreas').css("background-color","#FCBDBD"); isDataValid=false;}
    if($('#question').val()==''){ $('#question').css("background-color","#FCBDBD"); isDataValid=false;}    
   /* if($(":text[id^='ans'][value]").length > 0){ 
        $(":text[id^='ans'][value]").css("background-color","#FCBDBD"); isDataValid=false;}*/

    //alert('Step12');
    
    if($('#checkMC').attr("checked")==true){    $(":text[id^='ans']").each(function(){
                                            if($(this).val()==''){ $(this).css("background-color","#FCBDBD"); isDataValid=false;}
                                              });
                   //Check if for duplicate correct Answers.
                   var valRadio = $(":radio[name='corr']:checked").val(); //alert('Step122');
                   var selVal = $('#ans'+valRadio).val();
                   if($(':text[value="'+selVal+'"]').length > 1){ $(':text[value="'+selVal+'"]').css("background-color","#FCBDBD");  isDataValid=false;}    
                         }

  

    //Avoid special characters.
    /*
    if(Number(qText.indexOf('&')) > -1){showAllMessages("Replacing occurances of '&' by '&amp;'.");qText = qText.replaceAll('&', '&amp;');}            
    if(Number(qText.indexOf('<')) > -1){showAllMessages('Replacing  occurances of "<" by "\le".');qText = qText.replaceAll('<', '\\le');}            
    if(Number(qText.indexOf('>')) > -1){showAllMessages('Replacing  occurances of ">" by "\ge".'); qText = qText.replaceAll('>', '\\ge'); }
    $('#question').val(qText); */
    
    if(!isDataValid){ alert('Please make corrections suggested in the message box and in the input boxes.');  }
    return isDataValid;
}

function saveNewQuestion(){
    var subS = $('#subSelect').val();
    if(!validateDataEntry()){return false;} 
       else{ //alert('He Ho: Data is Good.');
            var valRadio;
            var checkMC = $('#checkMC').val();
            if($('#checkMC').attr("checked")==true) { subS = subS+'1'; valRadio = $("input[name='corr']:checked").val();}
               else{  subS = subS+'0'; valRadio='E';}
            $('#qId').val('0');
            $('#qNum').val('');
            
            $.post("QuestionEntry",
            {   qId:$('#qId').val(),
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
                tags: $('#tags').val()},
                function(data,status){  //alert('Question Saved at index: '+qIndex);
                    var qIndex =  saveQuestion(data,$('#qNum').val());
                    $('label[for="question"]').text('Question #'+qIndex+' (id:'+qDB[qIndex-1].id+')');
                     $('#qNum').val(qIndex);$('#qId').val(qDB[qIndex-1].id);
                     $('#updateQ').attr('disabled',false);
                        showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,false,true ); 
                
                   // $( "#qListAccordion" ).accordion("option", "disabled", true);
                    $("#qListAccordion").accordion( "destroy" )
                     showQTbl(qIndex);  
                     initAccordion(); $( "#qListAccordion" ).accordion("refresh");setActiveAcco(qIndex);
                   //  $("#qListAccordion").accordion();   
                     //$("#qListAccordion").accordion();    $( "#qListAccordion" ).accordion("option", "disabled", false);
             });
    }
}

function updateQuestion(){
    if(!validateDataEntry()){return false;}
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
                 tags: $('#tags').val()},
                function(data,status){ //eleStatus.innerHTML += '<br>Post Status:'+status+';&nbsp;';         
                    var qIndex =  saveQuestion(data,$('#qNum').val());
                        $('label[for="question"]').text('Question #'+qIndex+' (id:'+qDB[qIndex-1].id+')');
                          showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,true,true ); 
                     $('#qNum').val(qIndex);
                     $('#qId').val(qDB[qIndex-1].id);

                   
                       $("#qListAccordion").accordion( "destroy" )
                     showQTbl(qIndex); 
                      initAccordion(); $( "#qListAccordion" ).accordion("refresh");setActiveAcco(qIndex);
                       // $( "#qListAccordion" ).accordion({ disabled: false });$("#qListAccordion").accordion();  
           });
     }
}


function showQTbl(qIndex) {
    if(qIndex<0){alert('Something is Wrong. Please check.'); return false;}
   // alert('In Append Question:');
            
    var eleQListAcco = document.getElementById('qListAccordion');// completeTable.setAttribute("bordercolor", "black");    completeTable.setAttribute("border", "0");
    var nofQ = qDB.length; qObj = qDB[qIndex-1];        
    var qId = qObj.id;
    var qText= qObj.text;
    var ans1= qObj.ansA;
    var ans2= qObj.ansB;
    var ans3= qObj.ansC;
    var ans4= qObj.ansD;
    var ans5= qObj.ansE;
    var correct= qObj.correct;
    var helpLink = qObj.helpLink;
    var tags  = qObj.tags;
    var explanation =qObj.explanation;
    //
    
     var strHTML  = '<h6><a href="#">Question &nbsp;&nbsp;'+nofQ+' (id: '+qId+')</a>'+
         '</h6><div class="accoContent" id="nofQ'+nofQ+'" ><p><table ><tr><td>'+qText+'<hr>(A)&nbsp;'+ans1+' <br>'+
         '(B)&nbsp; '+ans2+'  <br>(C)&nbsp; '+ans3+'  <br>(D)&nbsp; '+ans4+'  <br>(E)&nbsp; '+ans5+
         '</td><td><br><div style="text-align:center;"><input type="button" value="Edit" id="editQ" onclick="editQuestion('+nofQ+');"></input></div></td></tr></table></p></div>'; 

   
  // var numofQRows =eleQListAcco.getElementsByTagName('h3').length;
   var strAccoInnerHTML = eleQListAcco.innerHTML;
   var qDiv = document.getElementById('nofQ'+qIndex);
  
  if(qDiv==null) { eleQListAcco.innerHTML = strAccoInnerHTML + strHTML; }
        else{ qDiv.innerHTML = '<p ><table><tr><td width="80%">'+qText+'<hr>(A)&nbsp; '+ans1+', <br>(B)&nbsp; '+ans2+',  <br>(C)&nbsp; '+ans3+
                ', <br>(D)&nbsp; '+ans4+',  </td><td><br>(E)&nbsp; '+ans5+'</div><br><div style="text-align:center;">'+
                '<input type="button" value="Edit" id="editQ" onclick="editQuestion('+nofQ+');"></div></input></td></tr></table></p>';
          }
           MathJax.Hub.Queue(['Typeset',MathJax.Hub,'qListAccordion']);
}

function saveQuestion(responseXML,qIndex) { //returns the index of the question.
    var qNum = 0;
    qObj = {};
    if (responseXML == null) {  alert('in ParseMessage. XML Response is NULL:'); 
         return qNum-1;
    } else {

            var questions = responseXML.getElementsByTagName("questions")[0];

            if (questions.childNodes.length > 0) {
    
            for (loop = 0; loop < questions.childNodes.length; loop++) {
                var question = questions.childNodes[loop];
                var qId = question.getElementsByTagName("qId")[0];
                var qText = question.getElementsByTagName("qText")[0]; //qText = qText.replace('@', '&');
                var ans1 = question.getElementsByTagName("ans1")[0];
                var ans2 = question.getElementsByTagName("ans2")[0];
                var ans3 = question.getElementsByTagName("ans3")[0];
                var ans4 = question.getElementsByTagName("ans4")[0];
                var ans5 = question.getElementsByTagName("ans5")[0];
                var correct = question.getElementsByTagName("correct")[0];        
                  
                qObj.id =qId.childNodes[0].nodeValue;
                qObj.text = qText.childNodes[0].nodeValue;  qObj.text  =   qObj.text.replaceAll('***', '&');  
                qObj.ansA = ans1.childNodes[0].nodeValue;
                qObj.ansB = ans2.childNodes[0].nodeValue;
                qObj.ansC = ans3.childNodes[0].nodeValue;
                qObj.ansD = ans4.childNodes[0].nodeValue;
                qObj.ansE = ans5.childNodes[0].nodeValue; 
                qObj.crct = correct.childNodes[0].nodeValue;  
                qObj.helpLink='';qObj.tags=''; qObj.explanation='';
               
                 if(qIndex==''){ qDB[qDB.length] = qObj; qNum = qDB.length;
                       showAllMessages('Entering, question id: '+qObj.id+'. &nbsp;'); 
                 } //eleStatus.innerHTML += 'Entering, question id: '+qObj.id+'; &nbsp;';}
                    else {qNum = Number(qIndex); qDB[qNum-1]=qObj;
                      showAllMessages('Updating, question id: '+qObj.id+'. &nbsp;'); } //eleStatus.innerHTML += 'Updating, questions id: '+qObj.id+'; &nbsp;';}
                  

            }
        }
    } 
    return qNum;
}


String.prototype.replaceAll = function(search, replace)
{
    //if replace is null, return original string otherwise it will
    //replace search string with 'undefined'.
    if(!replace) 
        return this;

    return this.replace(new RegExp('[' + search + ']', 'g'), replace);
}

function editQuestion(qNum){
    //alert('Are you sure to edit Question Number: '+qNum);  
   // var eleBtnUpdate = document.getElementById("updateQ");
   // eleBtnUpdate.disabled=false;
    var qObj = qDB[qNum-1];
    
    //alert('The ID of the question is: '+qObj.id);
   
    $('#qId').val(qObj.id);
    $('#qNum').val(qNum);
    $('#question').val(qObj.text);
    $('#ansA').val(qObj.ansA);
    $('#ansB').val(qObj.ansB);
    $('#ansC').val(qObj.ansC);
    $('#ansD').val(qObj.ansD);
    $('#ansE').val(qObj.ansE);var idRad = '#rad'+qObj.crct;
    $(idRad).attr("checked","checked");  
    $('label[for="question"]').text('Question #'+qNum+' (id:'+qObj.id+')');
    //$('#saveQ').attr("disabled",true);
}

function clearTable() {
    if (completeTable.getElementsByTagName("tr").length > 0) {
        completeTable.style.display = 'none';
        for (loop = completeTable.childNodes.length -1; loop >= 0 ; loop--) {
            completeTable.removeChild(completeTable.childNodes[loop]);
        }
    }
}

function getElementY(element){
    
    var targetTop = 0;
    
    if (element.offsetParent) {
        while (element.offsetParent) {
            targetTop += element.offsetTop;
            element = element.offsetParent;
        }
    } else if (element.y) {
        targetTop += element.y;
    }
    return targetTop;
}

function showInstruction(eleA){
    var instructionDiv =  document.getElementById('instructionBox');
          if(instructionDiv==null) {  
              instructionDiv = document.createElement("div"); 
              instructionDiv.id="instructionBox";
              eleA.appendChild(instructionDiv);
              instructionDiv.style.zIndex='5';
              instructionDiv.innerHTML='(X)Click on this box to close.<h4>Instructions for Entering Questions</h4>'+
                  '<ul><li>Do not use $...$ for inline math; instead use \(...\).</li><li>Use *** in place of &.</li><li>Do not use $.</li><li>Do not use < or >.</li></ul>';
          }else{
              eleA.removeChild(instructionDiv);
          }
 }       
  
function setQType()
{       
        var strSub = $("#subjects option:selected").val()+$("#subAreas option:selected").val()+$("#class_level option:selected").val()+$("#diff option:selected").val();
// alert('Subject:'+strSub);
 $("#subSelect").val(strSub);
}

function doCompletion() { //DISCARDED
    
    if(completeField==null){ init();}
    var url = "QFetcher?action=complete&id=1";// + escape(completeField.value);    
    req = initRequest();//alert('initRequest Success: url is '+url);
    req.open("GET", url, true);//alert('open called success');
    req.onreadystatechange = callback;
    req.send(null);
}
function initRequest() {  
    if (window.XMLHttpRequest) {
        if (navigator.userAgent.indexOf('MSIE') != -1) {
            isIE = true;
        }
        return new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        return new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function callback() {//alert('In CallBack. ReadyState:'+req.readyState);
    clearTable();

    if (req.readyState == 4) {
        if (req.status == 200) {
            parseMessages(req.responseXML);
        }
    }
}
