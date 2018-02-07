<%-- 
    Document   : mcTestCreation
    Created on : Jun 4, 2014, 12:56:59 AM
    Author     : upendraprasad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>

        <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>       
        <script type="text/javascript" src="/g2l/js/gameJScript3.js" ></script>
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <style>.tblInfo{padding: 20px; background-color: #EEEEEE;
                 color: #777777;text-align: left; margin: auto;width: 800px;border: 1px solid green;}
            </style>
            <script>
                $(document).ready(function(){
                    $('.tblInfo  td').css("border-bottom","1px solid #777777");                
                    
                $( "#imgDatePickFrom" ).click(function(){
                    $( "#testAvailFrom" ).datepicker({dateFormat: "yy-mm-dd"});
                    $( "#testAvailFrom" ).datepicker("show");
                });
                
                $( "#imgDatePickTo" ).click(function(){
                    $( "#testAvailTo" ).datepicker({dateFormat: "yy-mm-dd"});
                    $( "#testAvailTo" ).datepicker("show");
                });
                });
            </script>
            <title>g2l: MC Test Creation</title>

        </head>
        <body>
            <jsp:include page="gameMenuBar.jsp" />
            <h1 style="color: #555555;">Test Creation Completion</h1>
            <table class="tblInfo">
                <tr><td>Test id</td><td><c:out value="${requestScope.testId}" default="No value"/> </td></tr>
                <tr><td>Test Creator</td><td><c:out value="${requestScope.creator}" default="No value"/> </td></tr>
                <tr><td>Test Status</td><td><c:out value="${requestScope.testStatus}" default="Under Construction"/> </td></tr>
                <tr><td>Created on</td><td><c:out value="${requestScope.creationDate}" default="TBA"/></td> </tr>
                <tr><td colspan="2"></td> </tr>
                <tr><td colspan="2"> 
                        <a href="/g2l/MCTestGen?stage=4&testId=<c:out value='${requestScope.testId}' default='No value'/>"> Change Description</a>
                    </td> </tr>
            </table>

    </body>
</html>
</body>
</html>
