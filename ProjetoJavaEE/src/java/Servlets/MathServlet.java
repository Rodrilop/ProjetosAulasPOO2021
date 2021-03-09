/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author RodrigoLopes
 */
@WebServlet(name = "MathServlet", urlPatterns = {"/MathServlet.html"})
public class MathServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Calculadora</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h3><a href='index.html'>Voltar</a></h3>");
            out.println("<h1>Resultado</h1>");
            try{
                double n1 = Double.parseDouble(request.getParameter("n1"));
                out.println("<h2>N1 = "+n1+"</h2>");
                double n2 = Double.parseDouble(request.getParameter("n2"));
                out.println("<h2>N2 = "+n2+"</h2>");
                String oper = request.getParameter("oper");
                
                if ("somar".equals(oper)){
                double somar = n1 + n2;
                out.println("<h2>Soma = "+somar+"</h2>");
                } else if("subtrair".equals(oper)){
                double subtrair = n1 - n2;
                out.println("<h2>Subtração = "+subtrair+"</h2>");
                } else if("multiplicar".equals(oper)){
                double multiplicar = n1 * n2;
                out.println("<h2>Multiplição = "+multiplicar+"</h2>");
                } else {
                double dividir = n1 / n2;
                out.println("<h2>Divisão = "+dividir+"</h2>");
                }
            }catch (NumberFormatException ex){
            out.println("<h2>Ocorreu um Erro = "+ex.getLocalizedMessage()+"</h2>");                     
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
