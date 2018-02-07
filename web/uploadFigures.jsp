<%-- 
    Document   : uploadFigures
    Created on : Jun 25, 2014, 2:11:33 PM
    Author     : upendraprasad
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet"  type="text/css" href="/g2l/css/g2l_spring.css" />
        <link rel="stylesheet"  type="text/css" href="/g2l/css/common.css">
        <link rel="stylesheet"  type="text/css" href="/g2l/css/fig_upload.css">

        <title>g2l: Image Upload</title>
    </head>
    <body>
        <jsp:include page="gameMenuBar.jsp" />
        <div>            
            
            <div style="width:800px;margin: auto;" id="divFigContainer"> <br>  
                <div style="font-size: 14px;font-weight: bold;height: 30px;">Following is the list of images you have uploaded to date. 
                    <span style="color:blue;">Click on the image to edit.</span>
                    <a class="miniLink" id="aNewFig" style="float:right;">Upload New Image</a>
                </div>
                <!-- Table of images -->
                <table style="border: 1px solid green;font-size: 14px;width: 100%;background-color: green;" id="tblFigDetails">
                    <thead>
                        <tr>
                            <th>Fig Id</th>
                            <th>Caption/Source/KeyWords</th>
                            <th>Figure</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.allFig}" var="fig" varStatus="loop">
                            <tr>
                                <td>${fig.figId}</td>
                                <td>
                                    <span class="spanFigDesc">${fig.figCaption}</span>
                                    <span class="spanFigDesc">${fig.figSource}</span>
                                    <span class="spanFigDesc">${fig.figKeywords}</span>
                                </td>
                                <td><img src="/g2l/uploadedImages/${fig.figSaveName}" class="imgThumbUploaded" title="Click to edit."/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div><br>
            <!-- Figure Edit Box -->
            <div id="divPopContainerFig" class="divPopContainer">
                <div id="popHeader">Image Data Modification
                    <img src="/g2l/icons/closeBWRound.png" class="imgClosePop" />
                </div>
                <div id="editFigBox" class="popContent">
                    <div id="divFigMsg"></div>          
                    <form action="/FigureUpload?act=data" method="post" enctype="multipart/form-data">
                        <div style="float: left;width: 450px;">
                            <table>
                                <tbody>                                    
                                    <tr>
                                        <td><label for="figId">Figure Id </label><input name="figId" id="figId" class="ip1" type="hidden"/></td>
                                        <td >None</td>
                                    </tr>
                                    <tr>
                                        <td><label for="fileName">Select Image File </label>
                                        </td><td><input id="fileName" type="file" name="fileName"/></td>                                    
                                    </tr>
                                    <tr>
                                        <td><label for="figCaption">Captions</label></td>
                                        <td><input name="figCaption" id="figCaption" class="ip1" type="text"/></td>
                                    </tr>
                                    <tr>
                                        <td><label for="figKey">Key Words</label></td>
                                        <td><input name="figKey" id="figKey" class="ip1" type="text"/></td>
                                    </tr>
                                    <tr>
                                        <td><label for="figSource">Source</label></td>
                                        <td><input name="figSource" id="figSource" class="ip1" type="text"/></td>
                                    </tr>
                                    <tr>
                                        <td><label for="figStatus">Status</label></td>
                                        <td><select name="figStatus" id="figStatus" class="ip1">
                                                <option value=""> Leave Unchanged</option>
                                                <option value="0">Needs Approval</option>
                                                <option value="1">Needs Editing</option>
                                                <option value="2">Approved</option>                                                
                                                <option value="3">Discard</option>
                                            </select></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <img src="images/spring/btnSave1.png" class="btn-image" onclick="uploadImage();"/>  
                                            <a class="miniLink" id="aResetFig"> Reset for new figure</a>
                                            <div id="divLinkContainer">                                            
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>  
                        <div class="qFigBox"> <img src="/g2l/uploadedImages/0.jpg" class="thumbQFig" id="imgUpdate" /></div> 
                    </form>
                </div>
            </div>
        </div>
        <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
        <script  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>     
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script src="http://jquery-ui.googlecode.com/svn/tags/latest/ui/jquery.effects.core.js"></script>
        <script src="http://jquery-ui.googlecode.com/svn/tags/latest/ui/jquery.effects.slide.js"></script>
        <script type="text/javascript" src="/g2l/js/fig_upload.js" ></script>
        <script type="text/javascript" src="/g2l/js/jsUtil.js" ></script>
    </body>
</html>