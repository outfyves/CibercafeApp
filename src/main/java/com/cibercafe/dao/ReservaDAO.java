package com.cibercafe.dao;

import com.cibercafe.config.ConexionDB;
import com.cibercafe.model.Reserva;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO: ReservaDAO - CRUD para reservas del cibercafé.
 * GA7-220501096-AA2-EV02
 */
public class ReservaDAO {

    public boolean agregar(Reserva r) throws SQLException {
        String sql = "INSERT INTO reservas (id_cliente, id_equipo, fecha_inicio, "
                   + "estado, observaciones) VALUES (?, ?, NOW(), 'activa', ?)";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, r.getIdCliente());
            ps.setInt(2, r.getIdEquipo());
            ps.setString(3, r.getObservaciones());

            boolean ok = ps.executeUpdate() > 0;
            if (ok) {
                // Marcar equipo como ocupado
                String upd = "UPDATE equipos SET estado='ocupado' WHERE id_equipo=?";
                PreparedStatement ps2 = con.prepareStatement(upd);
                ps2.setInt(1, r.getIdEquipo());
                ps2.executeUpdate();
            }
            return ok;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }

    public List<Reserva> listar() throws SQLException {
        List<Reserva> lista = new ArrayList<>();
        String sql = "SELECT r.*, "
                   + "CONCAT(c.nombre,' ',c.apellido) AS nombre_cliente, "
                   + "e.codigo AS codigo_equipo "
                   + "FROM reservas r "
                   + "JOIN clientes c ON r.id_cliente = c.id_cliente "
                   + "JOIN equipos  e ON r.id_equipo  = e.id_equipo "
                   + "ORDER BY r.fecha_inicio DESC";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Reserva res = mapearReserva(rs);
                res.setNombreCliente(rs.getString("nombre_cliente"));
                res.setCodigoEquipo(rs.getString("codigo_equipo"));
                lista.add(res);
            }
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return lista;
    }

    public Reserva buscarPorId(int id) throws SQLException {
        String sql = "SELECT r.*, "
                   + "CONCAT(c.nombre,' ',c.apellido) AS nombre_cliente, "
                   + "e.codigo AS codigo_equipo "
                   + "FROM reservas r "
                   + "JOIN clientes c ON r.id_cliente = c.id_cliente "
                   + "JOIN equipos  e ON r.id_equipo  = e.id_equipo "
                   + "WHERE r.id_reserva = ?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Reserva r = mapearReserva(rs);
                r.setNombreCliente(rs.getString("nombre_cliente"));
                r.setCodigoEquipo(rs.getString("codigo_equipo"));
                return r;
            }
        } finally {
            ConexionDB.cerrarConexion(con);
        }
        return null;
    }

    /**
     * Finaliza una reserva: registra fecha_fin, calcula horas y total.
     */
    public boolean finalizar(int idReserva, int idEquipo, double tarifaHora) throws SQLException {
        String sql = "UPDATE reservas SET fecha_fin=NOW(), "
                   + "horas = ROUND(TIMESTAMPDIFF(MINUTE, fecha_inicio, NOW())/60.0, 2), "
                   + "total_pago = ROUND(TIMESTAMPDIFF(MINUTE, fecha_inicio, NOW())/60.0, 2) * ?, "
                   + "estado='finalizada' WHERE id_reserva=?";
        Connection con = null;
        try {
            con = ConexionDB.obtenerConexion();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, tarifaHora);
            ps.setInt(2, idReserva);
            boolean ok = ps.executeUpdate() > 0;
            if (ok) {
                String upd = "UPDATE equipos SET estado='disponible' WHERE id_equipo=?";
                PreparedStatement ps2 = con.prepareStatement(upd);
                ps2.setInt(1, idEquipo);
                ps2.executeUpdate();
            }
            return ok;
        } finally {
            ConexionDB.cerrarConexion(con);
        }
    }

    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM reservas WHERE id_reserva = ?";
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

    private Reserva mapearReserva(ResultSet rs) throws SQLException {
        Reserva r = new Reserva();
        r.setIdReserva(rs.getInt("id_reserva"));
        r.setIdCliente(rs.getInt("id_cliente"));
        r.setIdEquipo(rs.getInt("id_equipo"));
        r.setFechaInicio(rs.getString("fecha_inicio"));
        r.setFechaFin(rs.getString("fecha_fin"));
        r.setHoras(rs.getDouble("horas"));
        r.setTotalPago(rs.getDouble("total_pago"));
        r.setEstado(rs.getString("estado"));
        r.setObservaciones(rs.getString("observaciones"));
        return r;
    }
}
