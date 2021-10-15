<%-- 
    Document   : index
    Created on : 14 de jun. de 2021, 16:05:13
    Author     : RodrigoLopes
--%>

<%@page import="db.Disciplina"%>
<%@page import="db.Produto"%>
<%@page import="db.Servico"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Produto> list = new ArrayList<>();
    try{
        list = Produto.getList();
    }catch(Exception ex){
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TALK WITH ME</title>
         <link rel="icon" href="src/img/twm.png">
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Início</h2>
        <div align="center">
        <h1 class="title" align="center">Bem Vindo ao TALK WITH ME</h1>
        <h3 class="Subtitle" align="center">Aqui você é sabe quando seus produtos e serviços estão vindo até você</h3>
        </div>
 <hr/>
        
        <% String login = (String) session.getAttribute("user.login");%>
        <%if(login == null){%>
            <div>Esta página é restrita a usuários logados.</div>
        <%}else{%>
        <table border="1" align="center">
            <tr>
                <th>Nome Produto</th>
                <th>Peso</th>
                <th>Volume</th>
            </tr>
             <%for(Produto p: list){%>
                <tr>
                    <td><%= p.getNm_produto() %></td>
                    <td><%= p.getPeso() %></td>
                    <td><%= p.getVolume()%></td>
                </tr>
            <%}%>
        </table>
         <%}%>
    </body>
</html>
