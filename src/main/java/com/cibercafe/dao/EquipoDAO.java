package com.cibercafe.dao;

import com.cibercafe.config.ConexionDB;
import com.cibercafe.model.Equipo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO: EquipoDAO - CRUD para equipos del cibercafé.
 * GA7-220501096-AA2-EV02
 */
public class EquipoDAO {

    public boolean agregar(Equipo equipo) throws SQLException {
        String sql = "INSERT INTO equipos (codigo, descripcion, estado, tarifa_hora) "
                   + "VALUES (?, ?, ?, ?)";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, equipo.getCodigo());
            ps.setString(2, equipo.getDescripcion());
            ps.setString(3, equipo.getEstado());
            ps.setDouble(4, equipo.getTarifaHora());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }

    public List<Equipo> listar() throws SQLException {
        List<Equipo> lista = new ArrayList<>();
        String sql = "SELECT * FROM equipos ORDER BY codigo";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                lista.add(mapearEquipo(rs));
            }
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return lista;
    }

    public List<Equipo> listarDisponibles() throws SQLException {
        List<Equipo> lista = new ArrayList<>();
        String sql = "SELECT * FROM equipos WHERE estado = 'disponible' ORDER BY codigo";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                lista.add(mapearEquipo(rs));
            }
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return lista;
    }

    public Equipo buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM equipos WHERE id_equipo = ?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapearEquipo(rs);
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return null;
    }

    public boolean actualizar(Equipo equipo) throws SQLException {
        String sql = "UPDATE equipos SET codigo=?, descripcion=?, estado=?, "
                   + "tarifa_hora=? WHERE id_equipo=?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, equipo.getCodigo());
            ps.setString(2, equipo.getDescripcion());
            ps.setString(3, equipo.getEstado());
            ps.setDouble(4, equipo.getTarifaHora());
            ps.setInt(5, equipo.getIdEquipo());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }

    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM equipos WHERE id_equipo = ?";
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

    private Equipo mapearEquipo(ResultSet rs) throws SQLException {
        Equipo e = new Equipo();
        e.setIdEquipo(rs.getInt("id_equipo"));
        e.setCodigo(rs.getString("codigo"));
        e.setDescripcion(rs.getString("descripcion"));
        e.setEstado(rs.getString("estado"));
        e.setTarifaHora(rs.getDouble("tarifa_hora"));
        return e;
    }
}
