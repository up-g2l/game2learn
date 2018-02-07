/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


            var jsonFigure={};
            $(function(){
               /* $('#tblFigDetails .imgThumbUploaded').click(function(){
                    var tdEle = $(this).parent().siblings();
                    var tdDesc = tdEle.eq(1);
                    var spanDesc = tdDesc.find('span');
                    
                    $('#figId').val(tdEle.eq(0).text());
                    $('#figId').parent().next().text(tdEle.eq(0).text());
                    
                    $('#figCaption').val(spanDesc.eq(0).text()); 
                    $('#figSource').val(spanDesc.eq(1).text()); 
                    $('#figKey').val(spanDesc.eq(2).text()); 
                    $('#imgUpdate').attr('src',$(this).attr('src'));
                    $('#fileName').attr('disabled',true);                    
                    $('#divPopContainerFig').css("display","table");  
                    $('#divFigMsg').html("Message: Change details for the figure and save.");
                    coverScreenGray();
                });*/
                $('#tblFigDetails .imgThumbUploaded').click(popFigBox);
                
                $("#aNewFig").click(function(){
                    coverScreenGray();
                    $('#divPopContainerFig').css("display","table"); 
                   // $('form')[0].reset();$('#fileName').attr('disabled',false);
                   $('form[action*="Figure"]')[0].reset();
                   $('#fileName').attr('disabled',false);
                    $('#imgUpdate').attr('src','/g2l/uploadedImages/0.jpg');//Default Image on reset or new figure
                    $('#figId').parent().next().text("");
                    $('#divFigMsg').html("Message: Select an image file (size < 1MB), provide details and save.");
                });
                
                $("#aResetFig").click(function(){// Reset from the figure upload popup
                    //coverScreenGray();
                    //$('#divPopContainerFig').css("display","table"); 
                   // $('form')[0].reset();$('#fileName').attr('disabled',false);
                   $('form[action*="Figure"]')[0].reset();
                   $('#fileName').attr('disabled',false);
                    $('#imgUpdate').attr('src','/g2l/uploadedImages/0.jpg');//Default Image on reset or new figure
                    $('#figId').parent().next().text("");
                    $('#divFigMsg').html("Message: Select an image file (size < 1MB), provide details and save.");
                });
                
                
                $("#aNewFigQ1").click(function(){      //Use in the enterQ.jsp page              
                    $('#divPopContainerFig').css("display","table"); 
                   // $('form')[0].reset();$('#fileName').attr('disabled',false);
                   $('form[action*="Figure"]')[0].reset();$('#fileName').attr('disabled',false);
                    $('#imgUpdate').attr('src','/g2l/uploadedImages/0.jpg');
                    $('#figId').parent().next().text("");
                    $('#divFigMsg').html("Message: Select an image file (size < 1MB), provide details and save.");
                });
            });
            function uploadImage(){
                //alert('step1');   
                if($('#fileName').attr('disabled')){updateImageData(); return;}
                var formData = new FormData($('form[action*="Figure"]')[0]);
                
                $.ajax({
                    url: 'FigureUploader',  //server script to process data
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    dataType:'json',
                    success: function(data) { jsonFigure = eval(data);
                        if(jsonFigure.figUpload=="SAVED"){                            
                            //$('#imgUpdate').attr("src","uploadedImages/"+jsonFigure.figName); 
                            $('#figId').val(jsonFigure.figId);
                            $('#figId').parent().next().text(jsonFigure.figId); 
                            alert("FigName :"+jsonFigure.figName);
                            $('#imgUpdate').attr("src","uploadedImages/"+jsonFigure.figName);
                            $('#fileName').attr('disabled',true); 
                            $('#divFigMsg').show();
                            $('#divFigMsg').html("Image uploaded successfully. You can change the details still.");
                            $('#divLinkContainer').show();
                            
                            
                            var strHTML = "<tr><td>"+jsonFigure.figId+"</td><td>"
                                             +"<span class='spanFigDesc'>"+jsonFigure.figCaption+"</span>"
                                             +"<span class='spanFigDesc'>"+jsonFigure.figSource+"</span>"
                                             +"<span class='spanFigDesc'>"+jsonFigure.figKey+"</span>"
                                     +" </td><td><img src='/g2l/uploadedImages/"+jsonFigure.figName+"' "
                                     +"class='imgThumbUploaded' id='fig"+jsonFigure.figId+"' title='Click to edit.' onclick='popFigBox()'/></td> </tr>";
                                 
                                 $("#tblFigDetails").children("tbody").eq(0).prepend(strHTML);
                                 //$('#tblFigDetails tbody tr td').on( "click", "#fig"+jsonFigure.figId, alert("Hello buddy")); 
                            
                          //  setTimeout(function(){
                                //document.getElementById("imgUpdate").src="uploadedImages/"+jsonFigure.figName;
                           //     $('#imgUpdate').attr("src","uploadedImages/"+jsonFigure.figName);
                           // }, 1000);
                            
                        }else{
                            $('#divFigMsg').html(jsonFigure.message);
                        }                        
                    },
                    error: function(jqXHR, textStatus, errorMessage) {
                        $('#divFigMsg').html("Failure in uploading image.");
                        console.log(errorMessage); // Optional
                    }
                })
            }
  
            function updateImageData(){
                //alert('step1');              
                $.ajax({
                    url: 'FigManager',  //server script to process data
                    type: 'POST',
                    data: {act:'update',
                        figId:$('#figId').val(),
                        figCaption:$('#figCaption').val(),
                        figKey:$('#figKey').val(),
                        figSource:$('#figSource').val(),
                        figStatus:$('#figStatus').val() },
                    success: function(data) {
                        if(data.substr(0,4)=="FAIL"){
                            $('#divFigMsg').html(data);
                        }else{
                            $('#divFigMsg').html("Figure details updated successfully.");
                        }
                    },
                    error: function(jqXHR, textStatus, errorMessage) {
                        $('#divFigMsg').html("Failure in figure details updation.");
                        console.log(errorMessage); // Optional
                    }
                });
            }
            
            function popFigBox(figureId){
                  
                  $.ajax({
                    url: 'FigManager',  //server script to process data
                    type: 'POST',
                    data: {act:'info',
                           figId:figureId
                           },
                    success: function(data) { jsonFigure = eval(data);
                    $('#figId').val(jsonFigure.figId);
                    $('#figId').parent().next().text(jsonFigure.figId);
                    
                    $('#figCaption').val(jsonFigure.figCaption); 
                    $('#figSource').val(jsonFigure.figSource); 
                    $('#figKey').val(jsonFigure.figKey); 
                    $('#imgUpdate').attr('src',$(this).attr('src'));
                    $('#fileName').attr('disabled',true);                    
                    $('#divPopContainerFig').css("display","table");  
                    $('#divFigMsg').html("Message: Change details for the figure and save.");
                    coverScreenGray();

                    },
                    error: function(jqXHR, textStatus, errorMessage) {
                        $('#divFigMsg').html("Failure in figure details updation.");
                        console.log(errorMessage); // Optional
                    }
                });
            }
            
            function popFigBoxOld(){
                var tdEle = $(this).parent().siblings();
                    var tdDesc = tdEle.eq(1);
                    var spanDesc = tdDesc.find('span');
                    
                    $('#figId').val(tdEle.eq(0).text());
                    $('#figId').parent().next().text(tdEle.eq(0).text());
                    
                    $('#figCaption').val(spanDesc.eq(0).text()); 
                    $('#figSource').val(spanDesc.eq(1).text()); 
                    $('#figKey').val(spanDesc.eq(2).text()); 
                    $('#imgUpdate').attr('src',$(this).attr('src'));
                    $('#fileName').attr('disabled',true);                    
                    $('#divPopContainerFig').css("display","table");  
                    $('#divFigMsg').html("Message: Change details for the figure and save.");
                    coverScreenGray();
            }