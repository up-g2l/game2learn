<%-- 
    Document   : BubblePops
    Created on : Apr 12, 2013, 9:48:10 PM
    Author     : upendraprasad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <title>JSP Page</title>
        <style>
            .qBubble{
                position: absolute; top:0px;  background-color: white;width: 100px;height: 100px;
                border-radius: 50px;padding: 15px;border:1px solid green;margin: auto;color:white;
                font-weight: bold;
            }
        </style>
        <script>
         var gameON =false;
         var myVar;     
           var qNumber =0; 
           var randSpot=1;
           
  function  startBubbleFalls(){
      gameON=true;
      qNumber += 1;  
      randSpot = Math.floor((Math.random()*10)+1);
      dropBubble("spot"+randSpot);
           
       myVar = setInterval( function(){qNumber += 1;  randSpot = Math.floor((Math.random()*10)+1);
           dropBubble("spot"+randSpot);},3000);

       }   
    
  function dropBubble(spot){
  
      var bub = document.createElement("DIV");bub.id="bubble"+qNumber; bub.className="qBubble";
      bub.style.backgroundColor="#"+Math.floor((Math.random()*900)+99);
      var qText =document.createTextNode("Question "+qNumber+" and Spot = "+spot);
      bub.appendChild(qText);
      var tdEle = document.getElementById(spot);
      $(tdEle).prepend(bub);    
      
           if(gameON) {               
                    $('#bubble'+qNumber).animate({top:'600px'},15000,function(){ $(this).fadeOut();});
            }
             else{gameON=false;  clearInterval(myVar);}
                
  }     
       
        </script>
    </head>
    <body style="background-image: url(../images/greenbg.jpeg);">
        
        <table style="height:800px;">
            <tr>
                <td id="spot1" style="width:128px;">
                </td><td id="spot2" style="width:128px;">
                </td><td id="spot3" style="width:128px;">
                </td><td id="spot4" style="width:128px;">
                </td><td id="spot5" style="width:128px;">
                </td><td id="spot6" style="width:128px;">
                </td><td id="spot7" style="width:128px;">
                </td><td id="spot8" style="width:128px;">
                </td><td id="spot9" style="width:128px;">
                </td><td id="spot10" style="width:128px;">                    
                </td>
            </tr>
        </table>
        <div style="text-align: center; background-color: white;">
        <a id ="btnStart" class="miniLink" onclick="startBubbleFalls();">START</a>
        <a id ="btnStop" class="miniLink" onclick="$('.qBubble').stop();gameON=false;">STOP</a>
        <a id ="btnClear" class="miniLink" onclick="$('.qBubble').remove();gameON=false;">CLEAR</a>
        </div>
    </body>
</html>
