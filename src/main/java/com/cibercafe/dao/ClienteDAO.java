package com.cibercafe.dao;

import com.cibercafe.config.ConexionDB;
import com.cibercafe.model.Cliente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO (Data Access Object): ClienteDAO
 * Contiene todos los métodos CRUD para la entidad Cliente.
 * GA7-220501096-AA2-EV02
 */
public class ClienteDAO {

    // =============================================
    // CREATE - Agregar nuevo cliente
    // =============================================
    public boolean agregar(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO clientes (nombre, apellido, documento, email, telefono) "
                   + "VALUES (?, ?, ?, ?, ?)";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellido());
            ps.setString(3, cliente.getDocumento());
            ps.setString(4, cliente.getEmail());
            ps.setString(5, cliente.getTelefono());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }

    // =============================================
    // READ - Listar todos los clientes
    // =============================================
    public List<Cliente> listar() throws SQLException {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM clientes ORDER BY apellido, nombre";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Cliente c = mapearCliente(rs);
                lista.add(c);
            }
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return lista;
    }

    // =============================================
    // READ - Buscar cliente por ID
    // =============================================
    public Cliente buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM clientes WHERE id_cliente = ?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapearCliente(rs);
            }
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return null;
    }

    // =============================================
    // UPDATE - Actualizar cliente
    // =============================================
    public boolean actualizar(Cliente cliente) throws SQLException {
        String sql = "UPDATE clientes SET nombre=?, apellido=?, documento=?, "
                   + "email=?, telefono=?, estado=? WHERE id_cliente=?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellido());
            ps.setString(3, cliente.getDocumento());
            ps.setString(4, cliente.getEmail());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getEstado());
            ps.setInt(7, cliente.getIdCliente());
            return ps.executeUpdate() > 0;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }

    // =============================================
    // DELETE - Eliminar cliente por ID
    // =============================================
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM clientes WHERE id_cliente = ?";
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

    // =============================================
    // Método auxiliar: mapear ResultSet → Cliente
    // =============================================
    private Cliente mapearCliente(ResultSet rs) throws SQLException {
        Cliente c = new Cliente();
        c.setIdCliente(rs.getInt("id_cliente"));
        c.setNombre(rs.getString("nombre"));
        c.setApellido(rs.getString("apellido"));
        c.setDocumento(rs.getString("documento"));
        c.setEmail(rs.getString("email"));
        c.setTelefono(rs.getString("telefono"));
        c.setFechaRegistro(rs.getString("fecha_registro"));
        c.setEstado(rs.getString("estado"));
        return c;
    }
}
