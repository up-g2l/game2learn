var req;
var isIE;
var completeField;
var eleQTbl;
var autoRow;

function init() { 
    completeField = document.getElementById("mvPieceImg");
    eleQTbl = document.getElementById("qTbl");
    autoRow = document.getElementById("qDiv");
    eleQTbl.style.top = getElementY(autoRow) + "px";
}

function showQBox() {
    
    if(completeField==null){ init();} var randQ = Math.floor(Math.random()*30)+1;alert('Question RandNum = '+randQ);
    var url = "QFetcher?action=complete&id="+randQ;// + escape(completeField.value);    
    req = initRequest();//alert('initRequest Success: url is '+url);
    req.open("GET", url, true);//alert('open called success');
    req.onreadystatechange = callback;
    req.send(null);
}



function callback() {//alert('In CallBack. ReadyState:'+req.readyState);
    clearTable();

    if (req.readyState == 4) {
        if (req.status == 200) {
            parseQMessages(req.responseXML);
        }
    }
}


function parseQMessages(responseXML) {
    //alert('in ParseMessage. XML Response is:');
    // no matches returned
    if (responseXML == null) {
         alert('in ParseMessage. XML Response is NULL:'); return false;
    } else {

        var questions = responseXML.getElementsByTagName("questions")[0];

        if (questions.childNodes.length > 0) {
            eleQTbl.setAttribute("bordercolor", "black");
            eleQTbl.setAttribute("border", "0");
    
            for (loop = 0; loop < questions.childNodes.length; loop++) {
                var question = questions.childNodes[loop];
                var qText = question.getElementsByTagName("qText")[0];
                var ans1 = question.getElementsByTagName("ans1")[0];
                  var ans2 = question.getElementsByTagName("ans2")[0];
                    var ans3 = question.getElementsByTagName("ans3")[0];
                      var ans4 = question.getElementsByTagName("ans4")[0];
                          var correct = question.getElementsByTagName("correct")[0];
                          
                qObj.text = qText;qObj.ans1 = ans1;qObj.ans2 = ans2;qObj.ans3 = ans3;qObj.ans4 = ans4;qObj.correct = correct;
                qDB[qDB.length+1] = qObj;
                appendQuestion(qText.childNodes[0].nodeValue,
                    ans1.childNodes[0].nodeValue,ans2.childNodes[0].nodeValue,ans3.childNodes[0].nodeValue,
                    ans4.childNodes[0].nodeValue, correct.childNodes[0].nodeValue);
            }
        }
    }   
}

function parseMessages2(responseXML) {
    //alert('in ParseMessage. XML Response is:');
    // no matches returned
    if (responseXML == null) {
        // alert('in ParseMessage. XML Response is NULL:'); 
         return false;
    } else {

        var questions = responseXML.getElementsByTagName("questions")[0];

        if (questions.childNodes.length > 0) {
            eleQTbl.setAttribute("bordercolor", "black");
            eleQTbl.setAttribute("border", "0");
    
            for (loop = 0; loop < questions.childNodes.length; loop++) {
                var question = questions.childNodes[loop];
                var qId = question.getElementsByTagName("qId")[0];
                var qText = question.getElementsByTagName("qText")[0];
                var ans1 = question.getElementsByTagName("ans1")[0];
                  var ans2 = question.getElementsByTagName("ans2")[0];
                    var ans3 = question.getElementsByTagName("ans3")[0];
                      var ans4 = question.getElementsByTagName("ans4")[0];
                          var correct = question.getElementsByTagName("correct")[0];
                appendQuestion2(qId.childNodes[0].nodeValue, qText.childNodes[0].nodeValue,
                    ans1.childNodes[0].nodeValue,ans2.childNodes[0].nodeValue,ans3.childNodes[0].nodeValue,
                    ans4.childNodes[0].nodeValue, correct.childNodes[0].nodeValue);
            }
        }
    }   
}


function appendQuestion(qText,ans1,ans2, ans3, ans4, correct) {
   // alert('In Append Question:');

    var row;
    var cell;
    var linkElement;
    
    if (isIE) {
        eleQTbl.style.display = 'block';
        row = eleQTbl.insertRow(eleQTbl.rows.length);
        cell = row.insertCell(0);
    } else {
        autoRow.style.visibility ='visible';
        eleQTbl.style.display = 'table';
        row = document.createElement("tr");
        cell = document.createElement("td");
        row.appendChild(cell);
        eleQTbl.appendChild(row);
    }

    cell.className = "popupCell";
            qData2 = qText+'<hr><form><input type="hidden"  id="ansCorr" action="#nogo" value="'+correct+'"></input>'+
                 '<input type="radio" name="ansChoice" value="A"> (A)'+ans1+'</input><br> <input type="radio" name="ansChoice"  value="B"> (B)'+ans2+'</input>'+
                 '<br><input type="radio" name="ansChoice"  value="C">(C) '+ans3+'</input><br><input type="radio" name="ansChoice"  value="D">(D) '+ans4+'</input>'+
                 '<br><input type="submit" onclick=" submitAnswer(this.parentNode); return false;"></form>';

     // qData = qText + "<hr> (A)" + ans1 + "<br> (B)" + ans2 + "<br> (C)" + ans3 + "<br> (D)" + ans4+ "<br> Correct:"+correct;
   // linkElement = document.createElement("a");
  //  linkElement.className = "popupItem";
   // linkElement.setAttribute("href", "QFetcher?action=lookup&id=1" );
   // linkElement.appendChild(document.createTextNode(qText + " (A)" + ans1 + " (B)" + ans2 + " (C)" + ans3 + " (D)" + ans4+ " Correct:"+correct));
   // cell.appendChild(linkElement);
    cell.innerHTML = qData2;
}
function submitAnswer(formEle){//'Answer Submitted:'+formEle.getElementByName('ansChoice').value+
    
    alert(', CorrectAnswer is:'+formEle.childNodes[0].value); 
    var selected = $('input[name=ansChoice]:checked').val();alert('Submitted Answer'+selected);
    
    if(formEle.childNodes[0].value == selected){ clearTable() ;   resetDice();}
     var strHTML = '<img id = "mvPieceImg" onclick="showQBox()" src="./images/blue3D.jpeg" width="50px"/>'+strQBox;
     eleGameCells[mapCells[currentCell]].innerHTML = strHTML;
   // alert(\'Correct Answer is:\'+this.parentNode.childNodes[0].value); alert(\'Number of questions is:'+qDB.length+'\');resetDice(); 
}

function appendQuestion2(qId, qText,ans1,ans2, ans3, ans4, correct) {
   // alert('In Append Question:');

    var row;
    var cell;
    var linkElement;
    
    if (isIE) {
        eleQTbl.style.display = 'block';
        row = eleQTbl.insertRow(eleQTbl.rows.length);
        cell = row.insertCell(0);
    } else {
        autoRow.style.visibility ='visible';
        eleQTbl.style.display = 'table';
        row = document.createElement("tr");
        cell = document.createElement("td");
        row.appendChild(cell);
        eleQTbl.appendChild(row);
        alert('QID = '+qId);
    }

    cell.className = "popupCell";
    
    qData2 = '<div id="flip" class="flip"  onclick="$(\'#'+qId+'Data\').slideToggle(\'slow\');" > '+qText+'</div>'+
              '<div id="'+qId+'Data" class="panel"> <a class="a1">Edit</a> (A), (B), (C), (D), (E) </div>';
          //  qData2 = '<form><input type="hidden"  id="ansCorr" action="#nogo" value="'+correct+'"></input>'+
           //      '<input type="hidden" name="ansChoice" value="'+ans1+'"></input> <input type="hidden" name="ansChoice"  value="'+ans2+'"></input>'+
           //      '<input type="hidden" name="ansChoice"  value="'+ans3+'"></input><input type="hidden" name="ansChoice"  value="'+ans4+'"></input>'+
            //     '<input type="hidden" value="Edit" onclick="alert(\'Correct Answer is:\'+this.parentNode.childNodes[0].value);  return false;">'+
             //    '</input></form>'+qText;

     // qData = qText + "<hr> (A)" + ans1 + "<br> (B)" + ans2 + "<br> (C)" + ans3 + "<br> (D)" + ans4+ "<br> Correct:"+correct;
   // linkElement = document.createElement("a");
  //  linkElement.className = "popupItem";
   // linkElement.setAttribute("href", "QFetcher?action=lookup&id=1" );
   // linkElement.appendChild(document.createTextNode(qText + " (A)" + ans1 + " (B)" + ans2 + " (C)" + ans3 + " (D)" + ans4+ " Correct:"+correct));
   // cell.appendChild(linkElement);
   alert(qData2);
    cell.innerHTML = qData2;
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
    return true;
}


function clearTable() {
    if (eleQTbl.getElementsByTagName("tr").length > 0) {
        eleQTbl.style.display = 'none';
        for (loop = eleQTbl.childNodes.length -1; loop >= 0 ; loop--) {
            eleQTbl.removeChild(eleQTbl.childNodes[loop]);
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
