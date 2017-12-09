/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import modelo.RegistrarSubida;
import java.io.*;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.HashMD5;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author oneee
 */
@WebServlet(name = "SubirArchivo", urlPatterns = {"/SubirArchivo"})
public class SubirArchivo extends HttpServlet {

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
            String txtPass = "";
            String txtValidar = "";
            String usuarioAnonimo = (String) sesion.getAttribute("usuarioAnonimo");
            String id = (String) sesion.getAttribute("id");
            String rutaReal = getServletContext().getRealPath("/");
            rutaReal = rutaReal.replace("\\", "/");
            String res = "";
            String metodo = request.getMethod();
            
            if (email == null && usuarioAnonimo == null) {
                response.sendRedirect("index.jsp");
            } else if (metodo.equals("GET")) {
                response.sendRedirect("index.jsp");
            } else {
                FileItemFactory file_factory = new DiskFileItemFactory();
                ServletFileUpload servlet_up = new ServletFileUpload(file_factory);
                List<FileItem> items = servlet_up.parseRequest(request);

                if (email == null) {
                    if (usuarioAnonimo != null) {

                        for (int i = 0; i < items.size(); i++) {
                            FileItem item = (FileItem) items.get(i);
                            if (!item.isFormField()) {

                                String zelda = HashMD5.hashear(usuarioAnonimo + item.getName());
                                RegistrarSubida reg = new RegistrarSubida();
                                res = reg.subirAnonimo(item, usuarioAnonimo, rutaReal, zelda);
                                String path = "";
                                if (!res.equals("no")) {
                                    path = rutaReal + "codigosQR/" + usuarioAnonimo + "/" + zelda + ".png";
                                }
                                request.setAttribute("respuesta", res);
                                request.setAttribute("path", path);
                                request.getRequestDispatcher("exitoSubida.jsp").forward(request, response);
                                sesion.invalidate();

                            }
                        }

                    } else {
                        response.sendRedirect("index.jsp");
                    }
                } else {
                    for (FileItem item : items) {
                        if (item.isFormField()) {
                            // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                            String fieldname = item.getFieldName();
                            String fieldvalue = item.getString();
                            if (fieldname.equals("txtPass")) {
                                txtPass = fieldvalue;
                            }
                            if (fieldname.equals("txtValidar")) {
                                txtValidar = fieldvalue;
                            }

                        } else if (txtPass.equals(txtValidar)) {
                            if (!item.isFormField()) {

                                String zelda = HashMD5.hashear(id + item.getName());
                                RegistrarSubida reg = new RegistrarSubida();
                                res = reg.subirRegistrado(item, email, id, rutaReal, zelda, txtPass);

                                String path = rutaReal + "codigosQR/" + email + "/" + zelda + ".png";

                                request.setAttribute("respuesta", res);
                                request.setAttribute("path", path);
                                request.setAttribute("email", email);

                                request.getRequestDispatcher("ContactosSubida").forward(request, response);
                            }
                        } else {
                            out.println("Contraseñas no coinciden");
                        }
                    }
                }

            }
        } catch (Exception ex) {
            Logger.getLogger(SubirArchivo.class.getName()).log(Level.SEVERE, null, ex);

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
