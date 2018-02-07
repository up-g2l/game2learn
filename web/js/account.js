/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


function performTask(index){
  //  $('#divCover').show();

    switch(index){
        case 'contributeQImg':
            $('#selQType2').show();
            selOptions();
            $('#frmQ').attr('action','/g2l/EnterQuestions.jsp');
            break;
              
        case 'contributeQ':
            $('#selQType2').show();
            selOptions();
            $('#frmQ').attr('action','/g2l/EnterQuestions_V3.jsp');
            break;
                        
        case 'makeTest':
            $('#selQType1').show();
            selOptions();
            $('#frmQ').attr('action','../MCTestGen');
            break;
                 
        case 'accessQB':
            $('#selQType1').show();
            selOptions();
            $('#frmQ').attr('action','../QStatusChange.jsp');
            break;
                 
        case 'correctQ':
            $('#selQType1').show();
            selOptions();
            $('#frmQ').attr('action','../QuestionCorrection.jsp');
            break;
                 
        case 'game1':
            $('#selQType1').show();
            selOptions();
            $('#frmQ').attr('action','../game1.jsp');
            break;
                 
                 
        case 'practice':
            $('#selQType1').show();
            selOptions();
            $('#frmQ').attr('action','../PracticeQuestions.jsp');
            break;
                 
        case 'flash-card':
            $('#selQType1').show();
            selOptions();
            $('#frmQ').attr('action','../flashCards.jsp');
            break;
                 
        case 'take-test':
            $('#selQType1').show();
            selOptions();
            //$('#frmQ').attr('action','../TakeTest.jsp');
            break;
                 
        case 'game2':
            $('#selQType1').show();
            selOptions();
            $('#frmQ').attr('action','../Game2.jsp');
            break;
        case 'TakeMCTest':
            coverScreenGray();
            $('#mcTest').show();
            selOptions();
            //$('#frmQ').attr('action','../TakeMCTest.jsp');
            break;     

        case 'flashGRE':
            $('#flashGRE').show();
            selOptions();
            //$('#frmQ').attr('action','../TakeMCTest.jsp');
            break;     
        default:
    }      
}
  
function getTestInfo(){
    //alert('step1');
    if($('#testId').val()==""){
        $('#mcTestDetail').html("<span style=\" color:red\">Please enter a valid test id.</span>");
        return false;
    }
    else{                   
        $.post("../TestInfo",
        { 
            testId: $('#testId').val()
        },
        function(data,status){    
            if(status=='success')  {
                $('#mcTestDetail').html(data);
            }
            else{
                $('#mcTestDetail').html("<span style=\" color:red\">Failure. Please enter a valid test id.</span>");
            }
        // showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,true,true ); 
                       
        });
    }
}
function selOptions(){
  
    X = window.innerWidth;
    Y = window.innerHeight;
                
    boxWidth = 700;
    boxHeight = 400;
                
    boxLeft = (X - boxWidth)/2;
    boxTop = (Y - boxHeight)/2;
 
    qEditEle = document.getElementById('selQType');
    //qEditEle.style.top =boxTop+'px';
    //qEditEle.style.left =boxLeft+'px';
    qEditEle.style.display = 'block';
// MathJax.Hub.Queue(['Typeset',MathJax.Hub,'popDivQEdit']);
}
            
                  
$(function() {

    $('#divQB').show();//Show the first set of option in the menu                
      
    $('#qb, #pnl, #gnl, #vp').click(function(){
        $('.allUserMenu').slideUp('slow');
        $(this).next().slideDown('slow');
    });     
                
    $('#btnAddTag').click(function(){//Action of AddTag button
        $('#tags').val($('#tags').val()+$('#tag1').val()+'; ');
        $('#tag1').val('');
    });
        
    var posi = {
        my: 'center bottom', 
        at: 'center+55 top-8'
    };
    
    posi.collision='none';

    $('#selQType input').tooltip({
        position:posi, 
        tooltipClass: 'top'
    });
    $('#divPracOptions  input').tooltip({
        position:posi, 
        tooltipClass: 'top'
    });
                                  
                
    $( "#imgDatePick" ).click(function(){
        $( "#qAprvlDate" ).datepicker({
            dateFormat: "yy-mm-dd"
        });
        $( "#qAprvlDate" ).datepicker("show");
    });
                

    $("#aMakeTest,#aQAprvl,#aQCorr").click(function(event){
        event.preventDefault();
        $('#divPopContainer').css("display","table");
        coverScreenGray();
        $('#selQType1').show();
        $('#frmQ').attr('action',$(this).attr("href"));
        
    }); 
    
    $("#aMCTest").click(function(event){
        event.preventDefault();
        $('#divPopContainer').css("display","table");
        coverScreenGray();
        $('#mcTest').show();
        //$('#frmQ').attr('action',$(this).attr("href"));
        
    }); 
                
    $( "#tag1" ).autocomplete({
        source: allTags
    });
    $( "#qSource" ).autocomplete({
        source: allSources
    });
                
                
    $(document).mouseup(function (e){
        var container = $('#forgotPass');

        if (!container.is(e.target) && container.has(e.target).length == 0) // ... nor a descendant of the container
        {
            container.hide();
        }
    });
            
});
     
