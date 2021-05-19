<%-- 
    Document   : users
    Created on : 17 de mai. de 2021, 21:26:36
    Author     : RodrigoLopes
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    if(request.getParameter("user.add") != null){
        User newUser = new User(
                request.getParameter("user.name"), 
                request.getParameter("user.email"), 
                request.getParameter("user.password").hashCode()
        );
        DatabaseUser.addUser(newUser);
        response.sendRedirect(request.getRequestURI());
    }else if (request.getParameter("user.remove") != null) {
        String email = request.getParameter("user.email");
        DatabaseUser.removeUser(email);
        response.sendRedirect(request.getRequestURI());
    }
    
    ArrayList<User> users = DatabaseUser.getUsers(); 
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários - Aula14WebApp</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Usuários</h2>
        <% if(session.getAttribute("session.name") == null) { %>
            <p>É preciso estar autenticado para acessar o conteúdo da página.</p>
            <p></p>
            <p>Favor fazer Login!</p>
        <% } else if(!session.getAttribute("session.name").equals("Administrador")) { %>
            <p>É preciso ser ADMIN para acessar o conteúdo da página.</p>
        <% } else { %>
        <form method="post">
            Nome: <input type="text" name="user.name"/>
            Email: <input type="text" name="user.email"/>
            Senha: <input type="password" name="user.password"/>
            <input type="submit" name="user.add" value="Adicionar"/>
        </form>
        <hr/>
        <table border="1">
            <tr>
                <th>Nome</th>
                <th>Email</th>
                <th>Exclusão</th>
            </tr>
            <% for(User user: users){ %>
            <tr>
                <td><%= user.getName() %></td>
                <td><%= user.getEmail() %></td>
                <td>
                    <form>
                        <input type="hidden" name="user.email" value="<%= user.getEmail() %>"/>
                        <input type="submit" name="user.remove" value="Remover"/>
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
        <% } %>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>