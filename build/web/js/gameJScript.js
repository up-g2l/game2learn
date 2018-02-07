/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

//Global Variables
		var die1 ;
                var die2 ;
                var eleGameTbl
                var eleGameCells;
                var moveValue = -100;
		var die1Val = 0;
		var die2Val = 0;
		var strQBox ;
		var moveHistory = new Array(100);
		
		var mapCells = [0,1,2,3,4,5,6,7,15,23,31,39,47,55,54,53,52,51,50,49, 41, 33, 25, 17, 9, 10, 11, 12, 13, 14, 22, 30, 38, 46, 45, 44, 43, 42,34, 26, 18, 19, 20, 21, 29, 37, 36, 35, 27, 28 ];
	
		var moveNum = 0;
		var movements = 'Movements: 0';
		var currentCell = 0; 
                var colorLevel = 1;
                
                var qDB = new Array();
                var qObj = {};
	///////        
	  
 function showQBox(){ // Not being used
     var i=0; boxEle = document.getElementById('qDiv'); 
	     if(boxEle.style.visibility=='visible') { boxEle.style.visibility = 'hidden';   }
	         else { boxEle.innerHTML = '<hr> '+question[i]+'<hr> (A) '+ansA[i]+'<br> (B) '+ansB[i]+'<br> (C) '+ansC[i]+'<br> (D) '+ansD[i]+'<hr>';  boxEle.style.visibility= 'visible';}
	        }
	
 function loadInit(){
		// 	alert('Hello');
                moveHistory = new Array(100);                
                mapCells = [0,1,2,3,4,5,6,7,15,23,31,39,47,55,54,53,52,51,50,49, 41, 33, 25, 17, 9, 10, 11, 12, 13, 14, 22, 30, 38, 46, 45, 44, 43, 42,34, 26, 18, 19, 20, 21, 29, 37, 36, 35, 27, 28 ];
	        moveNum = 0;
                moveHistory[0] = moveNum;
                movements = 'Movements: 0';
                currentCell = 0; 
                colorLevel = 1;
                strQBox = '<div id="qDiv" class="qBox">  <table id="qTbl" class="tblQ" cellpadding="10px"/></div>'
                                moveValue = -100;
                		die1Val = 0;
		                die2Val = 0;
                                die1 = document.getElementById('imgDie1');
				die2 = document.getElementById('imgDie2'); 
		 	        eleGameTbl=document.getElementById('gameTbl');
				eleGameCells=eleGameTbl.getElementsByTagName('td'); //array to hold references to table cells
				// alert(eleGameCells.length);
		 }
                 
 function rollDice(){			
				 die1Val=Math.floor(Math.random()*6)+1;
				 die2Val=Math.floor(Math.random()*6)+1;

				die1.src = 'images/dieR'+die1Val+'.jpeg';
				die2.src = 'images/dieR'+die2Val+'.jpeg';
				return false;
			}
		
 function resetDice(){          die1Val = 0;die2Val = 0; completeField=null; completeTable=null; autoRow=null; 
				die1.src = 'images/dieQ.jpeg';
				die2.src = 'images/dieQ.jpeg';
				}
				
 function move2(type){ //Old Move method
				var mvEle = document.getElementById("mvEM");
				
				if(die1Val==0) {alert('You forgot to roll the dice buddy!'); return;}
				if(type =='1') moveValue = die1Val+die2Val; 
				  else if(type=='2') moveValue = die1Val- die2Val; 
				       else if(type=='3') moveValue = - die1Val+die2Val; 
				             else if(type=='4') moveValue = Math.pow(die1Val, die2Val) % die2Val;
				                   else if(type=='5') moveValue = Math.pow(die2Val,die1Val) % die1Val; //alert(mapCells[currentCell]);	
				//
				if(moveValue!=0 && currentCell+ moveValue < 50 && currentCell+ moveValue > 0  ) { 
					  eleGameCells[mapCells[currentCell]].innerHTML = '';
					  currentCell = currentCell + moveValue; //alert(currentCell);
					  eleGameCells[mapCells[currentCell]].innerHTML = '<img id = "mvPieceImg" onclick="showQBox()" src="./images/blue3D.jpeg" width="50px"/>'+strQBox;
					 
				}  else { alert('Move Invalid'); resetDice();return;}
					movements += '=>'+currentCell; mvEle.innerHTML = movements;
				if(currentCell==49)  { alert('HURRAY!!! YOU WON THE GAME!'); return; }

					moveNum = moveNum+1; resetDice();	
							
 }
 
  function move(type){
        var mvEle = document.getElementById("mvEM");

        if(die1Val==0) {alert('You forgot to roll the dice buddy!'); return;}

    switch(type){
        case '1':  moveValue = die1Val+die2Val; break;
        case '2':  moveValue = die1Val- die2Val; break;
        case '3':  moveValue = - die1Val+die2Val; break;
        case '4':  moveValue = Math.pow(die1Val, die2Val) % die2Val;break;
        case '5':  moveValue = Math.pow(die2Val,die1Val) % die1Val;break            
        default: moveValue = -100;
    }

        if(moveValue!=0 && currentCell+ moveValue < 50 && currentCell+ moveValue > 0  ) { 
                  eleGameCells[mapCells[currentCell]].innerHTML = '';
                  currentCell = currentCell + moveValue; //alert(currentCell);
                  var strHTML = '<img id = "mvPieceImg" onclick="showQBox()" src="./images/blue3D.jpeg" width="50px"/>'+strQBox;
                  eleGameCells[mapCells[currentCell]].innerHTML = strHTML;                   
                  moveNum = moveNum+1; resetDice();
                  moveHistory[0] = moveNum;
                  movements += '=>'+currentCell; mvEle.innerHTML = movements;
        }  
        else { alert('Move Invalid'); resetDice();return;}
        
        if(currentCell==49)  { alert('HURRAY!!! YOU WON THE GAME!'); return; }

        								
 }