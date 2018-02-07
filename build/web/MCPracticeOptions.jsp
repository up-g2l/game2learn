<%-- 
    Document   : MCPracticeOptions
    Created on : Jul 16, 2014, 10:57:15 PM
    Author     : upendraprasad
--%>

<%@page import="g2l.dao.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" type="text/css"/>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <title>JSP Page</title>
        <style>
            .ui-tooltip {
                background:#666;
                color: white;
                font-size: 14px;
                border: none;
                padding: 10px;
                opacity: 1;
            }
        </style>
    </head>
    <body>
        <jsp:include page="gameMenuBar.jsp" />   
        <div style="width: 900px;margin:0 auto;">  <br>             
          <!--  <form id="frmQ" method="get" action="mcPracticeTest1.jsp">-->
           <form id="frmQ" method="get" action="mcFlashFlip.jsp">
                <div  id="divPracOptions">
                    <h4>Provide the options for the practice.</h4> 
                    <br><br>
                    <span style="display:block;border-bottom:2px solid #009933;padding:5px;">

                        <input type="checkbox" id="chkMem" name="chkMem" value="1" title="Check if you want memory-plus practice."/>
                        <label for="chkMem"> Memory Plus</label>

                        <input type="checkbox" id="chkCMark" name="chkCMark" value="1" title="Check if you want memory-plus practice."/>
                        <label for="chkCMark"> Only Check Marked ?</label>

                        <input type="checkbox" id="chkFlash" name="chkFlash" value="1" title="Check if you want flashcard mode."/>
                        <label for="chkFlash"> Hide Answers</label> 

                        <input type="checkbox" id="chkAccordion" name="chkAccordion" value="1" title="Check if you want accordion display."/>
                        <label for="chkAccordion"> Accordion Style Display</label>
                    </span><br>
                    <label for="subSelect">Subject area</label>
                    <input id="subSelect" type="hidden"   name="subSelect" />
                    <select id="class_level">  <option value="10">Standard</option> </select>
                    <select id="diff" >  <option value="3">Difficulty Level</option>   </select>
                    <select id="subjects" onchange="setSubArea($('#subAreas'),'sub_area');">  <option>Subject</option> </select>
                    <select id="subAreas" onchange="setQType();" disabled="disabled">  <option>Subject Area</option> </select><br>
                    <br>
                    <!--<label for="qProvider"> Display my entries only</label> 
                    <input type="checkbox" id="qProvider" name="qProvider" value="1" title="Check if you want to search from your question database only."/><br>-->
                    <label for="qAprvlDate">Display entries after date</label>
                    <input id="qAprvlDate" class ="ip2" type="text"   name="qAprvlDate" disabled />
                    <img id="imgDatePick" src="/g2l/icons/datePick2.png" class="btn-image" style="margin-bottom: -8px;" title="Display only the most recent entries."/><br>
                    <label for="tags"> Topic Tags</label> <input id="tag1" class ="ip2" type="text" name="tag1" title="Tags help in searching. You can attach several tags to the same question. Enter a new Tag or choose from the auto-complete list and click the add button."/>
                    <input id="btnAddTag" type="button" value="+ &raquo;" />
                    <input id="tags" class ="ip1" type="text"   name="tags"  value="" /><br> 
                    <label for="qSource">Question Source</label>&nbsp;<input id="qSource" class ="ip1"  type="text"   name="qSource" title="If this questions has been taken from somewhere, please provide the source."/><br>
                    <label for="maxNumQ">Number of Question</label>
                    <input id="maxNumQ"   name="maxNumQ" value="10" class="ip2" />
                    <br>
                    <div style="width:100%;position: relative;text-align: center;">
                        <img src="/g2l/images/spring/btnSubmit2.png" id="imgbtnSubmit" class="btn-image" onclick="submit();"/>
                    </div>
                </div> 
            </form>

        </div>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <script>
            <%DataAccess da = new DataAccess();
                String allTags = da.getAllQTags();//System.out.println("Tags Fetched");
                String allSources = da.getAllQSources();  //System.out.println("Sources Fetched");
            %>
    var strTags = "<%=allTags%>";//console.log("Tags: "+strTags);
    var allTags = strTags.split(";");
                        
    var strSources = "<%=allSources%>";//console.log("Sources: "+strSources);
    var allSources= strSources.split(";");
        </script>
        <script>

            
            $(document).ready(function(){
                
                $('#chkCMark').change(function(){                    
                    $('#chkMem').prop("checked",$(this).prop("checked"));
                });
                
                $( "#maxNumQ" ).spinner({ min:1, max: 50 });
                
                loadComboBoxes('/g2l/menu_combo_box.xml');
                
                var posi = {
                    my: 'center bottom', 
                    at: 'center+55 top-8'
                };
    
                posi.collision='none';
                //$('#selQType input').tooltip();
                //$('#selQType input').tooltip('option', 'position', posi);
                $('#divPracOptions  input').tooltip({
                    position:posi, 
                    tooltipClass: 'top'
                });
            
                $( "#tag1" ).autocomplete({
                    source: allTags
                });
                $( "#qSource" ).autocomplete({
                    source: allSources
                });
                
                $( "#imgDatePick, #qAprvlDate" ).click(function(){
                    $( "#qAprvlDate" ).datepicker({
                        dateFormat: "yy-mm-dd"
                    });
                    $( "#qAprvlDate" ).datepicker("show");
                    $( "#qAprvlDate" ).prop("disabled",false);
                });
            });
        </script>

    </body>
</html>
