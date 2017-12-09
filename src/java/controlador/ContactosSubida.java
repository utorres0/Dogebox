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
@WebServlet(name = "ContactosSubida", urlPatterns = {"/ContactosSubida"})
public class ContactosSubida extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            HttpSession sesion = request.getSession();
            String id = (String) sesion.getAttribute("id");
            String usurioAnonimo = (String) sesion.getAttribute("usurioAnonimo");
            
            if (id == null) {
                if (usurioAnonimo == null) {
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("exitoSubida.jsp");
                }
            } else {
                Conexion c = new Conexion();
                Connection conn = c.conecta();
                PreparedStatement contactos = conn.prepareStatement("Select * from Contactos where  CO_ID_usuario = ?");
                contactos.setInt(1, Integer.parseInt(id));
                
                ResultSet rs = c.consultaPS(contactos);
                List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
                ResultSetMetaData meta = rs.getMetaData();
                while (rs.next()) {
                    LinkedHashMap map = new LinkedHashMap();
                    for (int i = 1; i <= meta.getColumnCount(); i++) {
                        String key = meta.getColumnName(i);
                        String valor = rs.getString(key);
                        
                        map.put(key, valor);
                    }
                    list.add(map);
                }
                
                c.cerrar();
                
                request.setAttribute("lista", list);
                request.getRequestDispatcher("exitoSubida.jsp").forward(request, response);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactosSubida.class.getName()).log(Level.SEVERE, null, ex);
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
