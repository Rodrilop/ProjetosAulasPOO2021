<%-- 
    Document   : transactions
    Created on : 7 de jun. de 2021, 20:54:06
    Author     : RodrigoLopes
--%>

<%@page import="db.Category"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.Transaction"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Transaction> list = new ArrayList<>();
    try {
        if (request.getParameter("insert") != null) {
            String datetime = request.getParameter("datetime");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            double value = Double.parseDouble(request.getParameter("value"));
            String origin = request.getParameter("origin");
            Transaction.insert(datetime, description, category, value, origin);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("update") != null) {
            long rowId = Long.parseLong(request.getParameter("rowId"));
            String datetime = request.getParameter("datetime");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            double value = Double.parseDouble(request.getParameter("value"));
            String origin = request.getParameter("origin");
            Transaction.update(rowId, datetime, description, category, value, origin);
            response.sendRedirect(request.getRequestURI());
        } else if (request.getParameter("delete") != null) {
            long rowId = Long.parseLong(request.getParameter("rowId"));
            Transaction.delete(rowId);
            response.sendRedirect(request.getRequestURI());
        }
        list = Transaction.getList();
    } catch (Exception ex) {
        requestError = ex.getMessage();
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transações - MyFinance$</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Transações</h2>
        <%if (requestError != null) {%>
        <div style="color: red"><%= requestError%></div>
        <%}%>

        <%if (session.getAttribute("user.login") == null) {%>
        <div>Página restrita a usuários logados</div>
        <%} else {%>

        <%if (request.getParameter("prepareInsert") != null) {%>

        <fieldset>
            <legend>Incluir Transação</legend>
            <form method="post">
                Data/hora:
                <br/><input type="datetime-local" name="datetime" value="<%= new SimpleDateFormat("yyyy-MM-dd'T'hh:mm").format(new Date())%>"/>
                <br/>Descrição:
                <br/><input type="text" name="description"/>
                <br/>Categoria:
                <br/><select name="category">
                    <option value=""></option>
                    <%for (Category c : Category.getList()) {%>
                    <option value="<%= c.getName()%>"><%= c.getName()%></option>
                    <%}%>
                </select>
                <br/>Valor:
                <br/><input type="number" step="0.01" name="value"/>
                <br/>Origem:
                <br/><input type="text" name="origin"/>
                <hr/>
                <input type="submit" name="insert" value="Incluir"/>
                <input type="submit" name="cancel" value="Cancelar"/>
            </form>
        </fieldset>

        <%} else if (request.getParameter("prepareUpdate") != null) {%>

        <fieldset>
            <legend>Alterar Transação</legend>
            <% long rowId = Long.parseLong(request.getParameter("rowId")); %>
            <% Transaction t = Transaction.get(rowId); %>
            <% if (t == null) { %>
            <div>O registro não foi encontrado.</div>
            <% } else {%>
            <form method="post">
                Data/hora:
                <br/><input type="datetime-local" name="datetime" value="<%= t.getDatetime()%>"/>
                <br/>Descrição:
                <br/><input type="text" name="description" value="<%= t.getDescription()%>"/>
                <br/>Categoria:
                <br/><select name="category">
                    <option value=""></option>
                    <%for (Category c : Category.getList()) {%>
                    <option value="<%= c.getName()%>" <%= c.getName().equals(t.getCategory()) ? "selected" : ""%>>
                        <%= c.getName()%>
                    </option>
                    <%}%>
                </select>
                <br/>Valor:
                <br/><input type="number" step="0.01" name="value" value="<%= t.getValue()%>"/>
                <br/>Origem:
                <br/><input type="text" name="origin" value="<%= t.getOrigin()%>"/>
                <input type="hidden" name="rowId" value="<%= request.getParameter("rowId")%>"/>
                <hr/>
                <input type="submit" name="update" value="Alterar"/>
                <input type="submit" name="cancel" value="Cancelar"/>
            </form>
            <% }  %>
        </fieldset>

        <%} else if (request.getParameter("preparedelete") != null) {%>

        <fieldset>
            <legend>Remover Transação</legend>
            <form method="post">
                Remover o registro <%= request.getParameter("rowId")%>?
                <input type="hidden" name="rowId" value="<%= request.getParameter("rowId")%>"/>
                <hr/>
                <input type="submit" name="delete" value="Remover"/>
                <input type="submit" name="cancel" value="Cancelar"/>
            </form>
        </fieldset>

        <%} else {%>

        <form method="post">
            <input type="submit" name="prepareInsert" value="Incluir"/>
        </form>

        <%}%>

        <hr/>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Data / hora</th>
                <th>Descrição</th>
                <th>Categoria</th>
                <th>Valor</th>
                <th>Origem</th>
                <th>Comandos</th>
            </tr>
            <%for (Transaction t : list) {%>
            <tr>
                <td><%= t.getRowId()%></td>
                <td><%= t.getDatetime()%></td>
                <td><%= t.getDescription()%></td>
                <td><%= t.getCategory()%></td>
                <td><%= t.getValue()%></td>
                <td><%= t.getOrigin()%></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="rowId" value="<%= t.getRowId()%>"/>
                        <input type="submit" name="prepareUpdate" value="Alterar"/>
                        <input type="submit" name="preparedelete" value="Excluir"/>
                    </form>
                </td>
            </tr>
            <%}%>
        </table> 
        <%}%>
    </body>
</html>