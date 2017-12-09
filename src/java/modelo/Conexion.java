package modelo;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author oneee
 */
public class Conexion {

    static final String controlador = "com.mysql.jdbc.Driver";
    static final String direccion = "jdbc:mysql://localhost:3306/integrador?useUnicode=true&characterEncoding=utf-8";
    static final String usuario = "root";
    static final String contrasena = "";

    Connection conexion;

    public Connection conecta() {

        try {
            Class.forName(controlador);
        } catch (ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }
        try {
            conexion = DriverManager.getConnection(
                    direccion, usuario, contrasena);
            
            return conexion;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
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

//    public void ejecuta(String sql) {
//        if (conexion == null) {
//            System.out.println("No hay conexión con la base de datos");
//        } else {
//            try {
//                .executeUpdate(sql);
//            } catch (Exception e) {
//                System.out.println("Error al ejecutar sentencia " + e.toString());
//            }
//        }
//    }
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
