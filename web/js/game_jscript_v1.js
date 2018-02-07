var req;
var isIE;
var completeField;
var completeTable;
var autoRow;
var eleStatus;

var qDB = new Array();
var qObj={};

function init() { 
   // eleStatus = document.getElementById('message');
    $( "#qListAccordion" ).accordion({ disabled: true});
    
    // changestart: function(event, ui) {$("#message").text(ui.newHeader.find("a").text() was activated, " + ui.oldHeader.find("a").text()+
               // " was closed").fadeOut(5000, function(){ $(this).remove(); });}
               // 
   // completeField = document.getElementById("b2");MathJax.Hub.Queue([\'Typeset\',MathJax.Hub,\'nofQ'+nofQ+'\']);
   // completeTable = document.getElementById("complete-table");
  //  autoRow = document.getElementById("div1");
   // completeTable.style.top = getElementY(autoRow) + "px";
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


function saveNewQuestion(){
    var valRadio = $("input[@name=corr]:checked").val();
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
        subSelect: $('#subSelect').val(),       
        correct: valRadio,
        helpLink:$('#helpLink').val(),
        tags: $('#tags').val()
        },
    function(data,status){ //eleStatus.innerHTML += '<br>Post Status:'+status+';&nbsp;';      
   var qIndex =  saveQuestion(data,$('#qNum').val());
   $('#qNum').val(qIndex);
    $('#qId').val(qDB[qIndex-1].id);
    $('#updateQ').attr('disabled','false');document.getElementById('updateQ').disabled=false;
       showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,true,true ); 
   //eleStatus.innerHTML += 'Question Index'+qIndex+';&nbsp;'; 
  // $( "#qListAccordion" ).accordion("option", "disabled", true);
   $("#qListAccordion").accordion( "destroy" )
    showQTbl(qIndex);  $( "#qListAccordion" ).accordion({ disabled: false });$("#qListAccordion").accordion();   
    //$("#qListAccordion").accordion();    $( "#qListAccordion" ).accordion("option", "disabled", false);
  });
}

function updateQuestion(){
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
                tags: $('#tags').val()
            },
    function(data,status){ //eleStatus.innerHTML += '<br>Post Status:'+status+';&nbsp;';         
   var qIndex =  saveQuestion(data,$('#qNum').val());
    showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,true,true ); 
   $('#qNum').val(qIndex);
    $('#qId').val(qDB[qIndex-1].id);
 
   //eleStatus.innerHTML += 'Question Index'+qIndex+';&nbsp;'; 
   $("#qListAccordion").accordion( "destroy" )
    showQTbl(qIndex);   $("#qListAccordion").accordion();
    $( "#qListAccordion" ).accordion({ disabled: false });$("#qListAccordion").accordion();  
  });
}
function saveNewQuestionV2(){//Discarded
         var qStr = "question="+$('#question').val()+
        "&ansA="+$('#ansA').val()+"&ansB="+$('#ansB').val()+"&ansC="+$('#ansC').val()+
        "&ansD="+$('#ansD').val()+"&ansE="+$('#ansE').val()+"&subSelect="+$('#subSelect').val()+
        "&correct="+$('#correct').val()+"&helpLink="+$('#helpLink').val()+"&tags="+$('#tags').val();
    //alert(qStr);
    $.get("QuestionEntry?"+qStr,function(data,status){
    //alert("Data: " + data + "\nStatus: " + status);
    alert('Question Number: '+document.getElementById('qNum').value);
   var qIndex =  saveQuestion(data,$('#qNum').val());$('#qNum').val(qIndex);alert('Question Index'+qIndex);
    showQTbl(qIndex);
  });
}

function showQTblV1(qIndex) {
    if(qIndex<0){alert('Something is Wrong. Please check.'); return false;}
   // alert('In Append Question:');
             completeTable.setAttribute("bordercolor", "black");
             completeTable.setAttribute("border", "0");
    var nofQ = qDB.length; qObj = qDB[qIndex-1];        
    var qId = qObj.id.valueOf();
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
    
    var row;
    var cell;
    var cell2;
    
     var strHTML = '<div id="flip" class="flip"  onclick="$(\'#nofQ'+nofQ+'\').slideToggle(\'slow\');MathJax.Hub.Queue([\'Typeset\',MathJax.Hub,\'nofQ'+nofQ+'\']);" >'+  
        '[<a class="a1" id="editLink" onclick="editQuestion('+nofQ+');">Edit</a>] Questions &nbsp;&nbsp;'+nofQ+'</div>'+
              '<div id="nofQ'+nofQ+'" class="panel">'+qText+'<hr>(A)&nbsp;'+ans1+', <br>(B)&nbsp; '+ans2+',  <br>(C)&nbsp; '+ans3+',  <br>(D)&nbsp; '+ans4+',  <br>(E)&nbsp; '+ans5+'</div>';

   
   var numofQRows =completeTable.getElementsByTagName('tr').length;
   var qDiv = document.getElementById('nofQ'+qIndex);
  
  if(qDiv==null) {
        if (isIE) {
            completeTable.style.display = 'block';
            row = completeTable.insertRow(completeTable.rows.length);
            cell = row.insertCell(0);
            cell2 = row.insertCell(1);
        } else {
            autoRow.style.visibility ='visible';
            completeTable.style.display = 'table';
            row = document.createElement("tr");
            cell = document.createElement("td");
            cell2 = document.createElement("td"); 
            row.appendChild(cell);row.appendChild(cell2);            
            completeTable.appendChild(row);
           // alert('QID = '+qId);
          }
         cell.innerHTML = strHTML;
         cell2.innerHTML = '<a class="a1" id="editLink" onclick="editQuestion('+nofQ+');">Edit</a>'
         cell2.style.color ='white';
      }
        else{
            qDiv.innerHTML = qText+'<hr>(A)&nbsp;'+ans1+', <br>(B)&nbsp; '+ans2+',  <br>(C)&nbsp; '+ans3+',  <br>(D)&nbsp; '+ans4+',  <br>(E)&nbsp; '+ans5;
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
    
     var strHTML  = '<h3><a href="#">Question &nbsp;&nbsp;'+nofQ+'</a>'+
         '</h3><div id="nofQ'+nofQ+'" ><p>'+qText+'<hr>(A)&nbsp;'+ans1+' <br>'+
         '(B)&nbsp; '+ans2+'  <br>(C)&nbsp; '+ans3+'  <br>(D)&nbsp; '+ans4+'  <br>(E)&nbsp; '+ans5+
         '<br><div style="width=100%;text-align:center;"><input type="button" value="Edit Question" id="editQ" onclick="editQuestion('+nofQ+');"></input></p></div>'; 

   
  // var numofQRows =eleQListAcco.getElementsByTagName('h3').length;
   var strAccoInnerHTML = eleQListAcco.innerHTML;
   var qDiv = document.getElementById('nofQ'+qIndex);
  
  if(qDiv==null) {      eleQListAcco.innerHTML = strAccoInnerHTML + strHTML; //alert(eleQListAcco.innerHTML);
  }
        else{ qDiv.innerHTML = '<p>'+qText+'<hr>(A)&nbsp;'+ans1+', <br>(B)&nbsp; '+ans2+',  <br>(C)&nbsp; '+ans3+
                ',  <br>(D)&nbsp; '+ans4+',  <br>(E)&nbsp; '+ans5+'<br><input type="button" value="Edit Question" id="editLink" onclick="editQuestion('+nofQ+');"></input></p>';
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

function saveQuestionV1(responseXML,qIndex) { //returns the index of the question.
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
               
                 if(qIndex==''){ qDB[qDB.length] = qObj; qNum = qDB.length; eleStatus.innerHTML += 'Entering, question id: '+qObj.id+'; &nbsp;';}
                    else {qNum = Number(qIndex); qDB[qNum-1]=qObj; eleStatus.innerHTML += 'Updating, questions id: '+qObj.id+'; &nbsp;';}
                  

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
 
function loadComboBoxes(xmlFileName){
               $.ajax({
                        type: "GET",
                        url: xmlFileName,
                        dataType: "xml",
                        success: function(xml) {
                            var curOption, itemName, itemId,  eleMainBox=$('#subjects'),  menuName = 'subject';
                            $(xml).find(menuName).each(function(){
                                    itemName = $(this).find('sub_name').text();  itemId = $(this).find('sub_id').text();
                                    curOption=$('<option value="'+ itemId + '">' + itemName + '</option>');
                                    curOption.data(menuName,$(this)); // bind the country node data from the XML to the option of the dropdown
                                    curOption.appendTo(eleMainBox);
                                    });  curOption=null;; eleMainBox=$('#level'); menuName = 'grade';
                            $(xml).find(menuName).each(function(){
                                   itemName = $(this).text(); itemId = $(this).attr('id');
                                   curOption=$('<option value="'+ itemId + '">' + itemName + '</option>');                                 
                                   curOption.appendTo(eleMainBox);
                                    });  curOption=null;  eleMainBox=$('#diff');  menuName = 'diff_level';
                            $(xml).find(menuName).each(function(){
                                   itemName = $(this).text(); itemId = $(this).attr('id');
                                   curOption=$('<option value="'+ itemId + '">' + itemName + '</option>');                                 
                                   curOption.appendTo(eleMainBox);
                                    });
                        }
                        
                });
       }              
  
function setSubArea(eleSubMenuBox,subMenuName){
	var curSubject = $('#subjects').children(':selected').data('subject');
       // alert($(curSubject).text());
       eleSubMenuBox.removeAttr('disabled');
    
	eleSubMenuBox.html(""); // reset the languages list
	var curSubArea = $(curSubject).find(subMenuName);
	if (curSubArea.length>1){
		curSubArea.each(function(i){
			var subArea = $(this);
			var subAreaId=$(subArea).find('sub_area_id');
                        var subAreaName=$(subArea).find('sub_area_name');
			if (i==0){
				curOption="<option value='null'>Subject Area</option><option value='" + subAreaId.text() + "'>" + subAreaName.text() + "</option>";
			}else{
				curOption += "<option value='" + subAreaId.text() + "'>" + subAreaName.text() + "</option>";
			}
                       
		});
		$(curOption).appendTo(eleSubMenuBox);
		$(eleSubMenuBox).show()
	}else if (curSubject==null){ eleSubMenuBox.hide();}
                 else{eleSubMenuBox.hide();}
}


function doSomething()
{       
        var strSub = $("#subjects option:selected").val()+$("#subAreas option:selected").val()+$("#level option:selected").val()+$("#diff option:selected").val();
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

