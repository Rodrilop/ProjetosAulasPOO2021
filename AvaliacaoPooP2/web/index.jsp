<%-- 
    Document   : index
    Created on : 14 de jun. de 2021, 16:05:13
    Author     : RodrigoLopes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Avaliação Poo P2</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Início</h2>
        <div align="center">
            <h4>RA: 1290481923049</h4>
            <h3>Rodrigo Carlos de Souza Lopes</h3>
            <h4>Ingresso na Fatec no 2° Semestre de 2019</h4>
            <a href="https://github.com/Rodrilop/ProjetosAulasPOO2021" target="_blank">https://github.com/Rodrilop/ProjetosAulasPOO2021</a>
        </div>
        <hr/>
        <% String login = (String) session.getAttribute("user.login");%>
        <%if (login == null) {%>
        <div>Esta página é restrita a usuários logados.</div>
        <%} else {%>
        <table border="1" align="center">
            <tr>
                <th>Nome</th>
                <th>Nota P1</th>
                <th>Nota P2</th>
                <th>Média</th>
            </tr>
            <%for (Disciplina d : list) {%>
            <tr>
                <td><%= d.getNome()%></td>
                <td><%= d.getNota_p1()%></td>
                <td><%= d.getNota_p2()%></td>
                <td><%= (d.getNota_p1() + d.getNota_p2()) / 2%></td>
            </tr>
            <%}%>
        </table>
        <%}%>
    </body>
</html>
