<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Clientes - Cibercafé</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<nav class="navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <span>💻</span> Cibercafé SENA
    </a>
    <div class="navbar-nav">
        <a class="nav-link" href="${pageContext.request.contextPath}/">Inicio</a>
        <a class="nav-link active" href="${pageContext.request.contextPath}/clientes">Clientes</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/equipos">Equipos</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/reservas">Reservas</a>
    </div>
</nav>

<div class="container">

    <div class="page-header">
        <h1>👥 Gestión de <span>Clientes</span></h1>
        <a class="btn btn-primary"
           href="${pageContext.request.contextPath}/clientes?accion=nuevo">
            ➕ Nuevo Cliente
        </a>
    </div>

    <%-- Mensaje de operación --%>
    <c:if test="${not empty param.mensaje}">
        <div class="alert alert-success">${param.mensaje}</div>
    </c:if>

    <div class="card">
        <div class="card-header">Lista de Clientes Registrados</div>
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre Completo</th>
                        <th>Documento</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Registro</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- JSTL: iterar lista de clientes --%>
                    <c:choose>
                        <c:when test="${not empty listaClientes}">
                            <c:forEach var="cliente" items="${listaClientes}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>
                                    <td><strong>${cliente.nombre} ${cliente.apellido}</strong></td>
                                    <td>${cliente.documento}</td>
                                    <td>${cliente.email}</td>
                                    <td>${cliente.telefono}</td>
                                    <td>${cliente.fechaRegistro}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${cliente.estado == 'activo'}">
                                                <span class="badge badge-success">Activo</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Inactivo</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="display:flex; gap:6px; flex-wrap:wrap;">
                                        <%-- Botón Editar (GET) --%>
                                        <a class="btn btn-warning btn-sm"
                                           href="${pageContext.request.contextPath}/clientes?accion=editar&id=${cliente.idCliente}">
                                            ✏️ Editar
                                        </a>
                                        <%-- Botón Eliminar (GET con confirmación JS) --%>
                                        <a class="btn btn-danger btn-sm"
                                           href="${pageContext.request.contextPath}/clientes?accion=eliminar&id=${cliente.idCliente}"
                                           onclick="return confirm('¿Eliminar a ${cliente.nombre} ${cliente.apellido}?')">
                                            🗑️ Eliminar
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" style="text-align:center; padding:28px; color:#757575;">
                                    No hay clientes registrados aún.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</div>

<footer>
    Sistema de Gestión Cibercafé &copy; 2024 | SENA — GA7-220501096-AA2-EV02
</footer>
</body>
</html>
