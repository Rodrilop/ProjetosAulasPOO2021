<%-- 
    Document   : disciplinas
    Created on : 11 de abr. de 2021, 14:36:49
    Author     : RodrigoLopes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DISCIPLINAS</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
     <%
        if (session.getAttribute("session.username") != null) {%>
        
       <div>
                    <table border="1"; align="center">
                        <tr>
                            <th>Disciplinas</th>
                            <th>Nota P1</th>
                            <th>Nota P2</th>
                        </tr>
                        <tr>
                            <th><%= %></th>
                            <td><%= %></td>
                            <td><%= %></td>
                        </tr>
                        <%}%>
                    </table> 
        
        
        
        
        
        
        <%}else{%>
            Você precisa estar identificado para ter acesso a esse conteúdo.
        <%}%>
    </body>
</html>