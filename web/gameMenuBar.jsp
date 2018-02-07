<%-- 
    Document   : gameMenuBar
    Created on : Mar 7, 2013, 10:55:41 AM
    Author     : upendraprasad
--%>

<%@page import="g2l.util.GPMember"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/bubbles.css">
    </head>

    <table id="tblMenuBar">
        <tr>
            <td style="width:20px;"> </td>
            <td style="width:200px;"> <img style="width: 190px" src="/g2l/images/g2l_Logo.png" /></td>
            <td style="width:auto;"> </td>
            <td style="width: 150px;">
                <div style="position:relative;top:5px;">
                    <a  class="miniLink" onclick="$('#userOptions').slideToggle('slow');">&diams;&nbsp;<c:out value="${sessionScope.member.name}" default="Guest" />&nbsp;&diams;</a>
                    <div id="userOptions" onclick="$(this).slideUp('slow');">
                        <a class="miniLink" href="/g2l/authenticate?queryType=logout&">Logout</a>                        
                        <a  class="miniLink"  href="/g2l/UserInfoChange.jsp">Profile</a>
                    </div>
                </div>                          
            </td>
            <td style="width:60px">  
                <img class="imgIcon"  src="/g2l/icons/home8.png"  onclick="window.location='/g2l/login/user_account.jsp'" />
            </td>
            <td style="width:60px">  
                <img class="imgIcon"   src="/g2l/icons/setup1.png" id="setup" onclick="$('#userSetup').slideToggle('slow');"/>
                <div style="position:relative;top:7px;">
                    <div id="userSetup" onclick="$(this).hide('slow');">
                        Select Theme<hr/><a class="btnLinkS">Spring  </a><a class="btnLinkS">Sunrise  </a><a class="btnLinkS">Oceans </a>
                        <a class="btnLinkS">Sunset </a> <a class="btnLinkS">Sky </a>  
                    </div>                         
                </div>  
            </td>       
            <td style="width:60px"> <img class="imgIcon"   src="/g2l/icons/helper.png" id="setup" onclick="$('#helpMessage').slideToggle('slow');"/>
                <div style="position:relative;top:20px;">		
                    <div id="helpMessage" onclick="$(this).hide();">
                        <p class="triangle-border top" id="pMsg">I am your assistant. I provide suggestions when you need them.
                        </p>
                    </div>
                </div>
            </td>
            <td style="width:100px">&nbsp;</td>
        </tr>
    </table>    
</html>
