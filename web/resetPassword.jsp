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
                      <li ><a href="index.jsp">Home</a></li>
                      <li><a href="#">Contact</a></li>

                    </ul>
                  </div><!--/.nav-collapse -->
                </div>
              </nav>
                   <div id="statusMsg"  class="alert alert-info" role="alert"> </div> 

    <div class="container">
        <h2>Reset Your Password</h2>
        <p class="lead">Please request a token from the administrator for resetting lost password.</p>
      </div>
             <hr>
            <div class="col-md-8 col-xs-10" style="float:none; margin: auto;">
                <form name="loginForm" method="post" action="authenticate"  onsubmit="return false;"><input type="hidden" name="queryType" id="queryType" value="forgot"/>
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-xs-12 form-group">
                                        <input class="form-control" type="text" name="token" id="token"    placeholder="Your token for password reset." required="true" />
                                    </div>
                                    <div class="col-md-6 col-sm-6 col-xs-12 form-group">
                                        <input class="form-control" type="email" name="email" id="email"   placeholder="Your registered email id." required="true" />
                                    </div>                                    
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-sm-6 col-xs-12 form-group">
                                        <input class="form-control" type="password" name="signupPass1"  id="signupPass1"   placeholder="New password" required="true"/>
                                    </div>
                                    <div class="col-md-6 col-sm-6 col-xs-12 form-group">
                                        <input class="form-control" type="password" name="signupPass2"  id="signupPass2"  placeholder="Re-enter Password" required="true" />
                                    </div>
                                </div>  
                            <!--<small>Please note that password are not saved in the database.</small>-->
                            <button class="btn btn-primary btn-block" id="resetPass"> Reset Password</button>
                        </form>    
            </div>  

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="./bootstrap/jsjquery.min.js"><\/script>')</script>
 

        <script>
            $(function(){
                $('#resetPass').click(function(){
                    //alert("Reset Pass.");
                    if($('#signupPass1').val()!=$('#signupPass2').val()){alert("Passwords do not match."); return false;}
                    $.ajax({
                        url: 'authenticate',  //server script to process data
                        type: 'POST',
                        data: { queryType:'forgot',
                                email:$('#email').val(), 
                                signupPass1:$('#signupPass1').val(),
                                token:$('#token').val()
                              },
                        success: function(data) {
                            $('#statusMsg').html(data);
                            //alert("Image Id is:"+$('#imgId').val());
                        },
                        error: function(jqXHR, textStatus, errorMessage) {
                            $('#statusMsg').html("There was some problem. Please try again.");
                            //console.log(errorMessage); // Optional
                        }
                    });
                });
            });
        </script>
    </body>
</html>
