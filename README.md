# 💻 Sistema de Gestión Cibercafé
## GA7-220501096-AA2-EV02 — Módulos de software codificados y probados

---

## 📌 Información del Proyecto

| Campo           | Detalle                                              |
|----------------|------------------------------------------------------|
| **Evidencia**  | GA7-220501096-AA2-EV02                               |
| **Programa**   | Análisis y Desarrollo de Software — SENA             |
| **Componente** | Construcción de aplicaciones con JAVA                |
| **Tecnología** | Java EE — Servlets + JSP + MySQL (Patrón MVC)        |
| **Servidor**   | Apache Tomcat 9/10                                   |
| **BD**         | MySQL — `proyecto_cibercafe`                         |

---

## 🔗 Repositorio Git

> **URL del repositorio:**  
> `https://github.com/[TU_USUARIO]/CibercafeApp`  
> *(Reemplazar con la URL real luego de hacer push)*

---

## 🏗️ Arquitectura MVC

```
CibercafeApp/
├── src/main/
│   ├── java/com/cibercafe/
│   │   ├── config/
│   │   │   └── ConexionDB.java          ← Configuración BD
│   │   ├── model/
│   │   │   ├── Cliente.java             ← Entidad Cliente
│   │   │   ├── Equipo.java              ← Entidad Equipo
│   │   │   ├── Reserva.java             ← Entidad Reserva
│   │   │   └── Servicio.java            ← Entidad Servicio
│   │   ├── dao/
│   │   │   ├── ClienteDAO.java          ← CRUD Clientes
│   │   │   ├── EquipoDAO.java           ← CRUD Equipos
│   │   │   ├── ReservaDAO.java          ← CRUD Reservas
│   │   │   └── ServicioDAO.java         ← CRUD Servicios
│   │   └── controller/
│   │       ├── ClienteServlet.java      ← Controlador HTTP Clientes
│   │       ├── EquipoServlet.java       ← Controlador HTTP Equipos
│   │       ├── ReservaServlet.java      ← Controlador HTTP Reservas
│   │       └── ServicioServlet.java     ← Controlador HTTP Servicios
│   └── webapp/
│       ├── WEB-INF/web.xml
│       ├── css/estilos.css
│       ├── index.jsp                    ← Dashboard principal
│       └── vistas/
│           ├── clientes/
│           │   ├── lista.jsp
│           │   └── formulario.jsp
│           ├── equipos/
│           │   ├── lista.jsp
│           │   └── formulario.jsp
│           ├── reservas/
│           │   ├── lista.jsp
│           │   └── formulario.jsp
│           ├── servicios/
│           │   ├── lista.jsp
│           │   └── formulario.jsp
│           └── error.jsp
├── sql/
│   └── cibercafe_db.sql                 ← Script base de datos
└── pom.xml                              ← Dependencias Maven
```

---

## 🗄️ Base de Datos

**Nombre:** `proyecto_cibercafe`

### Tablas:
| Tabla       | Descripción                          |
|------------|--------------------------------------|
| `clientes`  | Usuarios registrados en el cibercafé |
| `equipos`   | Computadores disponibles             |
| `reservas`  | Sesiones de uso (con JOIN)           |
| `servicios` | Impresión, escaneo, etc.             |

---

## 🚀 Instrucciones de Instalación

### Requisitos
- JDK 11+
- Apache Tomcat 9 o 10
- MySQL 8+ con XAMPP o instalación directa
- NetBeans 19/21 (o IntelliJ IDEA)
- Maven 3.6+

### Pasos

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/[TU_USUARIO]/CibercafeApp.git
   cd CibercafeApp
   ```

2. **Crear la base de datos:**
   - Abrir XAMPP → iniciar MySQL
   - Ejecutar en phpMyAdmin o línea de comandos:
   ```bash
   mysql -u root -p < sql/cibercafe_db.sql
   ```

3. **Configurar conexión** *(si cambió usuario/contraseña)*:
   - Editar `src/main/java/com/cibercafe/config/ConexionDB.java`
   - Ajustar `USUARIO` y `PASSWORD`

4. **Construir el proyecto:**
   ```bash
   mvn clean package
   ```

5. **Desplegar en Tomcat:**
   - Copiar `target/CibercafeApp.war` a `[TOMCAT_HOME]/webapps/`
   - O abrir el proyecto en NetBeans y ejecutar directamente con Tomcat

6. **Acceder al sistema:**
   ```
   http://localhost:8080/CibercafeApp/
   ```

---

## ✅ Módulos CRUD Implementados

| Módulo     | Crear | Leer | Actualizar | Eliminar | GET | POST |
|-----------|:-----:|:----:|:----------:|:--------:|:---:|:----:|
| Clientes  |  ✅   |  ✅  |     ✅     |    ✅    | ✅  |  ✅  |
| Equipos   |  ✅   |  ✅  |     ✅     |    ✅    | ✅  |  ✅  |
| Reservas  |  ✅   |  ✅  |     ✅     |    ✅    | ✅  |  ✅  |
| Servicios |  ✅   |  ✅  |     ✅     |    ✅    | ✅  |  ✅  |

---

## 🔧 Tecnologías utilizadas

- **Java EE** — Lógica de negocio y controladores
- **HttpServlet** — Manejo de peticiones GET y POST
- **JSP + JSTL** — Vistas dinámicas (`<c:forEach>`, `<c:if>`, `<c:choose>`)
- **Expression Language (EL)** — `${variable}` en vistas JSP
- **MySQL + JDBC** — Persistencia de datos con PreparedStatement
- **HTML5 + CSS3** — Interfaz de usuario responsiva
- **Maven** — Gestión de dependencias
- **Git** — Control de versiones

---

## 📝 Notas de la Evidencia

- El código sigue el patrón **MVC** (Modelo–Vista–Controlador)
- Los Servlets extienden `HttpServlet` y sobrescriben `doGet()` y `doPost()`
- Se usan **PreparedStatement** para prevenir inyección SQL
- Las vistas JSP usan **JSTL** (`c:forEach`, `c:if`, `c:choose`) y **EL**
- El módulo de Reservas incluye lógica de negocio: al iniciar una reserva el equipo pasa a "ocupado"; al finalizarla se calcula automáticamente el total según horas × tarifa
