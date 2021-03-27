<%-- 
    Document   : tabelaPrice
    Created on : 22 de mar. de 2021, 22:08:13
    Author     : RodrigoLopes
--%>

<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela Price</title>
    </head>
    <body>
         <%@include file="WEB-INF/jspf/header.jspf" %>
         <%@include file="WEB-INF/jspf/menu.jspf" %>
        <h1 align="center">Tabela Price</h1>
        <div align="center">
            <form>
                <h2 align="center">Informe os dados para o cálculo.</h2>

                <input type="text" name="vlEmprestimo" placeholder="Valor do Empréstimo "/>
                <br>
                <input type="text" name="vlJuros" placeholder="Taxa de Juros Mensal "/>
                <br>
                <input type="text" name="qtMeses" placeholder="Quantidade de meses "/>
                <br>
                <br>
                <input type="submit" value="Calcular"/>
                <br>
                <br>
            </form>
        </div>
        
        <%
            String vlEmprestimo = request.getParameter("vlEmprestimo");
            String vlJuros = request.getParameter("vlJuros");
            String qtMeses = request.getParameter("qtMeses");
            
            if((vlEmprestimo!="" && vlEmprestimo!=null)||(vlJuros!="" && vlJuros!=null)||(qtMeses!="" && qtMeses!=null)){
                try{
                    double valor = Double.parseDouble(vlEmprestimo);
                    double juros = Double.parseDouble(vlJuros);
                    int meses = Integer.parseInt(qtMeses);
                    juros = juros/100;
                    double valorParcela = 0;
                    double calculo = 0;
                    calculo = 1 + juros;
                    double calcJuros = 0;
                    double amort = 0;
                    double saldoDevedor = 0;
                    double jurosAtual = 0;                    
                    %>
                <div>
                    <table border="1"; align="center">
                        <tr>
                            <th>Período</th>
                            <th>Prestação</th>
                            <th>Juros</th>
                            <th>Amortização</th>
                            <th>Saldo Devedor</th>
                        </tr>
                        <tr>
                            <th>0</th>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <%= NumberFormat.getCurrencyInstance().format(valor) %>
                            </td>
                        </tr>
                        <tr>
                            <% 
                                valorParcela = valor * (juros/(1-(1/(Math.pow(calculo, meses)))));
                            
                                for(int i = 1; i <= meses; i++){
                                   
                                    calcJuros = valor * juros;
                                    amort = valorParcela - calcJuros;
                                    jurosAtual= valor * juros;
                                    saldoDevedor = valor - amort;
                                    
                            %>
                            <th><%= i %></th>
                            <td><%= NumberFormat.getCurrencyInstance().format(valorParcela) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(jurosAtual) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(amort) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(saldoDevedor) %></td>
                        </tr>
                        <%valor = valor - amort;%>
                        <%}%>
                    </table>
                <%}catch(Exception e){}}%>               
    <%@include file="WEB-INF/jspf/footer.jspf" %>
                </div>
    </body>
</html>