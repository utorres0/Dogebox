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
@WebServlet(name = "EditarContacto", urlPatterns = {"/EditarContacto"})
public class EditarContacto extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession sesion = request.getSession();
            String email = (String) sesion.getAttribute("email");
            String metodo = request.getMethod();
            String idContacto = request.getParameter("contacto");
            String txtNombre = request.getParameter("txtNombre");
            String txtEmail = request.getParameter("txtEmail");

            if (email == null) {
                response.sendRedirect("index.jsp");
            } else if (metodo.equals("GET")) {
                response.sendRedirect("index.jsp");
            } else if (txtNombre.equals("") && txtEmail.equals("")) {
                response.sendRedirect("MostrarContactos");
            } else if (txtNombre.equals("")) {
                Conexion c = new Conexion();
                Connection conn = c.conecta();
                PreparedStatement update = conn.prepareStatement("UPDATE contactos SET CO_Email=? WHERE CO_ID=?");
                update.setString(1, txtEmail);
                update.setInt(2, Integer.parseInt(idContacto));

                c.ejecutaPS(update);
                c.cerrar();
                response.sendRedirect("MostrarContactos");

            } else if (txtEmail.equals("")) {

                Conexion c = new Conexion();
                Connection conn = c.conecta();
                PreparedStatement update = conn.prepareStatement("UPDATE contactos SET CO_Nombre=? WHERE CO_ID=?");
                update.setString(1, txtNombre);
                update.setInt(2, Integer.parseInt(idContacto));

                c.ejecutaPS(update);
                c.cerrar();
                response.sendRedirect("MostrarContactos");
            } else {
                Conexion c = new Conexion();
                Connection conn = c.conecta();
                PreparedStatement update = conn.prepareStatement("UPDATE contactos SET CO_Nombre=?, CO_Email=? WHERE CO_ID=?");
                update.setString(1, txtNombre);
                update.setString(2, txtEmail);
                update.setInt(3, Integer.parseInt(idContacto));

                c.ejecutaPS(update);
                c.cerrar();
                response.sendRedirect("MostrarContactos");
            }
        } catch (Exception ex) {
            Logger.getLogger(EditarContacto.class.getName()).log(Level.SEVERE, null, ex);
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
