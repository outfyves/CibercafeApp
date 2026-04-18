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
        <a class="nav-link" href="${pageContext.request.contextPath}/equipos">Equipos</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/reservas">Reservas</a>
        <a class="nav-link active" href="${pageContext.request.contextPath}/servicios">Servicios</a>
    </div>
</nav>

<div class="container">

    <div class="page-header">
        <h1>🛎️ <span>${titulo}</span></h1>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/servicios">← Volver</a>
    </div>

    <div class="card">
        <div class="card-header">${titulo}</div>
        <div class="form-container">

            <form action="${pageContext.request.contextPath}/servicios" method="POST">

                <c:choose>
                    <c:when test="${not empty servicio}">
                        <input type="hidden" name="accion"     value="actualizar">
                        <input type="hidden" name="idServicio" value="${servicio.idServicio}">
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="accion" value="guardar">
                    </c:otherwise>
                </c:choose>

                <div class="form-group">
                    <label for="nombre">Nombre del Servicio *</label>
                    <input type="text" id="nombre" name="nombre" class="form-control"
                           value="${servicio.nombre}"
                           placeholder="Ej: Impresión a color" required maxlength="100">
                </div>

                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <input type="text" id="descripcion" name="descripcion" class="form-control"
                           value="${servicio.descripcion}"
                           placeholder="Descripción breve del servicio" maxlength="300">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="precio">Precio (COP) *</label>
                        <input type="number" id="precio" name="precio" class="form-control"
                               value="${not empty servicio ? servicio.precio : ''}"
                               min="0" step="50" required placeholder="Ej: 500">
                    </div>
                    <div class="form-group">
                        <label for="estado">Estado</label>
                        <select id="estado" name="estado" class="form-control">
                            <option value="activo"   ${servicio.estado == 'activo'   ? 'selected' : ''}>Activo</option>
                            <option value="inactivo" ${servicio.estado == 'inactivo' ? 'selected' : ''}>Inactivo</option>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty servicio}">💾 Actualizar</c:when>
                            <c:otherwise>➕ Registrar Servicio</c:otherwise>
                        </c:choose>
                    </button>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/servicios">✖ Cancelar</a>
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
