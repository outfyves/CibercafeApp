package com.cibercafe.controller;

import com.cibercafe.dao.ServicioDAO;
import com.cibercafe.model.Servicio;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet Controlador: ServicioServlet
 * Maneja GET y POST para el módulo de Servicios adicionales.
 * GA7-220501096-AA2-EV02
 */
@WebServlet("/servicios")
public class ServicioServlet extends HttpServlet {

    private final ServicioDAO servicioDAO = new ServicioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";
        try {
            switch (accion) {
                case "listar":
                    List<Servicio> lista = servicioDAO.listar();
                    request.setAttribute("listaServicios", lista);
                    request.setAttribute("titulo", "Gestión de Servicios");
                    request.getRequestDispatcher("/vistas/servicios/lista.jsp").forward(request, response);
                    break;
                case "nuevo":
                    request.setAttribute("titulo", "Nuevo Servicio");
                    request.getRequestDispatcher("/vistas/servicios/formulario.jsp").forward(request, response);
                    break;
                case "editar":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Servicio s = servicioDAO.buscarPorId(id);
                    request.setAttribute("servicio", s);
                    request.setAttribute("titulo", "Editar Servicio");
                    request.getRequestDispatcher("/vistas/servicios/formulario.jsp").forward(request, response);
                    break;
                case "eliminar":
                    servicioDAO.eliminar(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect(request.getContextPath() + "/servicios?mensaje=Servicio+eliminado");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/servicios");
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
            Servicio s = new Servicio();
            s.setNombre(request.getParameter("nombre"));
            s.setDescripcion(request.getParameter("descripcion"));
            s.setPrecio(Double.parseDouble(request.getParameter("precio")));
            s.setEstado(request.getParameter("estado") != null ? request.getParameter("estado") : "activo");

            if ("guardar".equals(accion)) {
                servicioDAO.agregar(s);
                response.sendRedirect(request.getContextPath() + "/servicios?mensaje=Servicio+registrado");
            } else if ("actualizar".equals(accion)) {
                s.setIdServicio(Integer.parseInt(request.getParameter("idServicio")));
                servicioDAO.actualizar(s);
                response.sendRedirect(request.getContextPath() + "/servicios?mensaje=Servicio+actualizado");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
