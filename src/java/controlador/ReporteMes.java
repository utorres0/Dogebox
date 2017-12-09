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
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
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
@WebServlet(name = "ReporteMes", urlPatterns = {"/ReporteMes"})
public class ReporteMes extends HttpServlet {

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
            String idUsuario = (String) sesion.getAttribute("id");
            String idArchivo = (String) request.getParameter("idArchivo");
            String fechaInicio = (String) request.getParameter("fechaInicio");
            String nombreArchivo = (String) request.getParameter("nombreArchivo");
            String metodo = request.getMethod();
            fechaInicio += " 00:00:00";
            String fechaFin = (String) request.getParameter("fechaFin");
            fechaFin += " 23:59:59";

            if (idUsuario == null) {
                response.sendRedirect("index.jsp");
            } else if (metodo.equals("GET")) {
                response.sendRedirect("index.jsp");
            } else {
                Conexion c = new Conexion();
                Connection conn = c.conecta();
                PreparedStatement registrado = conn.prepareStatement("SELECT * FROM Archivo_Descarga_registrado"
                        + " WHERE ADR_Archivo=? AND ADR_Fecha_Hora_descarga BETWEEN ? AND ?");
                registrado.setInt(1, Integer.parseInt(idArchivo));
                registrado.setString(2, fechaInicio);
                registrado.setString(3, fechaFin);

                PreparedStatement anonimo = conn.prepareStatement("SELECT * FROM Archivo_Descargaanonima"
                        + " WHERE AA_Archivo=? AND AA_Fecha_Hora_descarga BETWEEN ? AND ?");

                anonimo.setInt(1, Integer.parseInt(idArchivo));
                anonimo.setString(2, fechaInicio);
                anonimo.setString(3, fechaFin);

                PreparedStatement consulta = conn.prepareStatement("SELECT AR_Accesos_totales FROM archivos"
                        + " WHERE AR_ID=?");
                consulta.setInt(1, Integer.parseInt(idArchivo));
                int accesos = 0;
                ResultSet consultaAccesos = c.consultaPS(consulta);
                while (consultaAccesos.next()) {
                    accesos = consultaAccesos.getInt("AR_Accesos_totales");
                }
                accesos++;
                PreparedStatement update = conn.prepareStatement("UPDATE archivos SET AR_Accesos_totales=? WHERE AR_ID=?");
                update.setInt(1, accesos);
                update.setInt(2, Integer.parseInt(idArchivo));
                c.ejecutaPS(update);

                ResultSet rs1 = c.consultaPS(registrado);
                List<LinkedHashMap<String, String>> listaRegistrado = new ArrayList<LinkedHashMap<String, String>>();
                ResultSetMetaData metaRegistrado = rs1.getMetaData();
                while (rs1.next()) {
                    LinkedHashMap map = new LinkedHashMap();
                    for (int i = 1; i <= metaRegistrado.getColumnCount(); i++) {
                        String key = metaRegistrado.getColumnName(i);
                        String valor = rs1.getString(key);

                        map.put(key, valor);
                    }
                    listaRegistrado.add(map);
                }

                ResultSet rs2 = c.consultaPS(anonimo);
                List<LinkedHashMap<String, String>> listaAnonimo = new ArrayList<LinkedHashMap<String, String>>();
                ResultSetMetaData metaAnonimo = rs2.getMetaData();
                while (rs2.next()) {
                    LinkedHashMap map = new LinkedHashMap();
                    for (int i = 1; i <= metaAnonimo.getColumnCount(); i++) {
                        String key = metaAnonimo.getColumnName(i);
                        String valor = rs2.getString(key);

                        map.put(key, valor);
                    }
                    listaAnonimo.add(map);
                }

                request.setAttribute("listaRegistrado", listaRegistrado);
                request.setAttribute("listaAnonimo", listaAnonimo);
                request.setAttribute("nombreArchivo", nombreArchivo);
                request.getRequestDispatcher("reporteMes.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReporteMes.class.getName()).log(Level.SEVERE, null, ex);
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
