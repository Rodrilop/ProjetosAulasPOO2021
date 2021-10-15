<%-- 
    Document   : servicos
    Created on : 5 de out. de 2021, 19:50:58
    Author     : Diego da Cunha Silva
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="db.Servico"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Servico> list = new ArrayList<>();
    try{
        if(request.getParameter("insert")!=null){
            String nm_servico = request.getParameter("nm_servico");
            String nm_prestador = request.getParameter("nm_prestador");
            String nm_cliente = request.getParameter("nm_cliente");            
            String dt_servico = request.getParameter("dt_servico");
            Servico.insert(nm_servico, nm_prestador, nm_cliente, dt_servico);
            response.sendRedirect(request.getRequestURI());
        }else if(request.getParameter("delete")!=null){
            Long rowId = Long.parseLong(request.getParameter("rowId"));
            Servico.delete(rowId);
            response.sendRedirect(request.getRequestURI());
        }else if(request.getParameter("update")!=null){
            long rowId = Long.parseLong(request.getParameter("rowId"));
            String dt_servico = request.getParameter("dt_servico");
            Servico.update(rowId, dt_servico);
            response.sendRedirect(request.getRequestURI());
        }
        list = Servico.getList();
    }catch(Exception ex){
        requestError = ex.getMessage();
    }
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Serviços</title>
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
        <h2>Serviços</h2>
        <%if(requestError!=null){%>
        <div style="color: red"><%= requestError %></div>
        <%}%>
        
        <%if(session.getAttribute("user.login") == null){%>
            <div>Página restrita a usuários logados</div>
        <%}else{%>
        
        <%if (request.getParameter("prepareInsert") != null) {%>
        
        <fieldset>
            <legend>Cadastrar Serviço</legend>
            <form method="post">
            Nome Serviço: <input type="text" name="nm_servico"/>
            Nome do Prestador <input type="text" name="nm_prestador"/>
            Nome do Cliente <input type="text" name="nm_cliente"/>
            Data do Serviço: <input type="date" name="dt_servico"/>
                <hr/>
                <input type="submit" name="insert" value="Incluir"/>
                <input type="submit" name="cancel" value="Cancelar"/>
            </form>
        </fieldset>
        
        <%} else if(request.getParameter("prepareUpdate")!=null){%>       
        
        <fieldset>
            <legend>Alterar Servico</legend>
            <% long rowId = Long.parseLong(request.getParameter("rowId")); %>
            <% Servico s = Servico.get(rowId); %>
            <% if(s == null){ %>
                <div>O registro não foi encontrado.</div>
            <% } else{ %>
                <form method="post">
                    Nome do Servico:
                    <br/><input type="text" name="nm_servico" readonly value="<%= s.getNm_servico()%>"/>
                    <br/>Nome do Prestador:
                    <br/><input type="text" name="nm_prestador" readonly value="<%= s.getNm_prestador()%>"/>
                    <br/>Nome fo Cliente:
                    <br/><input type="text" name="nm_cliente" readonly value="<%= s.getNm_cliente()%>"/>
                    <br/>Data do Serviço
                    <br/><input type="date" name="dt_servico" value="<%= s.getDt_servico()%>"/>
                    <input type="hidden" name="rowId" value="<%= request.getParameter("rowId") %>"/>
                    <hr/>
                    <input type="submit" name="update" value="Alterar"/>
                    <input type="submit" name="cancel" value="Cancelar"/>
                </form>
            <% } %>
        </fieldset>

        <%} else if(request.getParameter("preparedelete")!=null){%>
        
        <fieldset>
            <legend>Remover Disciplina</legend>
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
                <th>Nome Serviço</th>
                <th>Nome do Prestador</th>
                <th>Nome do Cliente</th>
                <th>Data do Serviço</th>
                <th>Comandos</th>
            </tr>
            <%for(Servico s: list){%>
                <tr>
                    <td><%= s.getRowId() %></td>
                    <td><%= s.getNm_servico()%></td>
                    <td><%= s.getNm_prestador()%></td>
                    <td><%= s.getNm_cliente()%></td>
                    <td><%= s.getDt_servico()%></td>
                    <td>
                        <form method="post">
                            <input type="hidden" name="rowId" value="<%= s.getRowId()%>"/>
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