<%-- 
    Document   : users
    Created on : 14 de jun. de 2021, 16:30:56
    Author     : RodrigoLopes
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="db.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<User> users = new ArrayList<>();
    try {
        if (request.getParameter("insert") != null) {
            String login = request.getParameter("login");
            String name = request.getParameter("name");
            String role = request.getParameter("role");
            String password = request.getParameter("password");
            User.insertUser(login, name, role, password);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("delete") != null) {
            String login = request.getParameter("login");
            User.deleteUser(login);
            response.sendRedirect(request.getRequestURI());
        }
        users = User.getUsers();
    } catch (Exception ex) {
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuários</title>
        <link rel="icon" href="src/img/twm.png">
         <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/style.css"/>
        <style>
            ul{list-style-type: none; 
               line-height: 280%}
            input{line-height: 100%}
        </style>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Usuários</h2>
        <%if (requestError != null) {%>
        <div style="color: red"><%= requestError%></div>
        <%}%>

        <%if (session.getAttribute("user.login") == null) {%>
        <div>Página restrita a usuários logados</div>
        <%} else if (!session.getAttribute("user.role").equals("ADMIN")) {%>
        <div>Página restrita a administradores</div>
        <%} else {%>

        <form method="post">
            Login: <input type="text" name="login"/>
            Nome: <input type="text" name="name"/>
            Papel: <select name="role">
                <option value="ADMIN">ADMIN</option>
                <option value="USER">USER</option>
            </select>
            Senha: <input type="password" name="password"/>
            <input type="submit" name="insert" value="Inserir"/>
        </form>
        <hr/>
        <table border="1">
            <tr>
                <th>Login</th>
                <th>Name</th>
                <th>Role</th>
                <th>Exclusão</th>
            </tr>
            <%for (User user : users) {%>
            <tr>
                <td><%= user.getLogin()%></td>
                <td><%= user.getName()%></td>
                <td><%= user.getRole()%></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="login" value="<%= user.getLogin()%>"/>
                        <input type="submit" name="delete" value="Excluir"/>
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
        <%}%>
    </body>
</html>
