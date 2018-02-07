/* 
 * This file is integral to the MC Practice.
 */

var jsonArrQ={}; 
var onQNum = 0;//current question
var numCorrect = 0;
var answered = 0;
var score = 0;
  
$(function(){
    $('#divPracIns').show();
    //Load the JSON Question Data
    $.getJSON( "MCPracticeTest?activity=getJSON&"+qString, function( data ) {
        jsonArrQ = eval(data);
        $('#numOfQ').text("Numer of questions: "+jsonArrQ.length);        
        loadQ(0);
        
    });//END Loading JSON
                        
    //Check Mark 
 $("#divPracQBox").flip({
                                    axis: 'x',
                                    trigger: 'click',
                                    front:'mcqDiv',
                                    back:'mcaDiv',
                                    reverse: true
                                  });
                                  
    
    $('#chkMark').change(function(){
        var currQ = jsonArrQ[onQNum];
        if($(this).is(":checked")){
            currQ.checkMarked="1";
        }else{
            currQ.checkMarked="0";
        }        
    });
                
    //RADIO BUTTON CLICK EVENT               
    $('input[type=radio]').change(function(){ 
        var currQ = jsonArrQ[onQNum];
        answered +=1;
        if(currQ.choice==""){
            $(':radio + span').css("border","1px solid #CCCCCC");
            $(this).next().css("border","2px solid green");
            currQ.choice = $(this).val();
            if(currQ.ansCorr !=currQ.choice){
                $(this).next().css("border","2px solid red");
                var radEle = $('input[value="'+currQ.ansCorr+'"]');
                radEle.next().css("border","2px solid green");                              
            }
            else{
                numCorrect +=1;
            }
        }   
        $('#numOfCorr').text("Correct: "+numCorrect+"/"+answered);
        $('input[type=radio]').attr('disabled',true);
    });//END RADIO BUTTON
  
    //Show Instruction
    $('#imgPracIns').click(function(){
        $('#divPracIns').slideToggle('slow');
    });
                 
    //Submit Practice button event        
    $('#imgBtnSubmitPrac').click(function(){
    if(!confirm("Are you sure you want to save this practice data?")){
        return;
    }

    var rightIds='',wrongIds='', qChecked='',qUnChecked='';
    var currQ;
    
    for(var i=0;i<jsonArrQ.length;i++){
        currQ = jsonArrQ[i];
 
        if(currQ.choice!=""){ 
            if(currQ.ansCorr == currQ.choice){
                rightIds +=currQ.qId+";";
            }
            else{
                wrongIds +=currQ.qId+";";
            }
        }
        
        if(currQ.checkMarked=='1'){
            qChecked +=currQ.qId+";";
        }else{
            qUnChecked +=currQ.qId+";";
        }
        
    }
    console.log("Data sent to server = "+qChecked);
    
    var postEle = $.post('MCPracticeTest',{
        activity:'submit',
        right:rightIds,
        wrong:wrongIds,
        checked:qChecked,
        unchecked:qUnChecked
    },                    
    function(data){
        $('#spanSubmitInfo').html('Your practice has been submitted successfully. '+data);
        $('#spanSaveBtn').hide();
        $('#divSubmitInfo').show();
    });                
});//END Submit Practice
    
    $('#aBtnResetAns').click(function(){//Not being used in practice but could be useful in test
        numCorrect -=1;
        $(':radio + span').css("border","1px solid #CCCCCC");
        $('input[type=radio]').attr('checked',false);
        jsonArrQ[onQNum].choice = "";
        $('#numOfCorr').text("Correct: "+numCorrect);
    });
           
});
/**
   * Loads questions in the question box from the json question array.
   * nxt: 0 for remaining on current question, -1 for previous, +1 for next question
   **/
function loadQ(nxt){
    var qIndex=onQNum + nxt;//index of the question to work on.
           
                
    if(qIndex > jsonArrQ.length-1){//If one the last question
        $('#pIns').text("You have reached to the last question.");
        $('#insMessage').show();
        setTimeout(function(){
            $('#insMessage').hide();
        },2000);
        return false;
    }
    if(qIndex < 0){//If one the first question
        $('#pIns').text("You are  on the first question now.");
        $('#insMessage').show();
        setTimeout(function(){
            $('#insMessage').hide();
        },2000);
        return false;
    }
                
    if(jsonArrQ[qIndex].choice==""){//If already answered disable change
        $('input[type=radio]').attr('disabled',false);
    }
    else{
        $('input[type=radio]').attr('disabled',true);
    }
        
    //Populate data from json        
    $('#previewQText').html("Q. "+(qIndex+1)+": "+jsonArrQ[qIndex].qText);
    $('#imgQFig').attr('src','uploadedImages/'+jsonArrQ[qIndex].figName);
    var ansEle = $('#divAnsBox, #flashAnsBox').children('span');
    ansEle.eq(0).text("(A) "+jsonArrQ[qIndex].ansA);
    ansEle.eq(1).text("(B) "+jsonArrQ[qIndex].ansB);
    ansEle.eq(2).text("(C) "+jsonArrQ[qIndex].ansC);
    ansEle.eq(3).text("(D) "+jsonArrQ[qIndex].ansD);
    ansEle.eq(4).text("(E) "+jsonArrQ[qIndex].ansE);//END
    
    $('#flashAnsBox').css('visibility','hidden');//Only for Flash Practice
    
                
    $('input[type=radio]').attr('checked',false).next().css("border","1px solid #CCCCCC");//Default answer box style
    
    
    if(jsonArrQ[qIndex].checkMarked==="1"){
        $('#chkMark').attr("checked","checked");
    }else{
        $('#chkMark').removeAttr("checked");
    }        
    
                
    if(jsonArrQ[qIndex].choice!=""){// Show the option correctly if already answered
        var radEle = $('input[value="'+jsonArrQ[qIndex].ansCorr+'"]');//Correct answer option
        radEle.next().css("border","2px solid green");
        if(jsonArrQ[qIndex].ansCorr !=jsonArrQ[qIndex].choice){ 
            radEle = $('input[value="'+jsonArrQ[qIndex].choice+'"]');
            radEle.next().css("border","2px solid red");
            radEle.attr('checked',true);
        }
        else{
            radEle = $('input[value="'+jsonArrQ[qIndex].choice+'"]');
            radEle.next().css("border","2px solid green");
            radEle.attr('checked',true);
        }
    }
                
    onQNum = qIndex;    //Current Question index changed
                
    MathJax.Hub.Queue(['Typeset',MathJax.Hub,'divPracQBox']);//Typeset the math in the question box.
    return true;
}

function savePractice1(){
    if(!confirm("Are you sure you want to save this practice data?")){
        return;
    }

    var rightIds='',wrongIds='', qCheckMarks='';
    var currQ;
    for(var i=0;i<jsonArrQ.length;i++){
        currQ = jsonArrQ[i];
        qCheckMarks +=currQ.qId+":"+currQ.checkMarked+";"; //CheckMarked Questions
        if(currQ.choice!=""){ 
            if(currQ.ansCorr == currQ.choice){
                rightIds +=currQ.qId+";";
            }
            else{
                wrongIds +=currQ.qId+";";
            }
        }
    }
    var postEle = $.post('MCPracticeTest',{
        activity:'submit',
        right:rightIds,
        wrong:wrongIds,
        checkMarks:qCheckMarks
    },                    
    function(data){
        $('#spanSubmitInfo').html('Your practice has been submitted successfully.');
        $('#spanSaveBtn').hide();
        $('#divSubmitInfo').show();
    });                
}

function savePractice(){
    if(!confirm("Are you sure you want to save this practice data?")){
        return;
    }

    var rightIds='',wrongIds='', qChecked='',qUnChecked='';
    var currQ;
    
    for(var i=0;i<jsonArrQ.length;i++){
        currQ = jsonArrQ[i];
 
        if(currQ.choice!=""){ 
            if(currQ.ansCorr == currQ.choice){
                rightIds +=currQ.qId+";";
            }
            else{
                wrongIds +=currQ.qId+";";
            }
        }
        
        if(currQ.checkMarked=='1'){
            qChecked +=currQ.qId+";";
        }else{
            qUnChecked +=currQ.qId+";";
        }
        
    }
    console.log("Data sent to server = "+qChecked);
    
    var postEle = $.post('MCPracticeTest',{
        activity:'submit',
        right:rightIds,
        wrong:wrongIds,
        checked:qChecked,
        unchecked:qUnChecked
    },                    
    function(data){
        $('#spanSubmitInfo').html('Your practice has been submitted successfully. Number of Entries updated = '+data);
        $('#spanSaveBtn').hide();
        $('#divSubmitInfo').show();
    });                
}