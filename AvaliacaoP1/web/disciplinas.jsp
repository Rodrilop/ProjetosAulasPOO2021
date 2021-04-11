<%-- 
    Document   : disciplinas
    Created on : 11 de abr. de 2021, 10:06:15
    Author     : RodrigoLopes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="minhasDisciplinas.Disciplina" %>
<%@page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Disciplinas</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <%
            if (session.getAttribute("session.username") != null) {%>
            <h1 align="center">Minhas Disciplinas</h1>
        <%
            ArrayList<Disciplina> disciplinas = (ArrayList)application.getAttribute("disciplinas");
            
            if(disciplinas == null){
                disciplinas = Disciplina.getList();
            }
            
            String[] notasP1 = request.getParameterValues("notas P1");
            String[] notasP2 = request.getParameterValues("notas P2");
            
            if(notasP1 != null && notasP2 != null){
                for(int i = 0; i < disciplinas.size(); i++){
                    disciplinas.get(i).setNotaP1(Double.parseDouble(notasP1[i]));
                    disciplinas.get(i).setNotaP2(Double.parseDouble(notasP2[i]));
                }
            application.setAttribute("disciplinas", disciplinas);
            }
        %>
        
        <form>
             <div>
                <table border="1"; align="center">
                    <tr>
                        <th>Disciplinas</th>
                        <th>Nota P1</th>
                        <th>Nota P2</th>
                    </tr>
                    <%for(Disciplina disciplina: disciplinas){%>
                        <tr>
                            <td><b><%= disciplina.getNome() %></b></td>
                            <td><input type="text" name="notas P1" value="<%= disciplina.getNotaP1()%>"></td>
                            <td><input type="text" name="notas P2" value="<%= disciplina.getNotaP2()%>"></td>
                        </tr>
                    <%}%>
                </table>
            </div>
            <div align="center">
            <br/>    
            <input type="submit" value="Enviar">
            </div>
        </form>
        <%}else{%>
            Você precisa estar identificado para ter acesso a esse conteúdo.
        <%}%>
    </body>
</html>
