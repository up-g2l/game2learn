<%-- 
    Document   : index2
    Created on : Jul 20, 2014, 12:20:22 PM
    Author     : upendraprasad
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <title>g2l: Login</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <style>   

            #divLoginStatus{position:absolute;  padding:3px; color: #666666;z-index: 5; width: 100%;
                            font-size: 14px;font-weight: bold; background-image: url(./images/greenBG5.jpeg);}
            #forgotPass1{ display: none;position:absolute; z-index: 5;width: 400px;top: 10px; right: 200px;
                          text-align: right;  background-color: whitesmoke;  margin-top: 0px;
                          border-radius: 10px; padding: 40px; 
                          box-shadow: 0px 0px 2px 4px #AAAAAA;
            }
            #forgotPass{position: absolute; display: none;width: 100%;
                        text-align: right;  padding:10px;
                        background-image: url(./images/greenBG3.jpeg);                        
            }
            label{color:white;width: 200px;font-size: 12px; font-weight:200;}

            #divUses{ float:left;width:350px; font-size: 18px;font: bold italic large Palatino serif  ;
                      background-color:  rgba(0,0,0,0.2); border-radius: 10px;
                      word-spacing: 150%;text-align: left;  height: 400px;margin-right: 5px;padding: 20px;
                      box-shadow: 0px 1px 6px 3px #DDDDDD;color:#FFFFFF;vertical-align: middle;                          
            }
            #newUserSignUp{float:right;background-color:  rgba(0,0,0,0.2);width: 350px;color:#FFFFFF;
                           border-radius: 10px; margin-left: 5px;height: 400px;padding: 20px;
                           box-shadow: 0px 1px 6px 3px #DDDDDD;vertical-align: middle;}
            #outerDiv2{vertical-align: middle;margin: auto;display: table;
                       padding: 15px; background-color: rgba(0,0,0,0.5);
                       height:440px;border-radius: 10px;
            }
            #outerDiv1{ background-color: rgba(255,255,255,0.4);height:800px;}
            .forgotPassBox{float:left;width:300px;background-color:  #79d858; border-radius: 10px;
                           margin: 5px;padding: 10px;box-shadow: 0px 2px 4px 1px #666666; color: #666666; height: 120px;}
            .signup{ width: 250px;height: 35px;font-size: 16px; border:green 1px solid; color: #666666; }
        </style>
    </head>

    <body>
        <div class="outerDiv1">  
            <form name="loginForm" action="authenticate"  method="post"><input type="hidden" name="queryType" id="queryType"/>
                <div id="bannerGame2Learn" ></div>
                <div id="divLoginStatus"></div><br><br>

                <!-- SIGN UP and Info -->
                <div id="outerDiv2">    
                    <div><img style="width: 350px" src="images/g2l_Logo.png" /></div><br>
                    <div style="width: 400px;float:left;">
                        <span style="font-size: 20px; color: #79d858; font-weight: bold;">Login here</span><br><br>
                        <input type="text" id="userId" name="userId" value="" placeholder="User id" class="signup" />
                        <input type="password" id="userPass" name="userPass" value=""  placeholder="Password" class="signup"/> <br><br>
                        <!--<input type="button" class="button primary" onclick=" $('#queryType').val('login'); submit();" value="LOGIN"/>-->
                        <img src="images/spring/btnLogin1.png" class="btn-image" onclick=" $('#queryType').val('login'); submit();"/><br>
                        <a onclick="window.location='resetPassword.jsp'" style="font-size:12px;">Forgot Password?</a>
                    </div>

                    <div  style="width: 400px;float: left;border-left: 1px solid #666666;">
                        <span style="font-size: 20px; color: #79d858; font-weight: bold;">Sign up to join in</span><br><br>
                        <input class="signup" type="text" name="userName" id="userName"  placeholder="Name" /><br>
                        <input class="signup" type="text" name="email" id="email"   placeholder="Email Id"  /><br>
                        <input class="signup" type="text" name="emailConf" id="emailConf"   placeholder="Re-enter Email Id"  /><br>
                        <input class="signup" type="text" name="signupId" id="signupId"    placeholder="Login Name"  /><br>                                                        
                        <input class="signup" type="password" name="signupPass1"  id="signupPass"   placeholder="Password" /><br>                                                         
                        <input class="signup" type="password" name="signupPass2"  id="signupPass2"  placeholder="Re-enter Password" /><br><br>
                        <!--   <input class="signup" type="text" id="userQ1" name="userQ1"  placeholder="Enter a Secret Question"  /><br>
                           <input class="signup" type="text" name="userAns1"  id="userAns1"  placeholder="Answer to secret question" /><br>
                        <input class="button primary" type="button" id="btnNewUser" value="SIGN UP"  onclick="signup();"  />-->
                        <img src="images/spring/btnSignup1.png" class="btn-image" onclick=" signup();" />
                    </div>                        
                </div>
            </form>
            <br><br>
            <div class="footer_main1" style="vertical-align: middle;text-align: center;">
                <p style="color:white;">Copyright &copy; 2013 Upendra Prasad. Disclaimer: </p>
            </div>
        </div>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <script src="js/jsUtil.js" ></script>
        <script>
            var loginStatus = '${param.status}';
            //console.log(loginStatus);
            var msgStatus = '${param.message}';
            $(function(){
                checkLoginStatus();
                $(document).mouseup(function (e){
                    var container = $('#forgotPass');

                    if (!container.is(e.target) && container.has(e.target).length == 0) // ... nor a descendant of the container
                    {
                        container.slideUp('slow');
                    }
                });
            });
            


            function checkLoginStatus(){
                var eleLoginStatus = document.getElementById('divLoginStatus');
                if(loginStatus!=''){
                    if(loginStatus=='2'){ eleLoginStatus.innerHTML = 'Incorrect Login. Please try again.'; }
                    if(loginStatus=='0'){ eleLoginStatus.innerHTML = 'Incorrect Password. Please try again.'; }
                    if(loginStatus=='3'){ eleLoginStatus.innerHTML = 'Session Expired. Please re-login.'; }
                    if(loginStatus=='10'){ eleLoginStatus.innerHTML='You are now signed up. Please login.'; }
                    if(loginStatus=='9'){ eleLoginStatus.innerHTML=msgStatus; }
                }
                else { eleLoginStatus.innerHTML = 'Welcome. Please login to proceed.'; }
                setTimeout(function(){eleLoginStatus.style.display='none';}, 10000)
            }
          
            function signup(){
                var message="Corrections needed:";
                var error=false;
                if($('#userName').val()==''){message = message+"Please provide your name; ";error=true;}
                if($('#signupId').val()==''){message = message+"Please provide a valid login id; ";error=true;}
                else if($('#signupPass').val()!=$('#signupPass2').val()){message = message+"The passwords do not match; "; error=true;}
                else if(!isEmail(document.getElementById('email'))){message = message+"Not a valid email; ";error=true;}
                else if($('#email').val()!=$('#emailConf').val()){ message = message +"The emails do not match; ";error=true; }
                if(error){
                    var eleLoginStatus = document.getElementById('divLoginStatus');
                    eleLoginStatus.style.display='block';
                    eleLoginStatus.style.color='red';
                    eleLoginStatus.innerHTML = message; 
                    setTimeout(function(){eleLoginStatus.style.display='none';}, 10000);
                    event.preventDefault();
                }  else { 
                    $('#queryType').val('signup'); 
                    var frmEle = document.getElementsByName('loginForm')[0];frmEle.submit();}          
            }
          
            function isEmail(email) {
                var regex = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
                return regex.test(email.value);
            }
        </script>
    </body>
</html>

