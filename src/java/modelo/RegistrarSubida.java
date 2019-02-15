/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author oneee
 */
public class RegistrarSubida {
    //Obtener fecha y darle formato requerido

    private final Date fechaActual = new Date();
    private final Fechas fh = new Fechas();
    private final String fecha = fh.fechaActual(fechaActual);
    private final String hora = fh.horaActual(fechaActual);

    /**
     *
     * @param item Archivo que se va a subir
     * @param email Email para identificar el usuraio
     * @param id Del usuario
     * @param rutaReal La ruta donde esta el server
     * @param zelda Hash generado con el item
     * @param pass Contraseña de archivo opcional
     * @return Regresa la informacion del archivo y la liga de descarga
     * @throws Exception
     */
    public String subirRegistrado(FileItem item, String email, String id, String rutaReal, String zelda, String pass) throws Exception {
        if (pass == null) {
            pass = "";
        }
        String nombre = item.getName().replace("'", "");
        String ruta = rutaReal + "archivos/" + email + "/" + item.getName();
        String fechaExp = fh.aumentarSemana(fechaActual);

        File f = new File(ruta);

        if (f.exists()) {
            nombre = "copia de" + nombre;

        }
        item.write(f);

        long tamano = item.getSize() / 1240;//obtener kb archivo
        String acortado = Acortador.acortar("http://dogebox.ddns.net/dogebox/Descarga?archivo=" + zelda);
        CodigoQR.generar(acortado, rutaReal, email, zelda);
        String tipo = FilenameUtils.getExtension(ruta);
        Conexion c = new Conexion();

        PreparedStatement sql = c.conecta().prepareStatement("INSERT INTO "
                + "archivos(AR_Nombre,AR_Tamano,AR_URL,AR_Tipo,AR_Accesos_totales,AR_Descarga_totales,"
                + "AR_Hora_subida,AR_Fecha_subida,AR_Hora_Expiracion,AR_Fecha_Expiracion,AR_Status,"
                + "AR_ArchivoSubido_Registrado,AR_Zelda,AR_ZeldaCorto,AR_Password) "
                + "VALUES "
                + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

        sql.setString(1, nombre);
        sql.setString(2, String.valueOf(tamano));
        sql.setString(3, ruta);
        sql.setString(4, tipo);
        sql.setInt(5, 0);
        sql.setInt(6, 0);
        sql.setString(7, hora);
        sql.setString(8, fecha);
        sql.setString(9, hora);
        sql.setString(10, fechaExp);
        sql.setInt(11, 1);
        sql.setInt(12, Integer.parseInt(id));
        sql.setString(13, zelda);
        sql.setString(14, acortado);
        sql.setString(15, pass);

        c.ejecutaPS(sql);
        c.cerrar();

        return acortado;

    }

    /**
     *
     * @param item Archivo que se va a subir
     * @param ip Ip del usuario anonimo
     * @param rutaReal La ruta donde esta el server
     * @param zelda
     * @return Regresa que no hay mas archivo disponibles por subir o la liga de
     * descarga segun el caso
     * @throws Exception
     */
    public String subirAnonimo(FileItem item, String ip, String rutaReal, String zelda) throws Exception {

        String nombre = item.getName().replace("'", "");
        String ruta = rutaReal + "archivos/" + ip + "/" + item.getName();
        String fechaExp = fh.aumentarFecha(fechaActual);
        long tamano = item.getSize() / 1240;//ontener kb archivo
        String tipo = FilenameUtils.getExtension(ruta);
        String acortado = Acortador.acortar("http://dogebox.ddns.net/dogebox/Descarga?archivo=" + zelda);
        ResultSet rs;

        Conexion c = new Conexion();
        Connection conn = c.conecta();

        PreparedStatement consulta = conn.prepareStatement("SELECT ua_archivos_activos, ua_limite_subida FROM usuario_anonimo "
                + "where ua_direccion_ip=?");
        consulta.setString(1, ip);
        rs = c.consultaPS(consulta);

        int archivosActivos = 0;
        int limite = 4;
        while (rs.next()) {
            archivosActivos = rs.getInt("ua_archivos_activos");
            limite = rs.getInt("ua_limite_subida");
        }
        archivosActivos++;

        PreparedStatement update = conn.prepareStatement("UPDATE usuario_anonimo SET ua_archivos_activos=? WHERE ua_direccion_ip=?");
        update.setInt(1, archivosActivos);
        update.setString(2, ip);

        if (archivosActivos > limite) {
            c.cerrar();
            return "no";

        } else {

            File f = new File(ruta);
            if (f.exists()) {
                nombre = "copia de" + nombre;
            }
            item.write(f);

            CodigoQR.generar(acortado, rutaReal, ip, zelda);

            PreparedStatement sql = c.conecta().prepareStatement("INSERT INTO "
                    + "Archivos(AR_Nombre,AR_Tamano,AR_URL,AR_Tipo,AR_Accesos_totales,AR_Descarga_totales,"
                    + "AR_Hora_subida,AR_Fecha_subida,AR_Hora_Expiracion,AR_Fecha_Expiracion,AR_Status,"
                    + "AR_ArchivoSubido_Anonimo,AR_Zelda,AR_ZeldaCorto,AR_Password)"
                    + "VALUES "
                    + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            sql.setString(1, nombre);
            sql.setString(2, String.valueOf(tamano));
            sql.setString(3, ruta);
            sql.setString(4, tipo);
            sql.setInt(5, 0);
            sql.setInt(6, 0);
            sql.setString(7, hora);
            sql.setString(8, fecha);
            sql.setString(9, hora);
            sql.setString(10, fechaExp);
            sql.setInt(11, 1);
            sql.setString(12, ip);
            sql.setString(13, zelda);
            sql.setString(14, acortado);
            sql.setString(15, "");

            c.ejecutaPS(sql);
            c.ejecutaPS(update);
            c.cerrar();

            return acortado;

        }

    }

}
