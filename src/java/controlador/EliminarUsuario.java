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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Conexion;

/**
 *
 * @author oneee
 */
@WebServlet(name = "EliminarUsuario", urlPatterns = {"/EliminarUsuario"})
public class EliminarUsuario extends HttpServlet {

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

            String metodo = request.getMethod();
            if (id == null) {
                response.sendRedirect("index.jsp");
            } else if (metodo.equals("GET")) {
                response.sendRedirect("index.jsp");
            } else {

                Conexion c = new Conexion();
                Connection conn = c.conecta();

                PreparedStatement consulta = conn.prepareStatement("SELECT AR_ID FROM archivos WHERE AR_ArchivoSubido_Registrado=?");
                consulta.setInt(1, Integer.parseInt(id));

                ResultSet rs = c.consultaPS(consulta);
                String idArchivo;
                while (rs.next()) {
                    idArchivo = rs.getString("AR_ID");

                    PreparedStatement eliminar1 = conn.prepareStatement("DELETE FROM archivo_descargaanonima WHERE AA_Archivo=?");
                    PreparedStatement eliminar2 = conn.prepareStatement("DELETE FROM archivo_descarga_registrado WHERE ADR_Archivo=?");
                    PreparedStatement eliminar3 = conn.prepareStatement("DELETE FROM archivos WHERE AR_Id=?");
                    eliminar1.setInt(1, Integer.parseInt(idArchivo));
                    eliminar2.setInt(1, Integer.parseInt(idArchivo));
                    eliminar3.setInt(1, Integer.parseInt(idArchivo));

                    c.ejecutaPS(eliminar1);
                    c.ejecutaPS(eliminar2);
                    c.ejecutaPS(eliminar3);
                }
                PreparedStatement eliminar = conn.prepareStatement("DELETE FROM contactos WHERE CO_ID_usuario = ? ");
                eliminar.setInt(1, Integer.parseInt(id));

                c.ejecutaPS(eliminar);

                PreparedStatement user = conn.prepareStatement("DELETE FROM usuario_registrado WHERE UR_ID = ? ");
                user.setInt(1, Integer.parseInt(id));

                c.ejecutaPS(user);

                sesion.invalidate();

                response.sendRedirect("index.jsp");
            }
        } catch (Exception ex) {
            Logger.getLogger(EliminarUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
