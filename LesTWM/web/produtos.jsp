<%-- 
    Document   : produto
    Created on : 5 de out. de 2021, 20:30:41
    Author     : Diego da Cunha Silva
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="db.Produto"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Produto> list = new ArrayList<>();
    try{
        if(request.getParameter("insert")!=null){
            String nm_produto = request.getParameter("nm_produto");
            Double peso = Double.parseDouble(request.getParameter("peso"));
            Double volume = Double.parseDouble(request.getParameter("volume"));
            Produto.insert(nm_produto, peso, volume);
            response.sendRedirect(request.getRequestURI());
        }else if(request.getParameter("delete")!=null){
            Long rowId = Long.parseLong(request.getParameter("rowId"));
            Produto.delete(rowId);
            response.sendRedirect(request.getRequestURI());
        }else if(request.getParameter("update")!=null){
            long rowId = Long.parseLong(request.getParameter("rowId"));
            Double peso = Double.parseDouble(request.getParameter("peso"));
            Double volume = Double.parseDouble(request.getParameter("volume"));
            Produto.update(rowId, peso, volume);
            response.sendRedirect(request.getRequestURI());
        }
        list = Produto.getList();
    }catch(Exception ex){
        requestError = ex.getMessage();
    }
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Produtos</title>
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
        <h2>Produtos</h2>
        <%if(requestError!=null){%>
        <div style="color: red"><%= requestError %></div>
        <%}%>
        
        <%if(session.getAttribute("user.login") == null){%>
            <div>Página restrita a usuários logados</div>
        <%}else{%>
        
        <%if (request.getParameter("prepareInsert") != null) {%>
        
        <fieldset>
            <legend>Cadastrar Produto</legend>
            <form method="post">
            Nome Produto: <input type="text" name="nm_produto"/>
            Peso: <input type="text" name="peso"/>
            Volume: <input type="text" name="volume"/>
                <hr/>
                <input type="submit" name="insert" value="Incluir"/>
                <input type="submit" name="cancel" value="Cancelar"/>
            </form>
        </fieldset>
        
        <%} else if(request.getParameter("prepareUpdate")!=null){%>       
        
        <fieldset>
            <legend>Alterar Produto</legend>
            <% long rowId = Long.parseLong(request.getParameter("rowId")); %>
            <% Produto p = Produto.get(rowId); %>
            <% if(p == null){ %>
                <div>O registro não foi encontrado.</div>
            <% } else{ %>
                <form method="post">
                    Nome:
                    <br/><input type="text" name="nm_produto" readonly value="<%= p.getNm_produto()%>"/>
                    <br/>Nota P1:
                    <br/><input type="number" name="peso" value="<%= p.getPeso()%>"/>
                    <br/>Nota P2:
                    <br/><input type="number" name="volume" value="<%= p.getVolume()%>"/>
                    <input type="hidden" name="rowId" value="<%= request.getParameter("rowId") %>"/>
                    <hr/>
                    <input type="submit" name="update" value="Alterar"/>
                    <input type="submit" name="cancel" value="Cancelar"/>
                </form>
            <% } %>
        </fieldset>

        <%} else if(request.getParameter("preparedelete")!=null){%>
        
        <fieldset>
            <legend>Remover Produto</legend>
            <form method="post">
                Remover o registro <%= request.getParameter("rowId") %>?
                <input type="hidden" name="rowId" value="<%= request.getParameter("rowId") %>"/>
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
                <th>Nome Produto</th>
                <th>Peso</th>
                <th>Volume</th>
                <th>Comandos</th>
            </tr>
            <%for(Produto p: list){%>
                <tr>
                    <td><%= p.getRowId() %></td>
                    <td><%= p.getNm_produto()%></td>
                    <td><%= p.getPeso()%></td>
                    <td><%= p.getVolume() %></td>
                    <td>
                        <form method="post">
                            <input type="hidden" name="rowId" value="<%= p.getRowId()%>"/>
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