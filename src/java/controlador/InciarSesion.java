/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import modelo.Conexion;
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
import org.apache.http.HttpStatus;

/**
 *
 * @author oneee
 */
@WebServlet(name = "InciarSesion", urlPatterns = {"/InciarSesion"})
public class InciarSesion extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession sesion = request.getSession();
            String rsEmail = "";
            String rsContrasena = "";
            String idUsuario = "";
            String rsNombre = "";
            String metodo = request.getMethod();
            int rsStatus = 0;

            String txtEmail = request.getParameter("txtUsuario");
            String txtContrasena = request.getParameter("txtContrasena");
            String android = request.getParameter("android");
            if(android==null){android="";}
            if (txtEmail == null) {
                if (metodo.equals("GET")) {
                    response.sendRedirect("index.jsp");
                }
            } else {

                try {
                    Conexion c = new Conexion();
                    Connection conn = c.conecta();
                    ResultSet rsUser;
                    PreparedStatement consulta = conn.prepareStatement("SELECT * FROM usuario_registrado WHERE UR_Email=?");
                    consulta.setString(1, txtEmail);

                    rsUser = c.consultaPS(consulta);

                    while (rsUser.next()) {
                        rsEmail = rsUser.getString("ur_email");
                        idUsuario = rsUser.getString("ur_id");
                        rsContrasena = rsUser.getString("ur_password");
                        rsNombre = rsUser.getString("ur_nombre");
                        rsStatus = rsUser.getInt("ur_status");
                    }

                    //Verificar campos y evita que esten vacios. tambien toma en cuenta la sesion.
                    if (txtEmail.equals("") || txtContrasena.equals("")) {
                        response.sendRedirect("index.jsp");
                    } else if (txtEmail.equals(rsEmail) && txtContrasena.equals(rsContrasena) && sesion.getAttribute("email") == null && rsStatus != 2) {
                        sesion.setAttribute("email", txtEmail);
                        sesion.setAttribute("id", idUsuario);
                        sesion.setAttribute("nombre", rsNombre);

//                        if (android.equals("TRUE")) {
//                            response.sendError(HttpStatus.SC_OK);
//                        } else {

                            response.sendRedirect("iniciado.jsp");
                        //}
                    } else if (txtEmail.equals(rsEmail)) {
                        if (txtContrasena.equals(rsContrasena)) {
                            if (rsStatus == 2) {
                                request.setAttribute("errorLogin", "2");
                                request.setAttribute("redireccionar", "index.jsp");
                                request.getRequestDispatcher("error.jsp").forward(request, response);

                            } else {
                                response.sendRedirect("iniciado.jsp");
                            }
                        } else {
                            request.setAttribute("errorLogin", "pass");
                            request.setAttribute("redireccionar", "index.jsp");
                            request.getRequestDispatcher("error.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("errorLogin", "email");
                        request.setAttribute("redireccionar", "index.jsp");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    }
                    c.cerrar();

                } catch (SQLException ex) {

                }

            }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(InciarSesion.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(InciarSesion.class.getName()).log(Level.SEVERE, null, ex);
        }
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
