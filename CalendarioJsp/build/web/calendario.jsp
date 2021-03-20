<%-- 
    Document   : calendario
    Created on : 20 de mar. de 2021, 17:28:30
    Author     : RodrigoLopes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int ano=0, mes=0, dia=1, anoAtual=0, mesAtual=0, diaSemana=0, totalDias=1, data=1, i=0;
    String errorMessage = null;
    try{
        ano = Integer.parseInt(request.getParameter("ano"));
        mes = Integer.parseInt(request.getParameter("mes"));
        
        if(mes > 12){
            mes = 1;
            ano++;
        }else if (mes < 1){
            mes = 12;
            ano--;
        }
        java.util.Date calendar = new java.util.Date(ano-1900, mes-1, data);
        anoAtual = ano;
        mesAtual = mes;
        diaSemana = calendar.getDay();
    }catch(Exception ex){
        errorMessage = "Erro na leitura dos parâmetos";
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calendário - JSP</title>
    </head>
    <body>
        <a href="index.html">Voltar</a>
        <h1 align="center";>Calendário</h1>
        <%if(errorMessage != null){%>
        <div style="color: red"><%= errorMessage %></div>
        <%}else{%>

        <h2 align="center";>
            <form action="calendario.jsp">
                <input type="hidden" name="ano" value="<%=ano%>">
                <input type="hidden" name="mes" value="<%=mes-1%>">
                <input type="submit" value="<<">

        <table border="1"; align="center";><%
            if (mesAtual == 1){
                out.println("Janeiro");
                totalDias = 31;
            }else if (mesAtual == 2){
                out.println("Fevereiro");
                if ((ano % 4 == 0 && ano % 100 != 0) || ano % 400 == 0){
                    totalDias = 29;
                    }else{
                    totalDias = 28;
                    }
            }else if (mesAtual == 3){
                out.println("Março");
                totalDias = 31;
            }else if (mesAtual == 4){
                out.println("Abril");
                totalDias = 30;
            }else if (mesAtual == 5){
                out.println("Maio");
                totalDias = 31;
            }else if (mesAtual == 6){
                out.println("Junho");
                totalDias = 30;
            }else if (mesAtual == 7){
                out.println("Julho");
                totalDias = 31;
            }else if (mesAtual == 8){
                out.println("Agosto");
                totalDias = 31;
            }else if (mesAtual == 9){
                out.println("Setembro");
                totalDias = 30;
            }else if (mesAtual == 10){
                out.println("Outubro");
                totalDias = 31;
            }else if (mesAtual == 11){
                out.println("Novembro");
                totalDias = 30;
            }else if(mesAtual == 12){
                out.println("Dezembro");
                totalDias = 31;
            }%><%=anoAtual%>
                </form>
                <form action="calendario.jsp">
                    <input type="hidden" name="ano" value="<%=ano%>">
                    <input type="hidden" name="mes" value="<%=mes+1%>">
                    <input type="submit" value=">>">
                </form>
        </h2>
            <h3></h3>
                    <tr>
                        <th>Domingo</th>
                        <th>Segunda-feira</th>
                        <th>Terça-feira</th>
                        <th>Quarta-feira</th>
                        <th>Quinta-feira</th>
                        <th>Sexta-feira</th>
                        <th>Sábado</th>
                    </tr>

                    <tr>
                        <%for(int j = 0; j < 7; j++){%>    
                            <%if( j < diaSemana){%>
                            <td></td> 
                            <%}else{%>
                                <td><%= dia++ %></td> 
                            <%}%>
                        <%}%>
                    </tr>

                <%for (i = 0 ; i < 6; i++){%>
                    <tr>
                        <%for(int j = 0; j < 7; j++){%>  
                            <%if (dia <= totalDias){%>
                            <td><%= dia++ %></td>
                        <%}%>
                    <%}%>
                    </tr>
                <%}%>
            </table>
        <%}%>
    </body>
</html> 
