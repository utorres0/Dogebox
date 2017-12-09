/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import modelo.Conexion;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
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
import modelo.Correos;
import modelo.HashMD5;

/**
 *
 * @author oneee
 */
@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
public class Registro extends HttpServlet {

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
            try {
                String consultaEmail = "";

                String txtEmail = request.getParameter("txtEmail");
                String txtContrasena = request.getParameter("txtContrasena");
                String txtVerificar = request.getParameter("txtVerificar");
                String txtNombre = request.getParameter("txtNombre");
                String metodo = request.getMethod();
                if (txtEmail == null) {
                    response.sendRedirect("index.jsp");
                } else if (metodo.equals("GET")) {
                    response.sendRedirect("index.jsp");
                } else {
                    String ruta = getServletContext().getRealPath("/") + "\\archivos\\" + txtEmail;

                    Conexion c = new Conexion();
                    Connection conn = c.conecta();
                    PreparedStatement insert = conn.prepareStatement("INSERT INTO usuario_registrado (ur_email, ur_nombre,ur_password,ur_status,UR_CodigoActivacion) VALUES "
                            + "(?,?,?,?,?)");
                    insert.setString(1, txtEmail);
                    insert.setString(2, txtNombre);
                    insert.setString(3, txtContrasena);
                    insert.setInt(4, 2);

                    PreparedStatement consulta = conn.prepareStatement("SELECT ur_email FROM usuario_registrado WHERE ur_email=?");
                    consulta.setString(1, txtEmail);

                    ResultSet rs = c.consultaPS(consulta);

                    while (rs.next()) {
                        consultaEmail = rs.getString("ur_email");
                    }

                    if (txtEmail.equals("") || txtContrasena.equals("") || txtNombre.equals("")) {
                        response.sendRedirect("registro.jsp");

                    } else if (consultaEmail.equals("")) {
                        if (txtContrasena.equals(txtVerificar)) {
                            String idActivacion = HashMD5.hashear(txtEmail);
                            insert.setString(5, idActivacion);

                            c.ejecutaPS(insert);

                            Correos correo = new Correos();
                            correo.enviarConfirmación(txtEmail, idActivacion);
                            File f = new File(ruta);
                            File fa = new File(getServletContext().getRealPath("/") + "\\codigosQR\\" + txtEmail);
                            f.mkdirs();
                            fa.mkdirs();

                            request.setAttribute("redireccionar", "index.jsp");
                            request.getRequestDispatcher("exitoRegistro.jsp").forward(request, response);

                        } else {
                            request.setAttribute("errorLogin", "regContra");
                            request.setAttribute("redireccionar", "registro.jsp");
                            request.getRequestDispatcher("error.jsp").forward(request, response);

                        }
                    } else {
                        request.setAttribute("errorLogin", "regUser");
                        request.setAttribute("redireccionar", "registro.jsp");
                        request.getRequestDispatcher("error.jsp").forward(request, response);

                    }
                }
            } catch (SQLException ex) {

            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(Registro.class.getName()).log(Level.SEVERE, null, ex);
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
