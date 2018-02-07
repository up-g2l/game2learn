<%-- 
    Document   : mcTestDesc
    Created on : Jun 6, 2014, 10:24:24 AM
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
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <style>.tblInfo{padding: 10px; background-color: #EEEEEE;
                 color: #777777;text-align: left; margin: auto;width: 800px;border: 3px solid #777777;}
            .tblInfo  td{padding: 4px;}
            </style>
            <script>
                $(document).ready(function(){
                    $('.tblInfo  td').slice(0,7).css("background-color","#FFFFFF");                
                    
                $( "#imgDatePickFrom" ).click(function(){
                    var dateFrom = $( "#testAvailFrom" ).datepicker({dateFormat: "yy-mm-dd"});
                    dateFrom.datepicker("show");
                });
                
                $( "#imgDatePickTo" ).click(function(){
                    var dateTo = $( "#testAvailTo" ).datepicker({dateFormat: "yy-mm-dd"});
                    dateTo.datepicker("show");
                });
                });
            </script>
            <title>g2l: MC Test Creation</title>

        </head>
        <body>
            <jsp:include page="gameMenuBar.jsp" />
            <h2 style="color: #555555;">Test Description Change</h2>
        <form name="formTestDesc" action="MCTestGen" method="POST">
            <c:set scope="page" var="mcTest" value="${requestScope.mcTest}"></c:set>
            <table class="tblInfo">
                <tr><td>Test id</td><td><c:out value="${mcTest.testId}" default="No value"/> </td></tr>
                <tr><td>Test Creator</td><td><c:out value="${requestScope.creator}" default="No value"/> </td></tr>                
                <tr><td>Created on</td><td><c:out value="${mcTest.dateCreated}" default="TBA"/></td> </tr>
                <tr><td colspan="2"> Please provide or change the following information.</td><tr>
                <tr><td>Test Status</td><td><c:out value="${mcTest.testStatus}" default="Under Construction"/>
                        <select name="testStatus">
                            <option value="0">Under Construction</option>
                            <option value="4">Finalize Test</option>
                            <option value="2">Suspend Test</option>
                            <option value="3">Discard Test</option>
                        </select>
                    </td></tr>
                <tr><td>Title</td><td><input type="text" name="testTitle" value="${mcTest.testTitle}" id="testTitle" /> </td></tr>                
                <tr><td>Test Duration</td><td>
                        <input type="text" name="testDuration" value="${mcTest.testDuration}" /> </td></tr>
                <tr><td>Available From</td><td>
                        <input type="text" name="testAvailFrom" value="${mcTest.dateFrom}" id="testAvailFrom" placeholder="yyyy-mm-dd"/>
                        <img id="imgDatePickFrom" src="/g2l/icons/datePick2.png" class="btn-image" style="margin-bottom: -8px;"/> </td></tr>
                <tr><td>Available Until</td><td>
                        <input type="text" name="testAvailTo" value="${mcTest.dateTo}" id="testAvailTo" placeholder="yyyy-mm-dd"/>
                        <img id="imgDatePickTo" src="/g2l/icons/datePick2.png" class="btn-image" style="margin-bottom: -8px;"/> </td></tr>            
                <tr><td>Description</td><td>
                        <textarea name="testDesc" maxlength="1000" style="width:300px;height:70px;text-align: left;">${mcTest.description}
                        </textarea></td> </tr>
                <tr><td colspan="2" style="text-align: center;height: 35px;"> 
                        <img src="images/spring/btnSave2.png" height="30" alt="Save" onclick="submit();"/>
                    </td><tr>
            </table>
                <input type="hidden" name="stage" value="5" />
                <input type="hidden" name="testId" value="${mcTest.testId}"/>
        </form>

    </body>
</html>
</body>
</html>
