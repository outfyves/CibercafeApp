<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Equipos - Cibercafé</title>
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/equipos">Equipos</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/reservas">Reservas</a>
    </div>
</nav>

<div class="container">

    <div class="page-header">
        <h1>🖥️ Gestión de <span>Equipos</span></h1>
        <a class="btn btn-primary"
           href="${pageContext.request.contextPath}/equipos?accion=nuevo">
            ➕ Nuevo Equipo
        </a>
    </div>

    <c:if test="${not empty param.mensaje}">
        <div class="alert alert-success">${param.mensaje}</div>
    </c:if>

    <div class="card">
        <div class="card-header">Inventario de Equipos</div>
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Código</th>
                        <th>Descripción</th>
                        <th>Tarifa/Hora</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listaEquipos}">
                            <c:forEach var="eq" items="${listaEquipos}" varStatus="i">
                                <tr>
                                    <td>${i.count}</td>
                                    <td><strong>${eq.codigo}</strong></td>
                                    <td>${eq.descripcion}</td>
                                    <td>$<c:out value="${eq.tarifaHora}"/>/h</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${eq.estado == 'disponible'}">
                                                <span class="badge badge-success">Disponible</span>
                                            </c:when>
                                            <c:when test="${eq.estado == 'ocupado'}">
                                                <span class="badge badge-warning">Ocupado</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Mantenimiento</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="display:flex; gap:6px; flex-wrap:wrap;">
                                        <a class="btn btn-warning btn-sm"
                                           href="${pageContext.request.contextPath}/equipos?accion=editar&id=${eq.idEquipo}">
                                            ✏️ Editar
                                        </a>
                                        <a class="btn btn-danger btn-sm"
                                           href="${pageContext.request.contextPath}/equipos?accion=eliminar&id=${eq.idEquipo}"
                                           onclick="return confirm('¿Eliminar equipo ${eq.codigo}?')">
                                            🗑️ Eliminar
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="6" style="text-align:center; padding:28px; color:#757575;">
                                    No hay equipos registrados.
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
