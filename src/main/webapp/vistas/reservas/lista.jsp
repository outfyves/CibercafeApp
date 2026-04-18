<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reservas - Cibercafé</title>
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/reservas">Reservas</a>
    </div>
</nav>

<div class="container">

    <div class="page-header">
        <h1>📋 Gestión de <span>Reservas</span></h1>
        <a class="btn btn-primary"
           href="${pageContext.request.contextPath}/reservas?accion=nuevo">
            ➕ Nueva Reserva
        </a>
    </div>

    <c:if test="${not empty param.mensaje}">
        <div class="alert alert-success">${param.mensaje}</div>
    </c:if>

    <div class="card">
        <div class="card-header">Historial de Reservas / Sesiones</div>
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Cliente</th>
                        <th>Equipo</th>
                        <th>Inicio</th>
                        <th>Fin</th>
                        <th>Horas</th>
                        <th>Total</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty listaReservas}">
                            <c:forEach var="res" items="${listaReservas}" varStatus="i">
                                <tr>
                                    <td>${res.idReserva}</td>
                                    <td>${res.nombreCliente}</td>
                                    <td><strong>${res.codigoEquipo}</strong></td>
                                    <td>${res.fechaInicio}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty res.fechaFin}">${res.fechaFin}</c:when>
                                            <c:otherwise><em style="color:#757575">En curso...</em></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.horas > 0}">${res.horas}h</c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.totalPago > 0}">$${res.totalPago}</c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.estado == 'activa'}">
                                                <span class="badge badge-warning">Activa</span>
                                            </c:when>
                                            <c:when test="${res.estado == 'finalizada'}">
                                                <span class="badge badge-success">Finalizada</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-danger">Cancelada</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="display:flex; gap:5px; flex-wrap:wrap;">
                                        <c:if test="${res.estado == 'activa'}">
                                            <a class="btn btn-success btn-sm"
                                               href="${pageContext.request.contextPath}/reservas?accion=finalizar&id=${res.idReserva}&idEquipo=${res.idEquipo}"
                                               onclick="return confirm('¿Finalizar esta sesión?')">
                                                ✅ Finalizar
                                            </a>
                                        </c:if>
                                        <a class="btn btn-danger btn-sm"
                                           href="${pageContext.request.contextPath}/reservas?accion=eliminar&id=${res.idReserva}"
                                           onclick="return confirm('¿Eliminar reserva #${res.idReserva}?')">
                                            🗑️
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="9" style="text-align:center; padding:28px; color:#757575;">
                                    No hay reservas registradas.
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
