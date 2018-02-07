

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
            <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <!--<link rel="icon" href="../../favicon.ico">-->

    <!-- Bootstrap core CSS -->
    <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet">
     <link href="./css/g2l_boot.css" rel="stylesheet">
        <link rel="stylesheet"  type="text/css" href="./css/g2l_spring.css">

        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <title>g2l: Login</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        


        <style>    

            #divLoginStatus{position:absolute; z-index: 5; width: 100%;
                             
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
            #outerDiv2{vertical-align: middle;margin: auto;
                       width: 800px;padding: 15px; background-color: rgba(0,0,0,0.2);
                       height:440px;border-radius: 10px;
            }
            #outerDiv1{ background-color: rgba(255,255,255,0.8);height:800px;    }
            .forgotPassBox{float:left;width:300px;background-color:  #79d858; border-radius: 10px;
                           margin: 5px;padding: 10px;box-shadow: 0px 2px 4px 1px #666666; color: #666666; height: 120px;}
            .signup{ width: 250px;height: 35px;font-size: 16px; border:green 1px solid; color: #666666; }
        </style>

    </head>

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
                      <a href="#" class="navbar-left"><img src="./images/g2l_Logo.png" alt="logo" class="image_responsive" style="height:3.4em;"></a>
                  </div>
                  <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                      <li ><a href="#">Home</a></li>
                      <li><a href="#">Contact</a></li>

                    </ul>
                  </div><!--/.nav-collapse -->
                </div>
              </nav>
                    <div id="divLoginStatus"  class="alert alert-info" role="alert"></div>             
        <div class="container">
 
               <!-- <div id="bannerGame2Learn" >
                    <table style="width:100%"><tr>
                            <td style="width:4em;"></td>
                            <td style="width:10em"> 
                                <img style="width: 250px" src="images/g2l_Logo.png" /></td>
                            <td style="width:auto;vertical-align: middle;text-align: right;">
                                
                            </td></tr>
                    </table>                     
                </div>-->

                
                <div class="col-md-6 col-sm-8 col-xs-12 form-group" style="margin:auto; float:none;margin-top: 4em;">
                    <form name="loginForm" action="authenticate"  method="post" class="inline-form"><input type="hidden" name="queryType" id="queryType"/>
                                    <input type="text" id="userId" name="userId" value="" placeholder="Login: your banner id" class="form-control" /><br>
                                    <input type="password" id="userPass" name="userPass" value=""  placeholder="Password" class="form-control" /> <br>
                                    <!--<input type="button" class="button primary" onclick=" $('#queryType').val('login'); submit();" value="LOGIN"/>-->
                                    <button type="button" class="btn btn-primary btn-block" onclick=" $('#queryType').val('login'); submit();">Sign in</button>
                                    <!--<img src="images/spring/btnLogin1.png" class="btn-image" onclick=" $('#queryType').val('login'); submit();" style="margin-bottom:-10px;"/>-->
                                    <br><a href="./student/signup.html" class="btn btn-success btn-block">Sign up</a><br><br>
                                    <a href="resetPassword.jsp" >Forgot Password?</a>
                                    
                              </form>
                </div>
                <!--Forgot Password --s
                <div   id="forgotPass1">
                    <div id="forgotPassBox1" style="" class="forgotPassBox"> Password reset by email.<br><br>
                        <label for="userId3"> User id <input type="text" name="userId3" value=""   id="userId3"  /></label><br/>
                        <label for="emailRecepient">Email id<input type="text" name="emailRecepient"  id="emailRecepient"  value="" /></label><br>
                        <input type="button" class="button primary" id="btnForgotPass" value="SUBMIT"  onclick=" $('#queryType').val('forgotPass'); submit();" />                       
                    </div> 
                    <div style="float: left;vertical-align: middle;width: 50px; font: 24px bold;height: 120px;" > OR </div>
                    <div id="forgotPassBox2" style="" class="forgotPassBox"> Login retrieval and password reset.<br><br>
                        <label for="userId3"> Secret Question 1 <input type="text" name="secretQ1" value=""   id="secretQ1"  /></label><br/>
                        <label for="emailRecepient">Secret Question 2 <input type="text" name="secretQ2"  id="secretQ2"  value="" /></label><br>
                        <input type="button" class="button primary" id="btnForgotPass" value="SUBMIT"  onclick=" $('#queryType').val('forgotPass'); submit();" />                       
                    </div>
                </div><br><br>

                <!-- SIGN UP and Info --
                <div id="outerDiv22" style="width:60vw; margin:auto; float:none;">                
                    <!--<div id="divUses">
                        <br>
                        Practice Test<br><br>
                        Vocabulary Practice<br><br>
                        Question Bank of Tests<br><br>
                        Educational Games<br><br>
                        Online Test Assignments<br><br>
                    </div>--

                    <div id="newUserSignUp11" style="width:100%; background: #DFDFDF; padding: 2vw;">
                        <span style="font-size: 20px; color: #888888; font-weight: bold;">Sign up to join in.</span><br><br>
                        <input class="signup" type="text" name="userName" id="userName"  placeholder="Your name" /><br>
                        <input class="signup" type="text" name="email" id="email"   placeholder="Email id"  /><br>
                        <input class="signup" type="text" name="emailConf" id="emailConf"   placeholder="Re-enter Email id"  /><br>
                        <input class="signup" type="text" name="signupId" id="signupId"    placeholder="Login Name"  /><br>                                                        
                        <input class="signup" type="password" name="signupPass1"  id="signupPass1"   placeholder="Password" /><br>                                                         
                        <input class="signup" type="password" name="signupPass2"  id="signupPass2"  placeholder="Re-enter Password" /><br><br>
                        <!--   <input class="signup" type="text" id="userQ1" name="userQ1"  placeholder="Enter a Secret Question"  /><br>
                           <input class="signup" type="text" name="userAns1"  id="userAns1"  placeholder="Answer to secret question" /><br>
                        <input class="button primary" type="button" id="btnNewUser" value="SIGN UP"  onclick="signup();"  />--
                        <img src="images/spring/btnSignup1.png" class="btn-image" onclick=" signup();" />
                    </div>                        
                </div>-->
            <br><br>
            <footer>
                <div class="footer_main1" style="vertical-align: middle;text-align: center;">
                <p>Copyright &copy; 2016 Upendra Prasad. Disclaimer: </p>
            </div>
            </footer>
            
        </div>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <script src="./js/jsUtil.js" ></script>
          <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="./bootstrap/js/jquery.min.js"><\/script>')</script>
    <script src="./bootstrap/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug --
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>-->
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
                    if(loginStatus=='2'){ eleLoginStatus.innerHTML = 'FAIL: Incorrect Login. Please try again.'; }
                    if(loginStatus=='0'){ eleLoginStatus.innerHTML = 'FAIL: Incorrect Password. Please try again.'; }
                    if(loginStatus=='3'){ eleLoginStatus.innerHTML = 'Session Expired. Please re-login.'; }
                    if(loginStatus=='10'){ eleLoginStatus.innerHTML='SUCCESS: You are now signed up. Please login.'; }
                    if(loginStatus=='9'){ eleLoginStatus.innerHTML='SUCCESS: You have been successfully logged out.'; }
                    if(loginStatus=='11'){ eleLoginStatus.innerHTML='FAIL: The login id already exists. Please try some other id.'; }
                    if(loginStatus=='12'){ eleLoginStatus.innerHTML='FAIL: A user with the given email already exists. Please try some other.'; }
                }
                else { 
                    eleLoginStatus.innerHTML = 'Welcome. Please login to proceed.'; 
                }
                setTimeout(function(){
                    eleLoginStatus.style.display='none';
                }, 10000);
            }
          
            function signup(){
                var message="Corrections needed:";
                var error=false;
                if($('#userName').val()==''){message = message+"Please provide your name; ";error=true;}
                if($('#signupId').val()==''){message = message+"Please provide a valid login id; ";error=true;}
                else if($('#signupPass1').val()!=$('#signupPass2').val()){message = message+"The passwords do not match; "; error=true;}
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
                    var frmEle = document.getElementsByName('loginForm')[0];frmEle.submit();
                }          
            }
          
            function isEmail(email) {
                var regex = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
                return regex.test(email.value);
            }
        </script>
    </body>
</html>
