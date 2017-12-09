/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author oneee
 */
public abstract class SumarDescarga {
    
    public static void sumar(String nombre, String idArchivo, String descargas) throws SQLException{
        int i=Integer.parseInt(descargas);
        i++;
        
        Conexion c=new Conexion();
        Connection conn=c.conecta();
        PreparedStatement consulta=conn.prepareStatement("UPDATE archivos SET AR_Descarga_totales=? WHERE AR_id=?");
        consulta.setInt(1,i);
        consulta.setInt(2,Integer.parseInt(idArchivo));
        c.ejecutaPS(consulta);
        c.cerrar();
    
    }
    
}
