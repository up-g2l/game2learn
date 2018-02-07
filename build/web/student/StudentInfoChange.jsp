<%-- 
    Document   : StudentInfoChange
    Created on : Sep 25, 2016, 5:32:07 PM
    Author     : upendraprasad
--%>



<%@page import="g2l.dao.DataEntry"%>
<%@page import="g2l.dao.DataAccess"%>
<%@page import="g2l.util.GPMember"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
            <meta name="description" content="">
            <meta name="author" content="">
            <!--<link rel="icon" href="../../favicon.ico">-->

            <title>Starter Template for Bootstrap</title>

            <!-- Bootstrap core CSS -->
            <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <link href="../css/g2l_boot.css" rel="stylesheet">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>     
        <script type="text/javascript" src="/g2l/js/gameJScript3.js" ></script>
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>g2l: Change User Information</title>
        <style>
            #userInfo1{ background-color: white;opacity: 0.7;width: 600px;margin: auto;position: absolute;
                       border-radius: 10px; margin-left: 5px;height: 400px;padding: 20px;
                       box-shadow: 0px 1px 6px 2px #DDDDDD;background-color:#DDDDDD;border: 1px #418737 solid;}
            input1, select1{ width: 250px;height: 35px;font-size: 16px; border:green 1px solid; color: #666666; }
            span1{display: block; background: green; color: white; font-size: 14px;cursor: pointer;padding: 4px;margin: 2px;}
        </style>
    </head>
    <%
        GPMember member = (GPMember) session.getAttribute("member");
        String loginId = request.getParameter("loginId");
        System.out.println("loginId:" + loginId);
        if (loginId != null) {
            System.out.println("loginId 2:" + loginId);
            if (!loginId.equalsIgnoreCase("")) {
                member.setEmail(request.getParameter("email"));
                member.setName(request.getParameter("userName"));
                member.setLogin(loginId);
                DataEntry de = new DataEntry();
                de.updateUserInfo(member);
                session.setAttribute("member", member);
            }
        }

    %>
    <body>
            <nav class="navbar navbar-default navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Game2Learn</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="index.html">Home</a></li>
            <li class="active"><a href="StudentInfoChange.jsp">Profile</a></li>
            <li><a href="../authenticate?queryType=logout&">Logout</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    
        <br>
        <div class="container">
            <div class="col-md-6 col-xs-12"  style="margin:auto;float:none;">
                <div id="updateStatus" ></div>
                <br>
                <form method="post" action="">
                    <span onclick="$('#userDetail').toggle();" class="alert alert-success" role="alert">USER INFO</span>
                    <table style="padding: 5px;width: 100%;" id="userDetail1">
                        <tr><td style="width:200px">Name</td><td><input type="text" name="userName" value="<%=member.getName()%>" /></td></tr>
                        <tr><td>Login Id</td><td><input type="text" name="loginId" value="<%=member.getLogin()%>" /></td></tr>    
                        <tr><td>Email Id</td><td><input type="text" name="email" value="<%=member.getEmail()%>" /></td></tr>        
                        <!--<tr><td>Your Secret Question</td><td><select name="secretQuestion">
                                    <option value="1">In which city were you born?</option>
                                    <option value="2">Q2</option>
                                    <option value="3">Q3</option>
                                    <option value="4">Q4</option>
                                    <option value="5">Q5</option>
                                    <option value="6">Q6</option>
                                    <option value="7">Q7</option>
                                    <option value="8">Q8</option>
                                </select></td></tr> 
                        <tr><td>Answer to secret</td><td><input type="text" name="secretAns" value="" /></td></tr>-->
                    </table><br><br>
                        <span>
                            <a class="btn btn-default btn-sm btn-block"  onclick="$('#passChange').toggle();"> CHANGE PASSWORD</a></span>
                    <table style="padding: 5px;width: 100%;display: none;margin: 2vmin;" id="passChange">   
                        <tr><td style="width:200px">Old Password</td><td><input type="password" name="oldPasswd" value="" /></td></tr>
                        <tr><td style="width:200px">New Password</td><td><input type="password" name="passwd" value="" /></td></tr>
                        <tr><td>Re-enter New Password</td><td><input type="password" name="passwd2" value="" /></td></tr> 
                    </table><br><br><br>
                    <div style="text-align: center;">
                        <button type="submit" class="btn btn-primary btn-block" onclick="submit();">Save Changes</button>
                    </div>                    
                </form>
            </div>
        </div>
                          <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>

