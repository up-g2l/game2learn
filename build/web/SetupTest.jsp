<%-- 
    Document   : SetupTest
    Created on : Mar 23, 2013, 5:50:42 PM
    Author     : upendraprasad
--%>

<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
String qIdList = request.getParameter("qCheckBox");
%>
        <h1>Question Id you selected: <%=qIdList%></h1>
    </body>
</html>
