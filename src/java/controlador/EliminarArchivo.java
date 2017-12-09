/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(name = "EliminarArchivo", urlPatterns = {"/EliminarArchivo"})
public class EliminarArchivo extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion = request.getSession();
            String email = (String) sesion.getAttribute("email");
            String idArchivo = request.getParameter("idArchivo");
            String nombreArchivo = request.getParameter("nombreArchivo");
            if (email != null) {
                if (idArchivo == null) {
                    response.sendRedirect("index.jsp");
                } else {

                    Conexion c = new Conexion();
                    Connection conn = c.conecta();
                    PreparedStatement eliminar1 = conn.prepareStatement("DELETE FROM archivo_descargaanonima WHERE AA_Archivo=?");
                    PreparedStatement eliminar2 = conn.prepareStatement("DELETE FROM archivo_descarga_registrado WHERE ADR_Archivo=?");
                    PreparedStatement eliminar3 = conn.prepareStatement("DELETE FROM archivos WHERE AR_Id=?");
                    eliminar1.setInt(1, Integer.parseInt(idArchivo));
                    eliminar2.setInt(1, Integer.parseInt(idArchivo));
                    eliminar3.setInt(1, Integer.parseInt(idArchivo));

                    c.ejecutaPS(eliminar1);
                    c.ejecutaPS(eliminar2);
                    c.ejecutaPS(eliminar3);
                    c.cerrar();

                    File file = new File(getServletContext().getRealPath("/archivos") + nombreArchivo);

                    file.setWritable(true);
                    if (file.delete()) {
                        out.println(file.getName() + " is deleted!");
                    } else {
                        out.println("Delete operation is failed.");
                    }

                    response.sendRedirect("VerArchivos");
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
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
