<%-- 
    Document   : UploadImages
    Created on : Apr 16, 2013, 10:05:39 AM
    Author     : upendraprasad
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>g2l: Image Upload</title>
    </head>
    <body>
        <div>
            <h2>Image Upload</h2>
            <div style="width:900px;height: 400px;margin: auto; overflow-y: auto;">
                <table border="1">
                    <thead>
                        <tr>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.allFig}" var="fig" varStatus="loop">
                        <tr>
                            <td>${loop.index}</td>
                            <td>${fig.id}</td>
                            <td>${fig.caption}</td>
                            <td>${fig.source}</td>
                            <td>${fig.keywords}</td>
                            <td><img src="/g2l/uploadedImages/${fig.figSaveName}" class="thumbQFig"/></td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
            <form action="fileuploadexample" method="post" enctype="multipart/form-data">
                <label for="fileName">Select Image File: </label>
                <input id="fileName" type="file" name="fileName"/><br/>            
                <input type="submit" value="Upload"/>
            </form>
        </div>
    </body>
</html>
