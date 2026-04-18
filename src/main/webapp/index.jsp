<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema Cibercafé - Inicio</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>

<%-- ===== NAVBAR ===== --%>
<nav class="navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <span>💻</span> Cibercafé SENA
    </a>
    <div class="navbar-nav">
        <a class="nav-link active" href="${pageContext.request.contextPath}/">Inicio</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/clientes">Clientes</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/equipos">Equipos</a>
        <a class="nav-link" href="${pageContext.request.contextPath}/reservas">Reservas</a>
    </div>
</nav>

<div class="container">

    <%-- Mensaje de sesión si existe --%>
    <c:if test="${not empty param.mensaje}">
        <div class="alert alert-info">${param.mensaje}</div>
    </c:if>

    <%-- Encabezado --%>
    <div class="page-header">
        <h1>Panel de <span>Control</span></h1>
        <small style="color:#757575">GA7-220501096-AA2-EV02 | Sistema MVC con Servlets y JSP</small>
    </div>

    <%-- Tarjetas de estadísticas --%>
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon blue">👥</div>
            <div class="stat-info">
                <h3>Clientes</h3>
                <p>Gestión de usuarios registrados</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon green">🖥️</div>
            <div class="stat-info">
                <h3>Equipos</h3>
                <p>Control de computadores</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon orange">📋</div>
            <div class="stat-info">
                <h3>Reservas</h3>
                <p>Sesiones de uso activas</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon cyan">🛎️</div>
            <div class="stat-info">
                <h3>Servicios</h3>
                <p>Impresión, escaneo y más</p>
            </div>
        </div>
    </div>

    <%-- Accesos rápidos --%>
    <div class="card">
        <div class="card-header">🚀 Accesos Rápidos</div>
        <div style="padding:24px; display:flex; gap:12px; flex-wrap:wrap;">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/clientes?accion=nuevo">
                ➕ Nuevo Cliente
            </a>
            <a class="btn btn-success" href="${pageContext.request.contextPath}/equipos?accion=nuevo">
                ➕ Nuevo Equipo
            </a>
            <a class="btn btn-warning" href="${pageContext.request.contextPath}/reservas?accion=nuevo">
                📋 Nueva Reserva
            </a>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/clientes">
                📄 Ver Clientes
            </a>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/equipos">
                🖥️ Ver Equipos
            </a>
        </div>
    </div>

    <%-- Info del proyecto --%>
    <div class="card" style="margin-top:16px;">
        <div class="card-header">ℹ️ Información del Proyecto</div>
        <div style="padding:24px;">
            <table style="width:auto; border-collapse:collapse;">
                <tr><td style="padding:6px 20px 6px 0; font-weight:600;">Evidencia:</td>
                    <td>GA7-220501096-AA2-EV02</td></tr>
                <tr><td style="padding:6px 20px 6px 0; font-weight:600;">Tecnología:</td>
                    <td>Java EE — Servlets + JSP (patrón MVC)</td></tr>
                <tr><td style="padding:6px 20px 6px 0; font-weight:600;">Servidor:</td>
                    <td>Apache Tomcat 9/10</td></tr>
                <tr><td style="padding:6px 20px 6px 0; font-weight:600;">Base de datos:</td>
                    <td>MySQL — proyecto_cibercafe</td></tr>
                <tr><td style="padding:6px 20px 6px 0; font-weight:600;">Módulos:</td>
                    <td>Clientes, Equipos, Reservas (CRUD completo)</td></tr>
            </table>
        </div>
    </div>

</div>

<footer>
    Sistema de Gestión Cibercafé &copy; 2024 | SENA — Construcción de Aplicaciones con JAVA
</footer>

</body>
</html>
