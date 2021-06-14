<%-- 
    Document   : disciplinas
    Created on : 14 de jun. de 2021, 16:43:46
    Author     : RodrigoLopes
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="db.Disciplina"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String requestError = null;
    ArrayList<Disciplina> list = new ArrayList<>();
    try{
        if(request.getParameter("insert")!=null){
            String nome = request.getParameter("nome");
            String dia_semana = request.getParameter("dia_semana");
            String horario = request.getParameter("horario");
            Double qtde_aulas = Double.parseDouble(request.getParameter("qtde_aulas"));
            Double nota_p1 = Double.parseDouble(request.getParameter("nota_p1"));
            Double nota_p2 = Double.parseDouble(request.getParameter("nota_p2"));
            Disciplina.insert(nome, dia_semana, horario, qtde_aulas, nota_p1, nota_p2);
            response.sendRedirect(request.getRequestURI());
        }else if(request.getParameter("delete")!=null){
            Long rowId = Long.parseLong(request.getParameter("rowId"));
            Disciplina.delete(rowId);
            response.sendRedirect(request.getRequestURI());
        }else if(request.getParameter("update")!=null){
            long rowId = Long.parseLong(request.getParameter("rowId"));
            Double nota_p1 = Double.parseDouble(request.getParameter("nota_p1"));
            Double nota_p2 = Double.parseDouble(request.getParameter("nota_p2"));
            Disciplina.update(rowId, nota_p1, nota_p2);
            response.sendRedirect(request.getRequestURI());
        }
        list = Disciplina.getList();
    }catch(Exception ex){
        requestError = ex.getMessage();
    }
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Disciplinas - Avaliação Poo P2</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <h2>Disciplinas</h2>
        <%if(requestError!=null){%>
        <div style="color: red"><%= requestError %></div>
        <%}%>
        
        <%if(session.getAttribute("user.login") == null){%>
            <div>Página restrita a usuários logados</div>
        <%}else{%>
        
        <%if (request.getParameter("prepareInsert") != null) {%>
        
        <fieldset>
            <legend>Incluir Disciplina</legend>
            <form method="post">
            Nome: <input type="text" name="nome"/>
            Dia da Semana: <input type="text" name="dia_semana"/>
            Horário: <input type="text" name="horario"/>
            Quantidade de Aulas: <input type="text" name="qtde_aulas"/>
            Nota P1: <input type="text" name="nota_p1"/>
            Nota P2: <input type="text" name="nota_p2"/>
                <hr/>
                <input type="submit" name="insert" value="Incluir"/>
                <input type="submit" name="cancel" value="Cancelar"/>
            </form>
        </fieldset>
        
        <%} else if(request.getParameter("prepareUpdate")!=null){%>       
        
        <fieldset>
            <legend>Alterar Notas</legend>
            <% long rowId = Long.parseLong(request.getParameter("rowId")); %>
            <% Disciplina d = Disciplina.get(rowId); %>
            <% if(d == null){ %>
                <div>O registro não foi encontrado.</div>
            <% } else{ %>
                <form method="post">
                    Nome:
                    <br/><input type="text" name="nome" readonly value="<%= d.getNome()%>"/>
                    <br/>Nota P1:
                    <br/><input type="number" name="nota_p1" value="<%= d.getNota_p1()%>"/>
                    <br/>Nota P2:
                    <br/><input type="number" name="nota_p2" value="<%= d.getNota_p2()%>"/>
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
                <input type="hidden" name="rowId" value="<%= request.getParameter("rowId") %>"/>sublime
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
                <th>Nome</th>
                <th>Dia da Semana</th>
                <th>Horário</th>
                <th>Quantidade de Aulas</th>
                <th>Nota P1</th>
                <th>Nota P2</th>
                <th>Comandos</th>
            </tr>
            <%for(Disciplina d: list){%>
                <tr>
                    <td><%= d.getRowId() %></td>
                    <td><%= d.getNome() %></td>
                    <td><%= d.getDia_semana() %></td>
                    <td><%= d.getHorario() %></td>
                    <td><%= d.getQtde_aulas() %></td>
                    <td><%= d.getNota_p1() %></td>
                    <td><%= d.getNota_p2() %></td>
                    <td>
                        <form method="post">
                            <input type="hidden" name="rowId" value="<%= d.getRowId()%>"/>
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