<%-- 
    Document   : index
    Created on : Jan 20, 2013, 5:13:11 PM
    Author     : upendraprasad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />

		<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame
		Remove this if you use the .htaccess -->
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

		<title>g2l:Home</title>
		<meta name="description" content="" />
		<meta name="author" content="Upendra Prasad" />

		<meta name="viewport" content="width=device-width; initial-scale=1.0" />

		<!-- Replace favicon.ico & apple-touch-icon.png in the root of your domain and delete these references -->

<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
                <script type="text/javascript" src="/g2l/js/gameJScript.js"></script>
                <script type="text/javascript" src="/g2l/js/gameJScript2.js"></script>
                <link rel="stylesheet" type="text/css" href="/g2l/css/gameStyle.css">

 <style type="text/css">
  div.green { margin: 0px; width: 100px; height: 80px; background: green; border: 1px solid black; position: inherit;left: 300px;top: 200px;  }
  div.red { margin-top: 0px; width: 500px; height: 300px; background: #552200; border: 1px solid black; position: inherit; left: 475px;top: 220px; }
  .ui-effects-transfer { border: 1px solid black; background-color: #DDDDDD;}
  body{background-image:url(./images/greenbg.jpg);}
</style>
		 
    <script type="text/javascript">		
      window.onbeforeunload = function() { return "Are you sure you want to leave? The CURRENT GAME WILL BE LOST."; }   	
   
     </script>
</head>

<body onload="loadInit();init();">
 <div align="center">			
     <div>
        <table width="1280px" border="1px" cellspacing="1px" cellpadding="0px">
           <tr>
                        <td>
                            <table width="100%" style="border: 1px" cellpadding="2px" cellspacing="1px" bordercolor="black">
                                <tr class="menu">
                                    <td id="New Game" onclick="window.location.reload();" class="menu"> New Game</td>								
                                    <td id="move1" onclick="move('1'); return false;" class="menu"> Move by A+B</td>
                                    <td id="move2" onclick="move('2'); return false;" class="menu"> Move by A-B</td>
                                    <td id="move3" onclick="move('3'); return false;" class="menu"> Move by B-A</td>			
                                    <td id="move4" onclick="move('4'); return false;" class="menu"> Move by A^B mod B</td>
                                    <td id="move5" onclick="move('5'); return false;" class="menu"> Move by B^A mod A</td>
                                    <td id="mvTD" style="width: 50%; text-align: left" class="menu"> <em id="mvEM">Movements</em></td>
                                 </tr>
                            </table>
                        </td>
                    </tr>
           <tr >
              <td style="background: url(./images/FibSpiral1.jpeg);background-repeat: no-repeat" >
                <table style="opacity: 0.75" id = "gameTbl" width="100%"  cellpadding="0px" cellspacing="0px" border="1px" bordercolorlight="rgb(0,0,0)">
                    <tr>
                        <td class="GameTD4" ><img  id ="bb" src="./images/blue3D.jpeg" width="50px"/></td>
                        <td class="GameTD1" ></td>
                        <td class="GameTD1" ></td>
                        <td class="GameTD1" ></td>
                        <td class="GameTD1" ></td>
                        <td class="GameTD1" ></td>
                        <td class="GameTD1" ></td>
                        <td class="GameTD1" ></td>
                    </tr>
                    <tr><td id="gameTD10" class="GameTD4"  > Question 6</td><td  class="GameTD1" ></td>
                        <td class="GameTD2" ></td><td  class="GameTD2" ></td><td  class="GameTD2" ></td>
                        <td class="GameTD2" ></td><td  class="GameTD2" ></td><td  class="GameTD1" ></td></tr>
                    <tr><td  class="GameTD4"  > Question 5</td><td  class="GameTD1" ></td><td  class="GameTD2" ></td>
                        <td class="GameTD3" ></td><td class="GameTD3" ></td><td class="GameTD3" ></td>
                        <td class="GameTD2" ></td><td class="GameTD1" ></td></tr>
                    <tr><td class="GameTD4"  > Question 4</td><td class="GameTD1" ></td><td class="GameTD2" ></td>
                        <td class="GameTD3" ></td>
                        <td class="GameTD5" onclick="rollDice()">  
                            <img id="imgDie1" src="./images/dieQ.jpeg" width="60px" /> <img id="imgDie2" src="./images/dieQ.jpeg" width="60px" />   </td>
                        <td class="GameTD3" ></td><td class="GameTD2" ></td><td class="GameTD1" ></td>
                    </tr>
                    <tr><td class="GameTD4"  > Question 3</td><td class="GameTD1" ></td><td class="GameTD2" ></td><td class="GameTD3" ></td>
                        <td class="GameTD3" ></td><td class="GameTD3" ></td><td class="GameTD2" ></td><td class="GameTD1" ></td>
                    </tr>
                    <tr><td class="GameTD4"  > Question 2</td><td class="GameTD1" ></td><td class="GameTD2" ></td><td class="GameTD2" ></td>
                        <td class="GameTD2" ></td><td class="GameTD2" ></td><td class="GameTD2" ></td><td class="GameTD1" ></td>
                    </tr>
                    <tr><td class="GameTD4"  > Question 1</td><td class="GameTD1" ></td><td class="GameTD1" ></td>
                        <td class="GameTD1" ></td>
                        <td class="GameTD1" ></td><td class="GameTD1" ></td><td class="GameTD1" ></td>
                        <td class="GameTD1" ></td>
                    </tr>
                </table>                  
              </td>
             </tr>
           </table>
        </div>
          
  </div>
  <!--  <footer> <p> &copy; Copyright  by Upendra Prasad  </p> </footer>-->
</body>
</html>

