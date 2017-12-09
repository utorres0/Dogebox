/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Conexion;
import modelo.Fechas;

/**
 *
 * @author oneee
 */
@WebServlet(name = "EditarStatus", urlPatterns = {"/EditarStatus"})
public class EditarStatus extends HttpServlet {

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
            HttpSession sesion = request.getSession();
            String id = (String) sesion.getAttribute("id");
            String idArchivo = request.getParameter("idArchivo");
            String status = request.getParameter("status");

            if (id == null) {
                response.sendRedirect("index.jsp");
            } else if (status.equals("Activo")) {

                Conexion c = new Conexion();
                Connection conn = c.conecta();
                PreparedStatement update = conn.prepareStatement("UPDATE archivos SET AR_status=? WHERE AR_ID=?");
                update.setInt(1, 2);
                update.setInt(2, Integer.parseInt(idArchivo));
                c.ejecutaPS(update);
                c.cerrar();
                response.sendRedirect("VerArchivos");

            } else if (status.equals("Inactivo")) {
                Date date = new Date();
                Fechas fa = new Fechas();
                String horaExp = fa.horaActual(date);
                String fechaExp = fa.aumentarSemana(date);
                Conexion c = new Conexion();
                Connection conn = c.conecta();
                PreparedStatement update = conn.prepareStatement("UPDATE archivos SET AR_status=?, AR_Hora_Expiracion=?, AR_Fecha_Expiracion=? WHERE AR_ID=?");
                update.setInt(1, 1);
                update.setString(2, horaExp);
                update.setString(3, fechaExp);
                update.setInt(4, Integer.parseInt(idArchivo));

                c.ejecutaPS(update);
                c.cerrar();
                response.sendRedirect("VerArchivos");
            }
        } catch (Exception ex) {
            Logger.getLogger(EditarStatus.class.getName()).log(Level.SEVERE, null, ex);
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
