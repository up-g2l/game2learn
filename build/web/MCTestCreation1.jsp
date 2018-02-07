<%-- 
    Document   : MCTestCreation
    Created on : Aug 23, 2013, 5:41:19 PM
    Author     : upendraprasad
--%>

<%@page import="g2l.util.TestMC"%>
<%@page import="g2l.dao.DataEntry"%>
<%@page import="g2l.util.GPMember"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="ErrorPage.jsp"  %>
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
        <title>Test Creation Completion</title>
    </head>
    <body>
 
        <%
HttpSession sesn1 = request.getSession();
GPMember member = (GPMember)sesn1.getAttribute("member");

String selQ = request.getParameter("selectedQ");

TestMC mcTest = new TestMC();

mcTest.setUserId(member.getId());
mcTest.setTestDuration(30);
mcTest.setTestStatus("1");
mcTest.setqIds(selQ);

DataEntry de = new DataEntry();

String testId = de.createNewTest(mcTest);
        
%>
<jsp:include page="gameMenuBar.jsp" />
<h1 style="color: #555555;">Test Creation Completion</h1>
<table class="">
           <tr><td>Test Identifier</td><td> <%=testId%></td></tr>
           <tr><td>Test Creator</td><td><%=member.getName() %></td></tr>
           <tr><td>Test Duration</td><td><%=mcTest.getTestDuration() %> &nbsp; minutes</td></tr>
       </table>
    </body>
</html>
