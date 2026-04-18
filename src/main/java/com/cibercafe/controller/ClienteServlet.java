package com.cibercafe.controller;

import com.cibercafe.dao.ClienteDAO;
import com.cibercafe.model.Cliente;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet Controlador: ClienteServlet
 * Maneja todas las peticiones HTTP GET y POST para el módulo de Clientes.
 * Patrón MVC - Capa Controlador
 * GA7-220501096-AA2-EV02
 */
@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    // =============================================
    // GET: Listar, mostrar formulario agregar, cargar formulario editar
    // =============================================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

        try {
            switch (accion) {
                case "listar":
                    listarClientes(request, response);
                    break;
                case "nuevo":
                    mostrarFormularioNuevo(request, response);
                    break;
                case "editar":
                    mostrarFormularioEditar(request, response);
                    break;
                case "eliminar":
                    eliminarCliente(request, response);
                    break;
                default:
                    listarClientes(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Error en base de datos: " + e.getMessage(), e);
        }
    }

    // =============================================
    // POST: Guardar nuevo cliente o actualizar existente
    // =============================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        try {
            if ("guardar".equals(accion)) {
                guardarCliente(request, response);
            } else if ("actualizar".equals(accion)) {
                actualizarCliente(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Error en base de datos: " + e.getMessage(), e);
        }
    }

    // ---- Métodos privados del controlador ----

    private void listarClientes(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        List<Cliente> lista = clienteDAO.listar();
        req.setAttribute("listaClientes", lista);
        req.setAttribute("titulo", "Gestión de Clientes");
        req.getRequestDispatcher("/vistas/clientes/lista.jsp").forward(req, res);
    }

    private void mostrarFormularioNuevo(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("titulo", "Registrar Nuevo Cliente");
        req.getRequestDispatcher("/vistas/clientes/formulario.jsp").forward(req, res);
    }

    private void mostrarFormularioEditar(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Cliente cliente = clienteDAO.buscarPorId(id);
        req.setAttribute("cliente", cliente);
        req.setAttribute("titulo", "Editar Cliente");
        req.getRequestDispatcher("/vistas/clientes/formulario.jsp").forward(req, res);
    }

    private void guardarCliente(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, IOException {
        Cliente c = construirClienteDesdeFormulario(req);
        boolean exito = clienteDAO.agregar(c);
        String msg = exito ? "Cliente registrado exitosamente." : "Error al registrar cliente.";
        res.sendRedirect(req.getContextPath() + "/clientes?accion=listar&mensaje=" + msg);
    }

    private void actualizarCliente(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, IOException {
        Cliente c = construirClienteDesdeFormulario(req);
        c.setIdCliente(Integer.parseInt(req.getParameter("idCliente")));
        c.setEstado(req.getParameter("estado"));
        boolean exito = clienteDAO.actualizar(c);
        String msg = exito ? "Cliente actualizado correctamente." : "Error al actualizar cliente.";
        res.sendRedirect(req.getContextPath() + "/clientes?accion=listar&mensaje=" + msg);
    }

    private void eliminarCliente(HttpServletRequest req, HttpServletResponse res)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean exito = clienteDAO.eliminar(id);
        String msg = exito ? "Cliente eliminado." : "No se pudo eliminar el cliente.";
        res.sendRedirect(req.getContextPath() + "/clientes?accion=listar&mensaje=" + msg);
    }

    private Cliente construirClienteDesdeFormulario(HttpServletRequest req) {
        Cliente c = new Cliente();
        c.setNombre(req.getParameter("nombre"));
        c.setApellido(req.getParameter("apellido"));
        c.setDocumento(req.getParameter("documento"));
        c.setEmail(req.getParameter("email"));
        c.setTelefono(req.getParameter("telefono"));
        return c;
    }
}
