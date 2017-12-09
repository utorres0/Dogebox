/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author oneee
 */
public abstract class VerificarStatus {

    /**
     *
     * @param idRegistrado Obtiene el id del usuario logueado
     * @throws SQLException
     */
    public static void ejecuta(String idRegistrado) throws SQLException {

        String horaExp = "";
        String fechaExp = "";
        String fechaActual = "";
        String fechaExpCompleta = "";
        String idArchivo = "";
        int res;
        Date fa = new Date();
        Fechas f = new Fechas();

        Conexion c = new Conexion();
        Connection conn = c.conecta();
        PreparedStatement consulta = conn.prepareStatement("SELECT AR_Hora_Expiracion, AR_Fecha_Expiracion, AR_ID FROM archivos WHERE AR_ArchivoSubido_Registrado=?");
        consulta.setInt(1, Integer.parseInt(idRegistrado));
        ResultSet rs = c.consultaPS(consulta);
        
        while (rs.next()) {

            horaExp = rs.getString("AR_Hora_Expiracion");
            fechaExp = rs.getString("AR_Fecha_Expiracion");
            idArchivo = rs.getString("AR_ID");

            fechaActual = f.fechaActual(fa) + " " + f.horaActual(fa);
            fechaExpCompleta = fechaExp + " " + horaExp;
            res = f.compararFechas(fechaActual, fechaExpCompleta);
            if (res != 1) {
                PreparedStatement update = conn.prepareStatement("UPDATE archivos SET AR_Status=? WHERE AR_ID=?");
                update.setString(1, "2");
                update.setInt(2, Integer.parseInt(idArchivo));
                c.ejecutaPS(update);

            }

        }
        c.cerrar();

    }

}
