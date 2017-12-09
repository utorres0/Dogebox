/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
import modelo.SumarDescarga;

/**
 *
 * @author oneee
 */
@WebServlet(name = "Descarga", urlPatterns = {"/Descarga"})
public class Descarga extends HttpServlet {

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
            String ip = request.getRemoteAddr();

            if (ip.startsWith("66") == true || ip.startsWith("173") == true) { //  <--- Este ban es por que tanto facebook como google, evaluavan el link de descarga
                response.sendRedirect("index.jsp");                            // y nos sumaban a la base de datos una descarga que no deveria de existir. Los archivos con contraseña
            } else {                                                           // no eran afectados.
                String hash = request.getParameter("archivo");

                if (hash != null) {

                    HttpSession session = request.getSession();
                    String IDUser = (String) session.getAttribute("id");
                    String url = "";
                    String nombre = "";
                    String descargas = "";
                    String idArchivo = "";
                    String fechaExpCon = "";
                    String horaExp = "";
                    String pass = "";

                    Date fa = new Date();
                    Fechas f = new Fechas();
                    int status = 0;

                    ResultSet rs;
                    Conexion c = new Conexion();
                    Connection conn = c.conecta();
                    PreparedStatement sql = conn.prepareStatement("SELECT * FROM archivos WHERE Ar_Zelda=?");
                    sql.setString(1, hash);

                    rs = c.consultaPS(sql);
                    while (rs.next()) {
                        url = rs.getString("AR_url");
                        nombre = rs.getString("AR_nombre");
                        descargas = rs.getString("AR_Descarga_totales");
                        idArchivo = rs.getString("AR_id");
                        fechaExpCon = rs.getString("ar_fecha_expiracion");
                        horaExp = rs.getString("ar_hora_expiracion");
                        status = rs.getInt("AR_Status");
                        pass = rs.getString("AR_Password");
                    }
                    if (idArchivo.equals("")) {
                        response.sendRedirect("index.jsp");
                    } else {
                        String fechaActual = f.fechaActual(fa) + " " + f.horaActual(fa);
                        String fechaExp = fechaExpCon + " " + horaExp;
                        int res = f.compararFechas(fechaActual, fechaExp);

                        if (status == 1 && res == 1) { //Validar la fecha y el status. que no este vencido el archivo.
                            String txtPass = (String) request.getParameter("txtPass");
                            if (txtPass == null) {
                                txtPass = "";
                            }
                            if (pass == null) {
                                txtPass = "";
                            }
                            if (txtPass.equals(pass)) {

                                if (IDUser != null) {
                                    Fechas fecha = new Fechas();
                                    Date date = new Date();
                                    String fechaDescarga = fecha.fechaCompletaActual(date);
                                    PreparedStatement insertar = conn.prepareStatement("INSERT INTO Archivo_Descarga_Registrado "
                                            + "(ADR_Usuario, ADR_Archivo, ADR_Fecha_Hora_descarga) VALUES "
                                            + "(?,?,?)");
                                    insertar.setInt(1, Integer.parseInt(IDUser));
                                    insertar.setInt(2, Integer.parseInt(idArchivo));
                                    insertar.setString(3, fechaDescarga);
                                    c.ejecutaPS(insertar);

                                    SumarDescarga.sumar(nombre, idArchivo, descargas);

                                } else {
                                    Fechas fecha = new Fechas();
                                    Date date = new Date();
                                    String fechaDescarga = fecha.fechaCompletaActual(date);
                                    PreparedStatement insertar = conn.prepareStatement("INSERT INTO archivo_descargaanonima "
                                            + "(AA_Archivo, AA_Fecha_Hora_descarga) VALUES "
                                            + "(?,?)");
                                    insertar.setInt(1, Integer.parseInt(idArchivo));
                                    insertar.setString(2, fechaDescarga);
                                    c.ejecutaPS(insertar);
                                    SumarDescarga.sumar(nombre, idArchivo, descargas);

                                }

                                int DEFAULT_BUFFER_SIZE = 10240;
                                // Decode the file name (might contain spaces and on) and prepare file object.
                                File file = new File(url);

                                // Check if file actually exists in filesystem.
                                if (!file.exists()) {
                                    response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
                                    return;
                                }

                                // Get content type by filename.
                                String contentType = getServletContext().getMimeType(file.getName());

                                // If content type is unknown, then set the default value.
                                // For all content types, see: http://www.w3schools.com/media/media_mimeref.asp
                                // To add new content types, add new mime-mapping entry in web.xml.
                                if (contentType == null) {
                                    contentType = "application/octet-stream";
                                }

                                // Init servlet response.
                                response.reset();
                                response.setBufferSize(DEFAULT_BUFFER_SIZE);
                                response.setContentType(contentType);
                                response.setHeader("Content-Length", String.valueOf(file.length()));
                                response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

                                // Prepare streams.
                                BufferedInputStream input = null;
                                BufferedOutputStream output = null;

                                try {
                                    // Open streams.
                                    input = new BufferedInputStream(new FileInputStream(file), DEFAULT_BUFFER_SIZE);
                                    output = new BufferedOutputStream(response.getOutputStream(), DEFAULT_BUFFER_SIZE);

                                    // Write file contents to response.
                                    byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
                                    int length;

                                    while ((length = input.read(buffer)) > 0) {
                                        output.write(buffer, 0, length);
                                    }

                                    output.close();
                                    input.close();
                                } catch (Exception e) {

                                }

                            } else {
                                request.setAttribute("error", "Este archivo tiene contraseña. Ingresela para descargarlo");
                                request.setAttribute("hash", hash);
                                request.getRequestDispatcher("descargarArchivo.jsp").forward(request, response);
                            }

                        } else {
                            request.setAttribute("expirado", "Archivo Expirado");
                            request.getRequestDispatcher("descargarArchivo.jsp").forward(request, response);
                        }
                        c.cerrar();
                    }
                } else {
                    response.sendRedirect("index.jsp");
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(Descarga.class.getName()).log(Level.SEVERE, null, ex);
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
