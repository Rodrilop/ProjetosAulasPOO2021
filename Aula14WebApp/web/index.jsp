<%-- 
    Document   : index
    Created on : 17 de mai. de 2021, 21:10:45
    Author     : RodrigoLopes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aula14WebApp</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Início</h2>
        <% if(session.getAttribute("session.name") == null) { %>
            <p>É preciso estar autenticado para acessar o conteúdo da página.</p>
            <p></p>
            <p>Favor fazer Login!</p>
        <% } else { %>
            <p>Blablabla...</p>
        <% } %>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
