<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Nueva Reserva - Cibercafé</title>
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
        <h1>📋 <span>Nueva Reserva de Sesión</span></h1>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/reservas">← Volver</a>
    </div>

    <div class="card">
        <div class="card-header">Formulario de Reserva — la hora de inicio se registra automáticamente</div>
        <div class="form-container">

            <%-- Formulario POST hacia ReservaServlet --%>
            <form action="${pageContext.request.contextPath}/reservas" method="POST">
                <input type="hidden" name="accion" value="guardar">

                <%-- Selección de cliente --%>
                <div class="form-group">
                    <label for="idCliente">Cliente *</label>
                    <select id="idCliente" name="idCliente" class="form-control" required>
                        <option value="">-- Seleccione un cliente --</option>
                        <c:forEach var="cli" items="${listaClientes}">
                            <option value="${cli.idCliente}">
                                ${cli.nombre} ${cli.apellido} — Doc: ${cli.documento}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <%-- Selección de equipo disponible --%>
                <div class="form-group">
                    <label for="idEquipo">Equipo Disponible *</label>
                    <select id="idEquipo" name="idEquipo" class="form-control" required>
                        <option value="">-- Seleccione un equipo --</option>
                        <c:choose>
                            <c:when test="${not empty listaEquipos}">
                                <c:forEach var="eq" items="${listaEquipos}">
                                    <option value="${eq.idEquipo}">
                                        ${eq.codigo} — ${eq.descripcion} ($${eq.tarifaHora}/h)
                                    </option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <option disabled>No hay equipos disponibles en este momento</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                    <c:if test="${empty listaEquipos}">
                        <p style="color:#e53935; margin-top:6px; font-size:13px;">
                            ⚠️ Todos los equipos están ocupados o en mantenimiento.
                        </p>
                    </c:if>
                </div>

                <%-- Observaciones --%>
                <div class="form-group">
                    <label for="observaciones">Observaciones</label>
                    <textarea id="observaciones" name="observaciones"
                              class="form-control" rows="3"
                              placeholder="Notas adicionales sobre la sesión..."></textarea>
                </div>

                <div class="alert alert-info">
                    ℹ️ La fecha y hora de inicio se registran automáticamente al crear la reserva.
                    Para finalizar la sesión use el botón <strong>"Finalizar"</strong> en el listado.
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"
                            ${empty listaEquipos ? 'disabled' : ''}>
                        📋 Iniciar Sesión
                    </button>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/reservas">✖ Cancelar</a>
                </div>

            </form>
        </div>
    </div>
</div>

<footer>
    Sistema de Gestión Cibercafé &copy; 2024 | SENA — GA7-220501096-AA2-EV02
</footer>
</body>
</html>
