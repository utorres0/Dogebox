/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author oneee
 */
@WebServlet(name = "ObtenerQR", urlPatterns = {"/ObtenerQR"})
public class ObtenerQR extends HttpServlet {

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

            String path = (String) request.getParameter("path");

            // Check if file name is actually supplied to the request URI.
            if (path == null) {
                // Do your thing if the image is not supplied to the request URI.
                // Throw an exception, or send 404, or show default/warning image, or just ignore it.
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
                return;
            }
            File image = new File(path);

            // Check if file actually exists in filesystem.
            if (!image.exists()) {
                // Do your thing if the file appears to be non-existing.
                // Throw an exception, or send 404, or show default/warning image, or just ignore it.
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
                return;
            }

            // Get content type by filename.
            String contentType = getServletContext().getMimeType(image.getName());

            // Check if file is actually an image (avoid download of other files by hackers!).
            // For all content types, see: http://www.w3schools.com/media/media_mimeref.asp
            if (contentType == null || !contentType.startsWith("image")) {
                // Do your thing if the file appears not being a real image.
                // Throw an exception, or send 404, or show default/warning image, or just ignore it.
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // 404.
                return;
            }

            // Init servlet response.
            response.reset();
            response.setContentType(contentType);
            response.setHeader("Content-Length", String.valueOf(image.length()));

            // Write image content to response.
            Files.copy(image.toPath(), response.getOutputStream());
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
