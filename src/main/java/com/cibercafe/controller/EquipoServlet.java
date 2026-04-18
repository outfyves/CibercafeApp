package com.cibercafe.controller;

import com.cibercafe.dao.EquipoDAO;
import com.cibercafe.model.Equipo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet Controlador: EquipoServlet
 * Maneja las peticiones HTTP GET y POST para el módulo de Equipos.
 * GA7-220501096-AA2-EV02
 */
@WebServlet("/equipos")
public class EquipoServlet extends HttpServlet {

    private final EquipoDAO equipoDAO = new EquipoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        try {
            switch (accion) {
                case "listar":
                    listarEquipos(request, response);
                    break;
                case "nuevo":
                    request.setAttribute("titulo", "Registrar Equipo");
                    request.getRequestDispatcher("/vistas/equipos/formulario.jsp").forward(request, response);
                    break;
                case "editar":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Equipo equipo = equipoDAO.buscarPorId(id);
                    request.setAttribute("equipo", equipo);
                    request.setAttribute("titulo", "Editar Equipo");
                    request.getRequestDispatcher("/vistas/equipos/formulario.jsp").forward(request, response);
                    break;
                case "eliminar":
                    eliminar(request, response);
                    break;
                default:
                    listarEquipos(request, response);
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
                Equipo e = buildEquipo(request);
                equipoDAO.agregar(e);
                response.sendRedirect(request.getContextPath() + "/equipos?mensaje=Equipo+registrado");
            } else if ("actualizar".equals(accion)) {
                Equipo e = buildEquipo(request);
                e.setIdEquipo(Integer.parseInt(request.getParameter("idEquipo")));
                equipoDAO.actualizar(e);
                response.sendRedirect(request.getContextPath() + "/equipos?mensaje=Equipo+actualizado");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listarEquipos(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        List<Equipo> lista = equipoDAO.listar();
        req.setAttribute("listaEquipos", lista);
        req.setAttribute("titulo", "Gestión de Equipos");
        req.getRequestDispatcher("/vistas/equipos/lista.jsp").forward(req, res);
    }

    private void eliminar(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        equipoDAO.eliminar(id);
        res.sendRedirect(req.getContextPath() + "/equipos?mensaje=Equipo+eliminado");
    }

    private Equipo buildEquipo(HttpServletRequest req) {
        Equipo e = new Equipo();
        e.setCodigo(req.getParameter("codigo"));
        e.setDescripcion(req.getParameter("descripcion"));
        e.setEstado(req.getParameter("estado"));
        e.setTarifaHora(Double.parseDouble(req.getParameter("tarifaHora")));
        return e;
    }
}
