<%-- 
    Document   : gameMenuBar
    Created on : Mar 7, 2013, 10:55:41 AM
    Author     : upendraprasad
--%>

<%@page import="g2l.util.GPMember"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <link rel="stylesheet"  type="text/css" href="/g2l/css/bubbles.css">
        <title></title>
        <script>
            
 $(function() {
    $(".btn-image")
        .mouseover(function() { 
            //var src = $(this).attr("src").match(/[^\.]+/) + "over.gif";
            var src = $(this).attr("src").replace("2.png", "3.png");
            $(this).attr("src", src);
        })
        .mouseout(function() {
            var src = $(this).attr("src").replace("3.png", "2.png").replace("1.png", "2.png");
            $(this).attr("src", src);
        })
        .mousedown(function() {
            var src = $(this).attr("src").replace("3.png", "1.png");
            $(this).attr("src", src);
        });   
        
            $(document).mouseup(function (e){
                var container = $('#userOptions');

                if (!container.is(e.target) && container.has(e.target).length == 0) // ... nor a descendant of the container
                {
                    container.hide();
                }
            });
});


            
        </script>
    </head>

        <%

response.setHeader("Cache-Control","max-age=0");  
response.setHeader("Pragma","no-cache");  
response.setDateHeader("Expires", 0); //prevents caching at the proxy server  

GPMember member =  (GPMember)session.getAttribute("member");

if(member==null){System.out.println("Member value null");
}
else{

%>
                <table id="tblMenuBar">
               <tbody>
                   <tr>
                       <td style="width:20px;"> </td>
                       <td style="width:200px;"> <img style="width: 190px" src="/g2l/images/g2l_Logo.png" /></td>
                       <td style="width:auto;"> </td>
                       <td style="width: 100px;">
                           <div style="position:relative;top:5px;">
                            <a  class="miniLink" onclick="$('#userOptions').slideToggle('slow');">&diams;&nbsp;<%=member.getName() %>&nbsp;&diams;</a>
                            <div id="userOptions" onclick="$(this).slideUp('slow');">
                                <a class="miniLink" href="/g2l/authenticate?queryType=logout&">Logout</a>
                                <a  class="miniLink"  href="/g2l/authenticate?queryType=logout&">Profile</a>
                                <a  class="miniLink"  href="/g2l/UserInfoChange.jsp">Profile</a>
                            </div>
                          </div>                          
                       </td>
                       <td style="width:40px">
                       </td>
                       <td style="width:40px">  
                           <img style="cursor:pointer;width:20px"  src="/g2l/icons/home8.png"  onclick="window.location='/g2l/login/user_account.jsp'" /></td>
                       <td style="width:40px">  
                           <img style="cursor:pointer;width:25px"  src="/g2l/icons/help2.png" id="help" onclick="$('#userHelp').slideToggle('slow');"/> 
                           <div style="position:relative;top:7px;">
                             <div id="userHelp" onclick="$(this).hide('slow');">Help Topics (Under Construction)</div>                         
                           </div> 
                       </td>
                       <td style="width:40px">  
                           <img style="cursor:pointer;width:25px"  src="/g2l/icons/setup1.png" id="setup" onclick="$('#userSetup').slideToggle('slow');"/>
                         <div style="position:relative;top:7px;">
                            <div id="userSetup" onclick="$(this).hide('slow');">
                                Select Theme<hr/><a class="btnLinkS">Spring  </a><a class="btnLinkS">Sunrise  </a><a class="btnLinkS">Oceans </a>
                                            <a class="btnLinkS">Sunset </a> <a class="btnLinkS">Sky </a>                         

                            </div>                         
                         </div>  
                      </td>       
                      <td style="width:40px"> <img style="cursor:pointer;width:25px"  src="/g2l/icons/helper.png" id="setup" onclick="$('#helpMessage').slideToggle('slow');"/>
                           <div style="position:relative;top:20px;">		
                               <div id="helpMessage" onclick="$(this).hide();"><p class="triangle-border top" id="pMsg">I am your assistant. I provide suggestions when you need.</p></div></div>
                       </td>
                   <td style="width:50px">&nbsp;</td>
                   </tr>
               </tbody>
           </table>    
<%}%>

</html>
