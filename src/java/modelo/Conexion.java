package modelo;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Clase para realizar la conexion a la DB
 * @author Ubaldo Torres Juarez
 */
public class Conexion {

    static final String CONTROLADOR = "com.mysql.jdbc.Driver";
    static final String DIRECCION = "jdbc:mysql://localhost:3306/integrador?useUnicode=true&characterEncoding=utf-8&useSSL=false";
    static final String USUARIO = "dogebox";
    static final String PASS = "15086247";

    Connection conexion;

    public Connection conecta() {

        try {
            Class.forName(CONTROLADOR);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }
        try {
            conexion = DriverManager.getConnection(DIRECCION, USUARIO, PASS);
            
            return conexion;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }

        return conexion;
    }

    public ResultSet consultaPS(PreparedStatement sql) {
        ResultSet rs = null;
        try {

            rs = sql.executeQuery();

        } catch (SQLException e) {

            System.out.println(e.getMessage());

            
        }
        return rs;
    }

    public void ejecutaPS(PreparedStatement sql) {
        if (conexion == null) {
            System.out.println("No hay conexión con la base de datos");
        } else {
            try {
                sql.executeUpdate();
            } catch (SQLException e) {
                System.out.println("Error al ejecutar sentencia " + e.toString());
            }
        }
    }

    public void cerrar() {
        try {

            if (conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
            System.out.println("Error al cerrar sesión: " + e.toString());
        }
    }
    public String ejecutaVC(PreparedStatement sql) {
        
        if (conexion == null) {
            System.out.println("No hay conexión con la base de datos");
        } else {
            try {
                sql.executeUpdate();
                return "Activado con éxito.";
            } catch (SQLException e) {
                return "Error al verifiacar cuenta" + e.toString();
            }
        }
        return null;
    }
}
