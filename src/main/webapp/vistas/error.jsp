<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isErrorPage="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Error - Cibercafé</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css">
</head>
<body>
<nav class="navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/"><span>💻</span> Cibercafé SENA</a>
</nav>
<div class="container" style="text-align:center; padding-top:60px;">
    <h1 style="font-size:72px; color:#e53935;">⚠️</h1>
    <h2>Ha ocurrido un error</h2>
    <p style="color:#757575; margin:16px 0;">
        Se produjo un problema al procesar tu solicitud.
    </p>
    <% if (exception != null) { %>
        <div class="alert alert-danger" style="text-align:left; max-width:600px; margin:16px auto;">
            <strong>Detalle:</strong> <%= exception.getMessage() %>
        </div>
    <% } %>
    <a class="btn btn-primary" href="${pageContext.request.contextPath}/">🏠 Volver al Inicio</a>
</div>
</body>
</html>
