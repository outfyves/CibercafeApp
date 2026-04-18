<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Servicios - Cibercafé</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<nav class="navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <span>💻</span> Cibercafé SENA
    </a>
    <div class="navbar-nav">
        <a class="nav-link" href="${pageContext.request.contextPath}/">Inicio</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/clientes">Clientes</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/equipos">Equipos</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/reservas">Reservas</a>
        <a class="nav-link active" href="${pageContext.request.contextPath}/servicios">Servicios</a>
    </div>
</nav>

<div class="container">

    <div class="page-header">
        <h1>🛎️ Gestión de <span>Servicios</span></h1>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/servicios?accion=nuevo">
            ➕ Nuevo Servicio
        </a>
    </div>

    <c:if test="${not empty param.mensaje}">
        <div class="alert alert-success">${param.mensaje}</div>
    </c:if>

    <div class="card">
        <div class="card-header">Catálogo de Servicios Adicionales</div>
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio (COP)</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listaServicios}">
                            <c:forEach var="sv" items="${listaServicios}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>
                                    <td><strong>${sv.nombre}</strong></td>
                                    <td>${sv.descripcion}</td>
                                    <td>$<c:out value="${sv.precio}"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${sv.estado == 'activo'}">
                                                <span class="badge badge-success">Activo</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Inactivo</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="display:flex; gap:6px;">
                                        <a class="btn btn-warning btn-sm"
                                           href="${pageContext.request.contextPath}/servicios?accion=editar&id=${sv.idServicio}">
                                            ✏️ Editar
                                        </a>
                                        <a class="btn btn-danger btn-sm"
                                           href="${pageContext.request.contextPath}/servicios?accion=eliminar&id=${sv.idServicio}"
                                           onclick="return confirm('¿Eliminar servicio ${sv.nombre}?')">
                                            🗑️ Eliminar
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" style="text-align:center; padding:28px; color:#757575;">
                                    No hay servicios registrados.
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
