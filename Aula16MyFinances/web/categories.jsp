<%-- 
    Document   : categories
    Created on : 7 de jun. de 2021, 20:46:48
    Author     : RodrigoLopes
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="db.Category"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Category> list = new ArrayList<>();
    try {
        if (request.getParameter("insert") != null) {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            Category.insert(name, description);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("delete") != null) {
            String name = request.getParameter("name");
            Category.delete(name);
            response.sendRedirect(request.getRequestURI());
        }
        list = Category.getList();
    } catch (Exception ex) {
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categorias - MyFinance$</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Categorias</h2>
        <%if (requestError != null) {%>
        <div style="color: red"><%= requestError%></div>
        <%}%>

        <%if (session.getAttribute("user.login") == null) {%>
        <div>Página restrita a usuários logados</div>
        <%} else {%>

        <form method="post">
            Nome: <input type="text" name="name"/>
            Descrição: <input type="text" name="description"/>
            <input type="submit" name="insert" value="Inserir"/>
        </form>
        <hr/>
        <table border="1">
            <tr>
                <th>Name</th>
                <th>Descrição</th>
                <th>Exclusão</th>
            </tr>
            <%for (Category c : list) {%>
            <tr>
                <td><%= c.getName()%></td>
                <td><%= c.getDescription()%></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="name" value="<%= c.getName()%>"/>
                        <input type="submit" name="delete" value="Excluir"/>
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
        <%}%>
    </body>
</html>