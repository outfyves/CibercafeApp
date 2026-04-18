package com.cibercafe.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase de configuración y conexión a la base de datos MySQL.
 * GA7-220501096-AA2-EV02 - Sistema Cibercafé
 */
public class ConexionDB {

    private static final String URL      = "jdbc:mysql://localhost:3306/proyecto_cibercafe"
                                         + "?useSSL=false&serverTimezone=America/Bogota"
                                         + "&useUnicode=true&characterEncoding=UTF-8";
    private static final String USUARIO  = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";

    /**
     * Obtiene una conexión activa a la base de datos.
     * @return Connection objeto de conexión
     * @throws SQLException si ocurre un error al conectar
     */
    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USUARIO, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL no encontrado: " + e.getMessage());
        }
    }

    /**
     * Cierra una conexión de forma segura.
     * @param con conexión a cerrar
     */
    public static void cerrarConexion(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar conexión: " + e.getMessage());
            }
        }
    }
}
