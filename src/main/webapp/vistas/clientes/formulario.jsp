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
        <a class="nav-link active" href="${pageContext.request.contextPath}/clientes">Clientes</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/equipos">Equipos</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/reservas">Reservas</a>
    </div>
</nav>

<div class="container">

    <div class="page-header">
        <h1>👤 <span>${titulo}</span></h1>
        <a class="btn btn-secondary"
           href="${pageContext.request.contextPath}/clientes">
            ← Volver al listado
        </a>
    </div>

    <div class="card">
        <div class="card-header">${titulo}</div>
        <div class="form-container">

            <%--
                Formulario HTML con Servlet:
                - Si es EDITAR: accion=actualizar + campos prellenados (JSTL EL)
                - Si es NUEVO:  accion=guardar + campos vacíos
                Método POST según lineamientos del componente formativo
            --%>
            <form action="${pageContext.request.contextPath}/clientes" method="POST">

                <%-- Campo oculto para distinguir guardar vs actualizar --%>
                <c:choose>
                    <c:when test="${not empty cliente}">
                        <input type="hidden" name="accion" value="actualizar">
                        <input type="hidden" name="idCliente" value="${cliente.idCliente}">
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="accion" value="guardar">
                    </c:otherwise>
                </c:choose>

                <%-- Fila 1: Nombre y Apellido --%>
                <div class="form-row">
                    <div class="form-group">
                        <label for="nombre">Nombre *</label>
                        <input type="text"
                               id="nombre"
                               name="nombre"
                               class="form-control"
                               value="${cliente.nombre}"
                               placeholder="Ej: Carlos"
                               required maxlength="100">
                    </div>
                    <div class="form-group">
                        <label for="apellido">Apellido *</label>
                        <input type="text"
                               id="apellido"
                               name="apellido"
                               class="form-control"
                               value="${cliente.apellido}"
                               placeholder="Ej: García"
                               required maxlength="100">
                    </div>
                </div>

                <%-- Fila 2: Documento y Teléfono --%>
                <div class="form-row">
                    <div class="form-group">
                        <label for="documento">N° Documento *</label>
                        <input type="text"
                               id="documento"
                               name="documento"
                               class="form-control"
                               value="${cliente.documento}"
                               placeholder="Ej: 1001234567"
                               required maxlength="20">
                    </div>
                    <div class="form-group">
                        <label for="telefono">Teléfono</label>
                        <input type="tel"
                               id="telefono"
                               name="telefono"
                               class="form-control"
                               value="${cliente.telefono}"
                               placeholder="Ej: 3001234567"
                               maxlength="20">
                    </div>
                </div>

                <%-- Email --%>
                <div class="form-group">
                    <label for="email">Correo Electrónico *</label>
                    <input type="email"
                           id="email"
                           name="email"
                           class="form-control"
                           value="${cliente.email}"
                           placeholder="correo@ejemplo.com"
                           required maxlength="150">
                </div>

                <%-- Estado (solo en edición) --%>
                <c:if test="${not empty cliente}">
                    <div class="form-group">
                        <label for="estado">Estado</label>
                        <select id="estado" name="estado" class="form-control">
                            <option value="activo"   ${cliente.estado == 'activo'   ? 'selected' : ''}>Activo</option>
                            <option value="inactivo" ${cliente.estado == 'inactivo' ? 'selected' : ''}>Inactivo</option>
                        </select>
                    </div>
                </c:if>

                <%-- Botones de acción --%>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty cliente}">💾 Actualizar</c:when>
                            <c:otherwise>➕ Registrar Cliente</c:otherwise>
                        </c:choose>
                    </button>
                    <a class="btn btn-secondary"
                       href="${pageContext.request.contextPath}/clientes">
                        ✖ Cancelar
                    </a>
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
