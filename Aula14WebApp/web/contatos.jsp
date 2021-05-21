<%-- 
    Document   : contatos
    Created on : 17 de mai. de 2021, 21:50:26
    Author     : RodrigoLopes
--%>

<%@page import="br.edu.fatecpg.web.Contato"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    if(request.getParameter("contato.add") != null){
        Contato newContato = new Contato(
                request.getParameter("contato.name"),
                request.getParameter("contato.telefone"), 
                request.getParameter("contato.email") 
        );
        Database.addContato(newContato);
        response.sendRedirect(request.getRequestURI());
    }else if (request.getParameter("contato.remove") != null) {
        String email = request.getParameter("contato.email");
        Database.removeContato(email);
        response.sendRedirect(request.getRequestURI());
    }
    
    ArrayList<Contato> contatos = Database.getContatos(); 
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contatos - Aula14WebApp</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Contatos</h2>
        <% if(session.getAttribute("session.name") == null) { %>
            <p>É preciso estar autenticado para acessar o conteúdo da página.</p>
            <p></p>
            <p>Favor fazer Login!</p>
        <% } else { %>
        <form method="post">
            Nome: <input type="text" name="contato.name"/>
            Telefone: <input type="text" name="contato.telefone"/>
            Email: <input type="text" name="contato.email"/>
            <input type="submit" name="contato.add" value="Adicionar"/>
        </form>
        <hr/>
        <table border="1">
            <tr>
                <th>Nome</th>
                <th>Telefone</th>
                <th>Email</th>
                <th>Exclusão</th>
            </tr>
            <% for(Contato contato: contatos){ %>
            <tr>
                <td><%= contato.getName() %></td>
                <td><%= contato.getTelefone() %></td>
                <td><%= contato.getEmail() %></td>
                <td>
                    <form>
                        <input type="hidden" name="contato.email" value="<%= contato.getEmail() %>"/>
                        <input type="submit" name="contato.remove" value="Remover"/>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
        <% } %>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>