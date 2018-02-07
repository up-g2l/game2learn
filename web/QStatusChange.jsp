<%-- 
    Document   : TakeMCTest
    Created on : Mar 26, 2013, 12:57:00 AM
    Author     : upendraprasad
--%>

<%@page import="g2l.dao.QuestionDAO"%>
<%@page import="g2l.util.TestMC"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="g2l.util.GPMember"%>
<%@page import="java.util.List"%>
<%@page import="g2l.util.MCQuestion"%>
<%@page import="g2l.dao.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

        <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
        <script type="text/javascript" src="/g2l/js/gameJScript3.js" ></script>
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <title>g2l: Practice</title>
        <style>

            #btnClose{position: absolute; top: 4px; right: 4px;width: 20px;}

        </style>

        <script type="text/x-mathjax-config">
            MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']],
            displayMath: [['\\[','\\]'], ['$$','$$']]},
            styles: {
            ".MathJax": {
            color: "#0000FF"
            }
            }

            });
        </script>

        <%
            String qTags = request.getParameter("tags");
            String qType = request.getParameter("subSelect");
            String qSource = request.getParameter("qSource");
            String qStatus = request.getParameter("qStatus");
            String qProvider = request.getParameter("qProvider");System.out.println("qProvider: "+qProvider);
            String fromDate = request.getParameter("qAprvlDate");System.out.println("From Date "+fromDate);
            GPMember gm = (GPMember)request.getSession().getAttribute("member");
            if(qProvider !=null){qProvider = gm.getId();}
        //qSource="";
            QuestionDAO qd = new QuestionDAO();
            List<MCQuestion> qBeans = qd.fetchQuestions(qType, qSource, qTags, qProvider, qStatus, fromDate, 200, false,false);
            MCQuestion qb;
        %>
        <script>
    
            //window.onbeforeunload = function() { return "Are you sure you want to leave? ALL DATA OF YOUR CURRENT TEST WILL BE LOST ND YOU WILL NOT BE ABLE TO TAKE THE  TEST AGAIN."; }
   
            $.ajaxSetup({
                beforeSend:function(){
                    // show gif here, eg:
                    $("#testSubmitWait").show();
                },
                complete:function(){
                    // hide gif here, eg:
                    $("#testSubmitWait").hide();
                }
            });
  
  
            $(function() {
                /*var icons = {
                    header: "ui-icon-circle-arrow-e",
                    activeHeader: "ui-icon-circle-arrow-s"
                };
                $( "#accordion" ).accordion({
                    icons: icons
                });
                $( "#toggle" ).button().click(function() {
                    if ( $( "#accordion" ).accordion( "option", "icons" ) ) {
                        $( "#accordion" ).accordion( "option", "icons", null );
                    } else {
                        $( "#accordion" ).accordion( "option", "icons", icons );
                    }
                });
                $( "#accordion" ).accordion({ heightStyle: "content" });
                $( "#accordion" ).accordion({ header: "h3" });*/
        
                $( "#accordion1" ).find('.divQBox').hide().eq(0).show();
                $( "#accordion1" ).find('h3').css("font","14px");
                $( "#accordion1 > h3" ).click(function(){
                    $( "#accordion1" ).find('.divQBox').slideUp('slow');
                    $(this).next().focus();
                    $(this).next().slideDown('slow');
            
                });
            });
   
            var ansList = new Array(<%=qBeans.size()%>); //Array to store all answers.
  
            function ansQ(ele,qNum, ans){  
                divEle = $(ele).closest('div');
                imgEle = $(divEle).prev('h3').children('img')[0];
      
                $(divEle).children('span').css("background-color","#999999");
                ansList[qNum]=ans;
                if(ans==null){$(imgEle).attr('src','icons/Qmark.png');}
                else{            
                    $(imgEle).attr('src','icons/Ocheck1.png');
                    $(ele).css("background-color","white");
                }      
            }

            function setQStatus(ele, qID, newStatus){
                
                $.post("QChangeStatus",
                    {    qId:qID, qStatus:newStatus  },
                    function(data,status){    
                            if(status=="success"){       
                                divEle = $(ele).closest('div');
                                imgEle = $(divEle).prev('h3').children('img')[0];
                                $(imgEle).attr('src','icons/qStatus'+newStatus+'.png');
                            }
                
                       });

            }
            
            
            function submitTest(){
                var allAnswers = ansList.toString().replace(/\,/g, ';');
                confirm(allAnswers);
                $.post("TestSubmission",
                {   testId:$('#qId').val(),
                    answerList: allAnswers,
                    source: $('#qSource').val()
                },
                function(data,status){     
                    $('#testSubmissionStatus').html(data);$('#testSubmissionStatus').show();
                    // showAllMessages('Post Status:'+status+';&nbsp; for Index'+qIndex+', &nbsp; ',0, 800, 4000,true,true );                        
                });
            }
        </script>
        <style>
            .imgQStatus{position:absolute;right:2px;bottom:2px; max-width:25px;max-height:25px;}
            li > img{ max-width:25px;max-height: 25px;}
            li{display:block; vertical-align: middle;font-size: 12px; list-style: disc;}
        </style>
    </head>

    <body>
        <jsp:include page="gameMenuBar.jsp" />
        <br>

        <div id="testSubmitWait" style="display: none;"></div>
        <div style="margin: auto;width: 800px; border: 1px solid green;">
            <div id="accordion1">
                <h3>INSTRUCTIONS </h3>
                <div  class="divQBox">
                    <span class="qAprvlInstruction">
                        <ul type="square">
                            <li>Click on the question that you want to finalize and choose appropriate action.</li>
                            <li><img src="icons/qStatus9.png" />&nbsp; Discarded.</li>
                            <li><img src="icons/qStatus0.png" />&nbsp; Newly entered, needs editing.</li>
                            <li><img src="icons/qStatus1.png" />&nbsp; Needs editing.</li>
                            <li><img src="icons/qStatus3.png" />&nbsp; Flagged, needs editing.</li>
                            <li><img src="icons/qStatus2.png" />&nbsp; Figure problems.</li>
                            <li><img src="icons/qStatus4.png" />&nbsp; Ready for approval.</li>
                            <li><img src="icons/qStatus5.png" />&nbsp; Approved and ready for use.</li>                            
                        </ul>
                    </span>
                </div>
                <%
                String qid="";
                    for (int i = 0; i < qBeans.size(); i++) {
                        qb = qBeans.get(i);qid = qb.getqId();
                        String figName = qb.getFigure().getFigSaveName();
                %>
                <h3>Question <%=(i + 1)%>  &nbsp;(id: <%=qb.getqId()%>)
                    <img src="icons/qStatus<%=qb.getqStatus()%>.png" class="imgQStatus"/></h3>
                <div class="divQBox" id="divQBox<%=qb.getqId()%>">
                    <p id="previewQText">Question <%= i + 1%>:&nbsp;<%=qBeans.get(i).getqText()%></p>
                    <div style="width:100%;position: relative;display: inline-block; ">
                        <div style=" width: 300px; float: left;">
                            <span class="spanAns">(A)&nbsp;<%=qb.getAnsA()%></span>
                            <span class="spanAns">(B)&nbsp;<%=qb.getAnsB()%></span>
                            <span class="spanAns">(C)&nbsp;<%=qb.getAnsC()%></span>
                            <span class="spanAns">(D)&nbsp;<%=qb.getAnsD()%></span>
                            <span class="spanAns">(E)&nbsp;<%=qb.getAnsE()%></span>
                        </div>
                        <div class="qFigBox">  
                            <img src="uploadedImages/<%=figName%>" class="thumbQFig"/>
                        </div>
                    </div>
                    <span style="color:#888888;"> Correct Answer:&nbsp; <%=qb.getAnsCorrect()%></span><br>
                    <span style="text-align: center;margin: auto;width: 100%">
                        <a class="miniLink" onclick="setQStatus(this,<%=qid%>,4)">READY</a>
                        <a class="miniLink" onclick="setQStatus(this,<%=qid%>,5)">APPROVE</a>
                        <a class="miniLink" onclick="setQStatus(this,<%=qid%>,1)">EDITABLE</a><br>
                        <a class="miniLink" onclick="setQStatus(this,<%=qid%>,3)">SUSPEND</a>
                        <a class="miniLink" onclick="setQStatus(this,<%=qid%>,2)">FIG PROB</a>
                        <a class="miniLink" onclick="setQStatus(this,<%=qid%>,9)">DISCARD</a>
                    </span>
                </div>  
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>

