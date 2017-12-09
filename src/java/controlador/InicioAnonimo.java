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

/**
 *
 * @author oneee
 */
@WebServlet(name = "InicioAnonimo", urlPatterns = {"/InicioAnonimo"})
public class InicioAnonimo extends HttpServlet {

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
            if (email != null) {
                response.sendRedirect("iniciado.jsp");
            } else {
                ResultSet rs = null;
                String consultaIP = "";
                String ip = request.getRemoteAddr(); // IP del cliente
                ip = ip.replace(":", ".");
                Conexion c = new Conexion();
                Connection conn = c.conecta();
                PreparedStatement consultar = conn.prepareStatement("SELECT ua_direccion_ip FROM usuario_anonimo "
                        + "WHERE ua_direccion_ip=?");
                consultar.setString(1, ip);
                rs = c.consultaPS(consultar);

                if (rs != null) {
                    while (rs.next()) {
                        consultaIP = rs.getString("ua_direccion_ip");
                    }
                }
                if (consultaIP.equals("")) {
                    String ruta = getServletContext().getRealPath("/") + "archivos\\" + ip;
                    PreparedStatement insertar = conn.prepareStatement("INSERT INTO usuario_anonimo (ua_direccion_ip,ua_archivos_activos,ua_limite_subida) "
                            + "VALUES(?,?,?)");
                    insertar.setString(1, ip);
                    insertar.setInt(2, 0);
                    insertar.setInt(3, 4);

                    c.ejecutaPS(insertar);
                    File f = new File(ruta);
                    f.mkdirs();
                    File fe = new File(getServletContext().getRealPath("/") + "codigosQR\\" + ip);
                    fe.mkdirs();
                    sesion.setAttribute("usuarioAnonimo", ip);
                } else {
                    sesion.setAttribute("usuarioAnonimo", consultaIP);
                }

                c.cerrar();
                response.sendRedirect("Publicidad");
            }
        } catch (SQLException ex) {
            Logger.getLogger(InicioAnonimo.class.getName()).log(Level.SEVERE, null, ex);
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
