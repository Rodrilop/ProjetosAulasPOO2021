<%-- 
    Document   : index
    Created on : 29 de mar. de 2021, 20:28:42
    Author     : RodrigoLopes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page 1 - SessionApp</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        <% if (session.getAttribute("session.username") == null) {%>
            <div style="color: red">
                Você precisa estar identificado para ter acesso a esee conteúdo.
            </div>
        <%}else{%>
        <h2>PAGE 1</h2>
        <p>Página 1 (hum) do site de demostração do HttpSession.</p>
        <%}%>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>
