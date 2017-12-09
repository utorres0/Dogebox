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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Conexion;

/**
 *
 * @author Gustavo Urbina
 */
@WebServlet(name = "InsertarContactos", urlPatterns = {"/InsertarContactos"})
public class InsertarContactos extends HttpServlet {

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

            //Se recupera el id de la sesion
            HttpSession sesion = request.getSession();//Se recupera el id de la sesion
            String id = (String) sesion.getAttribute("id");
            String metodo = request.getMethod();
            if (id == null) {

                response.sendRedirect("index.jsp");

            } else if (metodo.equals("GET")) {
                response.sendRedirect("index.jsp");
            } else {

                String correo = request.getParameter("txtCorreo");
                String nombre = request.getParameter("txtNombre");
                if (correo == null) {
                    response.sendRedirect("iniciado.jsp");
                } else //Se valida que hayan introducido datos
                 if ((correo.equals("")) && (nombre.equals(""))) {
                        out.println("Porfavor introduce los datos");
                        out.println("<a href=\"MostrarContactos\"> regresar a contactos </a>");

                    } //Se gravan los datos en la DB 
                    else {
                        Conexion c = new Conexion();
                        Connection conn = c.conecta();
                        PreparedStatement agregar = conn.prepareStatement("INSERT INTO contactos (CO_Nombre,CO_Email,CO_ID_usuario) "
                                + "VALUES (?,?,?)");
                        agregar.setString(1, nombre);
                        agregar.setString(2, correo);
                        agregar.setInt(3, Integer.parseInt(id));

                        c.ejecutaPS(agregar);
                        c.cerrar();

                        response.sendRedirect("MostrarContactos");

                    }
            }
        } catch (Exception ex) {
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
