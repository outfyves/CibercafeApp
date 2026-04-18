package com.cibercafe.dao;

import com.cibercafe.config.ConexionDB;
import com.cibercafe.model.Servicio;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO: ServicioDAO - CRUD para servicios adicionales del cibercafé.
 * GA7-220501096-AA2-EV02
 */
public class ServicioDAO {

    public boolean agregar(Servicio s) throws SQLException {
        String sql = "INSERT INTO servicios (nombre, descripcion, precio, estado) VALUES (?,?,?,?)";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, s.getNombre());
            ps.setString(2, s.getDescripcion());
            ps.setDouble(3, s.getPrecio());
            ps.setString(4, s.getEstado() != null ? s.getEstado() : "activo");
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }

    public List<Servicio> listar() throws SQLException {
        List<Servicio> lista = new ArrayList<>();
        String sql = "SELECT * FROM servicios ORDER BY nombre";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Servicio s = new Servicio();
                s.setIdServicio(rs.getInt("id_servicio"));
                s.setNombre(rs.getString("nombre"));
                s.setDescripcion(rs.getString("descripcion"));
                s.setPrecio(rs.getDouble("precio"));
                s.setEstado(rs.getString("estado"));
                lista.add(s);
            }
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return lista;
    }

    public Servicio buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM servicios WHERE id_servicio = ?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Servicio s = new Servicio();
                s.setIdServicio(rs.getInt("id_servicio"));
                s.setNombre(rs.getString("nombre"));
                s.setDescripcion(rs.getString("descripcion"));
                s.setPrecio(rs.getDouble("precio"));
                s.setEstado(rs.getString("estado"));
                return s;
            }
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return null;
    }

    public boolean actualizar(Servicio s) throws SQLException {
        String sql = "UPDATE servicios SET nombre=?, descripcion=?, precio=?, estado=? WHERE id_servicio=?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, s.getNombre());
            ps.setString(2, s.getDescripcion());
            ps.setDouble(3, s.getPrecio());
            ps.setString(4, s.getEstado());
            ps.setInt(5, s.getIdServicio());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }

    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM servicios WHERE id_servicio = ?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }
}
