<%-- 
    Document   : ErrorPage
    Created on : Aug 27, 2013, 11:17:01 PM
    Author     : upendraprasad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <!--<link rel="icon" href="../../favicon.ico">-->

   
    <!-- Bootstrap core CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="../css/g2l_boot.css" rel="stylesheet">
        <title>G2L: Error Page</title>
    </head>
    <body>
        <div class="container">
            <div class="jumbotron"></div>
        <h1>Something went wrong.</h1>
        <p>Try again after some time. Contact the administrator if this persists.</p>
       <!-- <table>
            <tr>
                <td><b>Error:</b></td>
                <td>${pageContext.exception}</td>
            </tr>
            <tr>
                <td><b>URI:</b></td>
                <td>${pageContext.errorData.requestURI}</td>
            </tr>
            <tr>
                <td><b>Status code:</b></td>
                <td>${pageContext.errorData.statusCode}</td>
            </tr>
            <c:forEach var="trace" 
                       items="${pageContext.exception.stackTrace}">
                <tr>
                    <td><b>Stack trace:</b></td><td>
                        <p>${trace}</p>

                    </td>
                </tr>
            </c:forEach>
        </table>-->
   </div>         
            
              <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../bootstrap/js/jquery.min.js"><\/script>')</script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>
