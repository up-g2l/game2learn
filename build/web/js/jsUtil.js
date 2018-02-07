/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

            
$(function() {
    /*$(".btn-image")
                .mouseover(function() { 
                    //var src = $(this).attr("src").match(/[^\.]+/) + "over.gif";
                    var src = $(this).attr("src").replace("2.png", "3.png");
                    $(this).attr("src", src);
                })
                .mouseout(function() {
                    var src = $(this).attr("src").replace("3.png", "2.png").replace("1.png", "2.png");
                    $(this).attr("src", src);
                })
                .mousedown(function() {
                    var src = $(this).attr("src").replace("3.png", "1.png");
                    $(this).attr("src", src);
                });   */
                
    $(".btn-image")
    .mouseover(function() { 
        var src = $(this).css("box-shadow","0 0 4px black");
    })
    .mouseout(function() {
        var src = $(this).css("box-shadow","");
    })
    .mousedown(function() {
        var src = $(this).css("box-shadow","0 0 6px blue");
    });
        
    $(document).mouseup(function (e){
        var container = $('#userOptions, #helpMessage, #userSetup');

        if (!container.is(e.target) && container.has(e.target).length == 0) // ... nor a descendant of the container
        {
            container.hide();
        }
    });
                
    $('.imgClosePop').click(function(){                    
        $(this).parent().parent().css("display","none");
        //coverScreenGray();
        uncoverBackground();
    });
});


var infoBoxOpen = false;          
//window.onresize = openInfoBox(true);
var boxEle; 
var coverEle;

function popGrayOut(popEle, title){
    coverScreenGray();
    /*var popContainer = document.createElement('div');
        popContainer.id='popContainer'; 
        popContainer.style.className='popBox';
        $(popEle).wrap($(popContainer));
       // document.getElementsByTagName('body')[0].appendChild(popContainer);
        $(popContainer).append('<img src="/g2l/icons/closeBWRound.png" class="imgClosePop"/>');
        $(popContainer).append('<span class="spanAns">'+title+'</span>');
        //$(popContainer).prepend(popEle);$(popEle).show();*/
        
    coverScreenGray();
    $(popEle).show();
    $(popEle).wrap('<div class="popBox"></div>');
    $(popEle).before('<img src="/g2l/icons/closeBWRound.png" class="imgClosePop"/>');
    $(popEle).before('<span class="spanAns">'+title+'</span>');
}
 
function coverToGrayOut(openAlready){ //uses css file having 'coverToGrayOut' as a className
    var body = document.body,  html = document.documentElement;
    var heightDoc = Math.max( body.scrollHeight, body.offsetHeight,  html.clientHeight, html.scrollHeight, html.offsetHeight );    
    if(!openAlready){
        coverEle = document.createElement('div');
        coverEle.id='coverToGrayOut'; 
        coverEle.style.className='coverToGrayOut';
        coverEle.style.width = window.innerWidth;
        coverEle.style.height = heightDoc+'px';
        // coverEle.style.zIndex='5';
        document.getElementsByTagName('body')[0].appendChild(coverEle);
    //alert('HOHO');
    }else{
        //coverEle = document.getElementById('coverToGrayOut');
        //coverEle.style.zIndex='-10';
        document.getElementsByTagName('body')[0].removeChild(coverEle);                       
    }
}

function coverScreenGray(){ //uses css file having 'coverToGrayOut' as a className

    var body = document.body,  html = document.documentElement;
    var heightDoc = Math.max( body.scrollHeight, body.offsetHeight,  html.clientHeight, html.scrollHeight, html.offsetHeight );
    
    coverEle = document.getElementById("coverToGrayOut");
    
    if(coverEle==null){
        coverEle = document.createElement('div');
        coverEle.id='coverToGrayOut'; 
        coverEle.style.className='coverToGrayOut';
        coverEle.style.width = window.innerWidth+'px';
        coverEle.style.height = heightDoc+'px';
        document.getElementsByTagName('body')[0].appendChild(coverEle);//alert('HOHO');
    }else{
        document.getElementsByTagName('body')[0].removeChild(coverEle);
    }
}
      
function coverBackground(){ //uses css file having 'coverToGrayOut' as a className

    var body = document.body,  html = document.documentElement;
    var heightDoc = Math.max( body.scrollHeight, body.offsetHeight,  html.clientHeight, html.scrollHeight, html.offsetHeight );
    
    coverEle = document.getElementById("coverToGrayOut");
    
    if(coverEle==null){
        coverEle = document.createElement('div');
        coverEle.id='coverToGrayOut'; 
        coverEle.style.className='coverToGrayOut';
        coverEle.style.width = window.innerWidth+'px';
        coverEle.style.height = heightDoc+'px';
        document.getElementsByTagName('body')[0].appendChild(coverEle);//alert('HOHO');
    }
}
function uncoverBackground(){ //uses css file having 'coverToGrayOut' as a className

    var body = document.body,  html = document.documentElement;
    var heightDoc = Math.max( body.scrollHeight, body.offsetHeight,  html.clientHeight, html.scrollHeight, html.offsetHeight );
    
    coverEle = document.getElementById("coverToGrayOut");
    
    if(coverEle!=null){
        document.getElementsByTagName('body')[0].removeChild(coverEle);
    }
}

function focusInfoBox(status,strMessage,width,height){//Show an info box while graying out the rest of the screen
    if(width==null||height==null){
        width=500;
        height=300;
    }
    var strBoxStyle='',strCoverStyle='';
    var winInWidth = window.innerWidth;
    var winInHeight = window.innerHeight;   
    var top = ((winInHeight-height)/2)+'px';
    var left=((winInWidth-width)/2)+'px';//alert("This document window is "+top+"x"+left+" pixels.");
    var boxEle = document.getElementById('infoBoxOuterDiv'); 
    var coverEle = document.getElementById('coverDiv');
     
    if(boxEle==null){
        boxEle = document.createElement('div'); 
        document.getElementsByTagName('body')[0].appendChild(boxEle);
        boxEle.id='infoBoxOuterDiv';
        strHTML= '<table onclick="window.clearTimeout(to1);" id="tblStatus8942378" style="background-color:#666666;padding:5px;width:100%;border-bottom:solid #555555; border-right:solid #555555; background-color:#888888;">'+
        '<tr style="color:#222222;font-weight:bold;"><td style="width:100%;">Status Message (Click on this box to stop from closing)</td>'+
        '<td><a  onclick="focusInfoBox(false); return true;">[X]</a></td></tr>'+
        '<tr><td colspan="2" style="padding:2px;color:white;font-weight:bold;border-top:solid 1px white;">'+strMessage+'</td></tr></table>';
        boxEle.innerHTML=strHTML   
    }

    if(coverEle==null){
        coverEle = document.createElement('div');
        document.getElementsByTagName('body')[0].appendChild(coverEle);
        coverEle.id='coverDiv';                                      
    }
    if(status && !infoBoxOpen){ 
        strBoxStyle = 'font:14px bold sherif; padding:2px;position:absolute;top:'+top+';opacity:0.75;'+
        'z-index:10;left:'+left+';width:'+width+'px;height:'+height+'px;';
        strCoverStyle = 'position:absolute;top:0px;opacity:0.75;z-index:5;left:0px;width:'+winInWidth+
        'px;height:'+winInHeight+'px;background-color:#EEEEEE;';
        coverEle.style.cssText = strCoverStyle;
        boxEle.style.cssText=strBoxStyle;
        boxEle.style.visibility='visible';
        infoBoxOpen = true;
    } else{

        coverEle.style.zIndex = '0';
        coverEle.style.width='0';
        coverEle.style.height='0';
        boxEle.style.visibility='hidden';
        infoBoxOpen = false; 
    }
}
  
function focusInfoBox2(openAlready,strMessage,width,height){//Show an info box while graying out the rest of the screen
     
    if(width==null||height==null){
        width=500;
        height=300;
    }
    var strBoxStyle='',strCoverStyle='';
    var winInWidth = window.innerWidth;
    var winInHeight = window.innerHeight;   
    var top = ((winInHeight-height)/2)+'px';
    var left=((winInWidth-width)/2)+'px';
  
    if(!openAlready){  
        coverToGrayOut(false);
        boxEle = document.createElement('div');
        boxEle.id='infoBoxOuterDiv';
        document.getElementsByTagName('body')[0].appendChild(boxEle);
        strHTML= '<table onclick="window.clearTimeout(to1);" id="tblStatus8942378" style="background-color:#666666;padding:5px;width:100%;border-bottom:solid #555555; border-right:solid #555555; background-color:#888888;">'+
        '<tr style="color:#222222;font-weight:bold;"><td style="width:100%;">Status Message (Click on this box to stop from closing)</td>'+
        '<td><a  onclick="focusInfoBox2(true); return true;">[X]</a></td></tr>'+
        '<tr><td colspan="2" style="padding:2px;color:white;font-weight:bold;border-top:solid 1px white;">'+strMessage+'</td></tr></table>';
        boxEle.innerHTML=strHTML ; 
        strBoxStyle = 'font:14px bold sherif; padding:2px;position:absolute;top:'+top+';opacity:0.75;'+
        'z-index:10;left:'+left+';width:'+width+'px;height:'+height+'px;';
                     
        boxEle.style.cssText=strBoxStyle; 
    } else{
        //boxEle = document.getElementById('infoBoxOuterDiv');
        document.getElementsByTagName('body')[0].removeChild(boxEle); 
        coverToGrayOut(true);
                              
    }
}
 

function showMessage(strMessage, left, top, waitTime ){ // A function that works as an alert. Parameter top and left give the position of the box and waitTime gives the time to wait before closing. Parameter 'message' is of course the message.
    if(top==null||left==null){
        left=0;
        top=0;
    }
    if(waitTime==null){
        waitTime=2000;
    }
    var messageDiv = document.createElement('div');
    messageDiv.id='messageDiv18364478';    
    messageDiv.style.cssText='padding:2px;position:absolute;top:'+top+'px;opacity:0.75; z-index:100;left:'+left+'px;';            
    var strHTML= '<table style="width:400px;border-bottom:solid #555555; border-right:solid #555555; background-color:#888888;">'+
    '<tr style="color:#222222;font-weight:bold;"><td style="width:100%;">Status Message</td>'+
    '<td><a  onclick="document.getElementById(\'messageDiv18364478\').remove(); return true;">[X]</a></td></tr>'+
    '<tr style=""><td colspan="2" style="padding:10px;color:white;font-weight:bold;">'+strMessage+'</td></tr></table>';
    messageDiv.innerHTML=strHTML;
    document.getElementsByTagName('body')[0].appendChild(messageDiv);
    setTimeout(function(){
        messageDiv.remove();
    },waitTime);  
}

function showAllMessages(strMessage, left, top, waitTime,fade,above){ // A function that works as an alert. Parameter top and left give the position of the box and waitTime gives the time to wait before closing. Parameter 'message' is of course the message.
    if(top==null||left==null){
        left=700;
        top=0;
    }
    if(waitTime==null){
        waitTime=10000;
    }
    if(fade==null){
        fade=false;
    }
    if(above==null){
        above=true;
    }

    var strHTML='';
    var curStatus='';
    var strStyle ='';
    var messageDiv=document.getElementById('messageDiv18354678');
    if(messageDiv==null){
        messageDiv = document.createElement('div');
        messageDiv.id='messageDiv18354678';              
        strStyle = 'font:14px bold sherif; padding:2px;position:absolute;top:'+top+'px;opacity:1.0; z-index:100;left:'+left+'px;';            
        messageDiv.style.cssText= strStyle;

        strHTML= '<table onclick="window.clearTimeout(to1);" id="tblStatus8942378" style="padding:5px;width:400px;border-bottom:solid #555555; border-right:solid #555555; background-color:#888888;">'+
        '<tr style="color:#222222;font-weight:bold;"><td style="width:100%;">Status Message (Click on this box to stop from closing)</td>'+
        '<td><a  onclick="document.getElementById(\'messageDiv18354678\').style.visibility=\'hidden\'; return true;">[X]</a></td></tr>'+
        '<tr><td colspan="2" style="padding:2px;color:white;font-weight:bold;border-top:solid 1px white;">'+strMessage+'</td></tr></table>';

        document.getElementsByTagName('body')[0].appendChild(messageDiv);
        messageDiv.innerHTML= strHTML;
    }
    else{
        var eleTr = document.createElement('tr');         
        strHTML= '<td colspan="2" style="padding:2px;color:white;font-weight:bold;border-top:solid 1px white;">'+strMessage+'</td>';

        eleTr.innerHTML= strHTML;
        var eleTblStatus = document.getElementById('tblStatus8942378');

        var eleTBody = eleTblStatus.getElementsByTagName('tbody')[0];
        if(!above){
            eleTBody.appendChild(eleTr);
        }
        else {
            eleTBody.insertBefore(eleTr, eleTBody.childNodes[1]);
        }
        messageDiv.style.opacity='0.75';
        messageDiv.style.visibility='visible';
    }          
    if(fade==true){
        to1= setTimeout(function(){
            reduceOpacity(messageDiv,3);
        },waitTime);//messageDiv.style.visibility='hidden';
        setTimeout(function(){
            clearInterval(timeSetInt123654)
        },1.5*waitTime);
    }
    else{
        setTimeout(function(){
            messageDiv.style.visibility='hidden';
        },waitTime);
    }
}

function reduceOpacity(eleX, speed)
{
    if(speed<2 || speed > 10){
        speed= 8;
    }   
    timeSetInt123654 =setInterval(function(){
        var opacity = eleX.style.opacity;
        if(Number(opacity)< 0.2){
            eleX.style.visibility='hidden';
            return;
        }
        else{
            eleX.style.opacity = Number(eleX.style.opacity)*0.1*(10-speed) +'';
        }   
    },100);
}

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