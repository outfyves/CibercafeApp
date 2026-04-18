package com.cibercafe.controller;

import com.cibercafe.dao.ClienteDAO;
import com.cibercafe.dao.EquipoDAO;
import com.cibercafe.dao.ReservaDAO;
import com.cibercafe.model.Equipo;
import com.cibercafe.model.Reserva;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet Controlador: ReservaServlet
 * Maneja las peticiones HTTP GET y POST para el módulo de Reservas.
 * GA7-220501096-AA2-EV02
 */
@WebServlet("/reservas")
public class ReservaServlet extends HttpServlet {

    private final ReservaDAO  reservaDAO  = new ReservaDAO();
    private final ClienteDAO  clienteDAO  = new ClienteDAO();
    private final EquipoDAO   equipoDAO   = new EquipoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        try {
            switch (accion) {
                case "listar":
                    listarReservas(request, response);
                    break;
                case "nuevo":
                    cargarFormularioNuevo(request, response);
                    break;
                case "finalizar":
                    finalizarReserva(request, response);
                    break;
                case "eliminar":
                    eliminarReserva(request, response);
                    break;
                default:
                    listarReservas(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        try {
            if ("guardar".equals(accion)) {
                Reserva r = new Reserva();
                r.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
                r.setIdEquipo(Integer.parseInt(request.getParameter("idEquipo")));
                r.setObservaciones(request.getParameter("observaciones"));
                reservaDAO.agregar(r);
                response.sendRedirect(request.getContextPath() + "/reservas?mensaje=Reserva+creada+exitosamente");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listarReservas(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        List<Reserva> lista = reservaDAO.listar();
        req.setAttribute("listaReservas", lista);
        req.setAttribute("titulo", "Gestión de Reservas");
        req.getRequestDispatcher("/vistas/reservas/lista.jsp").forward(req, res);
    }

    private void cargarFormularioNuevo(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        req.setAttribute("listaClientes", clienteDAO.listar());
        req.setAttribute("listaEquipos",  equipoDAO.listarDisponibles());
        req.setAttribute("titulo", "Nueva Reserva");
        req.getRequestDispatcher("/vistas/reservas/formulario.jsp").forward(req, res);
    }

    private void finalizarReserva(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, IOException {
        int idReserva = Integer.parseInt(req.getParameter("id"));
        int idEquipo  = Integer.parseInt(req.getParameter("idEquipo"));
        Equipo e = equipoDAO.buscarPorId(idEquipo);
        double tarifa = (e != null) ? e.getTarifaHora() : 2500.0;
        reservaDAO.finalizar(idReserva, idEquipo, tarifa);
        res.sendRedirect(req.getContextPath() + "/reservas?mensaje=Reserva+finalizada");
    }

    private void eliminarReserva(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        reservaDAO.eliminar(id);
        res.sendRedirect(req.getContextPath() + "/reservas?mensaje=Reserva+eliminada");
    }
}
