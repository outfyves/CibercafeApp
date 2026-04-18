<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${titulo} - Cibercafé</title>
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
        <h1>🖥️ <span>${titulo}</span></h1>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/equipos">← Volver</a>
    </div>

    <div class="card">
        <div class="card-header">${titulo}</div>
        <div class="form-container">

            <%-- POST hacia el servlet de equipos --%>
            <form action="${pageContext.request.contextPath}/equipos" method="POST">

                <c:choose>
                    <c:when test="${not empty equipo}">
                        <input type="hidden" name="accion"   value="actualizar">
                        <input type="hidden" name="idEquipo" value="${equipo.idEquipo}">
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="accion" value="guardar">
                    </c:otherwise>
                </c:choose>

                <div class="form-row">
                    <div class="form-group">
                        <label for="codigo">Código *</label>
                        <input type="text" id="codigo" name="codigo" class="form-control"
                               value="${equipo.codigo}" placeholder="Ej: PC-05"
                               required maxlength="20">
                    </div>
                    <div class="form-group">
                        <label for="tarifaHora">Tarifa por Hora (COP) *</label>
                        <input type="number" id="tarifaHora" name="tarifaHora" class="form-control"
                               value="${not empty equipo ? equipo.tarifaHora : '2500'}"
                               min="0" step="100" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <input type="text" id="descripcion" name="descripcion" class="form-control"
                           value="${equipo.descripcion}"
                           placeholder="Ej: Computador de escritorio zona A"
                           maxlength="200">
                </div>

                <div class="form-group">
                    <label for="estado">Estado *</label>
                    <select id="estado" name="estado" class="form-control" required>
                        <option value="disponible"    ${equipo.estado == 'disponible'    ? 'selected' : ''}>Disponible</option>
                        <option value="ocupado"       ${equipo.estado == 'ocupado'       ? 'selected' : ''}>Ocupado</option>
                        <option value="mantenimiento" ${equipo.estado == 'mantenimiento' ? 'selected' : ''}>En Mantenimiento</option>
                    </select>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty equipo}">💾 Actualizar</c:when>
                            <c:otherwise>➕ Registrar Equipo</c:otherwise>
                        </c:choose>
                    </button>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/equipos">✖ Cancelar</a>
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
