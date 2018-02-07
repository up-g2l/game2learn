var req;
var isIE;
var completeField;
var completeTable;
var autoRow;
var eleStatus;
var qEntryMsg = "";
var qDB = new Array();
var qObj={};
 


//Validate the data enetered for a question
function validateDataEntry(){
    var isDataValid=true;
     qEntryMsg ='Data validation: '
       
    $(':input').css("background-color",""); //alert('Step1');//Change background color to original           
    if($('#subSelect').val()==''){ 
        $('#subAreas').css("background-color","#FCBDBD");
        isDataValid=false;
        qEntryMsg += 'Subject Area not selected; ';
    }//Highlight Empty text boxes which must not be. 
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
            
        $.post("QEntry", {
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
                    $('#qEntryMsg').show();
                    $('#qEntryMsg').text("Question saved successfully. ");
                    setTimeout(function(){
                        $('#qEntryMsg').hide();
                    }, 10000);
                    
                    $('#qEntered').append('<span id="q'+data+'" class="qNum" onclick="qPreview('+data+')">'+data+'</span>');
                    $('#qId').val(data);
                    if($('#simQid').val()=='0'){
                        $('#simQid').val(data);
                    }
                }
            });
    }
}

//Replace occurence of given search criteria by replace string
String.prototype.replaceAll = function(search, replace)
{
    //if replace is null, return original string otherwise it will
    //replace search string with 'undefined'.
    if(!replace) 
        return this;

    return this.replace(new RegExp('[' + search + ']', 'g'), replace);
}

//Create combobox menu from a given xml file.
function loadComboBoxes(xmlFileName){
    $.ajax({
        type: "GET",
        url: xmlFileName,
        dataType: "xml",
        success: function(xml) {
            var curOption, itemName, itemId,  eleMainBox=$('#subjects'),  menuName = 'subject';
            $(xml).find(menuName).each(function(){
                itemName = $(this).find('sub_name').text();
                itemId = $(this).find('sub_id').text();
                curOption=$('<option value="'+ itemId + '">' + itemName + '</option>');
                curOption.data(menuName,$(this)); // bind the country node data from the XML to the option of the dropdown
                curOption.appendTo(eleMainBox);
            });
            curOption=null; 
            eleMainBox=$('#class_level');
            menuName = 'grade';
            $(xml).find(menuName).each(function(){
                itemName = $(this).text();
                itemId = $(this).attr('id');
                curOption=$('<option value="'+ itemId + '">' + itemName + '</option>');                                 
                curOption.appendTo(eleMainBox);
            });
            curOption=null;  
            eleMainBox=$('#diff');
            menuName = 'diff_level';
            $(xml).find(menuName).each(function(){
                itemName = $(this).text();
                itemId = $(this).attr('id');
                curOption=$('<option value="'+ itemId + '">' + itemName + '</option>');                                 
                curOption.appendTo(eleMainBox);
            });
        }
                        
    });
}              
  
  //For selecting subject area from comboboxes
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
    }else if (curSubject==null){
        eleSubMenuBox.hide();
    }
    else{
        eleSubMenuBox.hide();
    }
}

function setQType()
{       
    var strSub = $("#subjects option:selected").val()+$("#subAreas option:selected").val()+$("#class_level option:selected").val()+$("#diff option:selected").val();
    // alert('Subject:'+strSub);
    $("#subSelect").val(strSub);
}


