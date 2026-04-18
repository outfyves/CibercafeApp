-- ============================================
-- BASE DE DATOS: proyecto_cibercafe
-- Sistema de Gestión de Cibercafé
-- Autor: Aprendiz SENA - GA7-220501096-AA2-EV02
-- ============================================

CREATE DATABASE IF NOT EXISTS proyecto_cibercafe
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE proyecto_cibercafe;

-- ============================================
-- TABLA: clientes
-- ============================================
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente      INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    apellido        VARCHAR(100) NOT NULL,
    documento       VARCHAR(20)  NOT NULL UNIQUE,
    email           VARCHAR(150) NOT NULL,
    telefono        VARCHAR(20),
    fecha_registro  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado          ENUM('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB;

-- ============================================
-- TABLA: equipos
-- ============================================
CREATE TABLE IF NOT EXISTS equipos (
    id_equipo       INT AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    descripcion     VARCHAR(200),
    estado          ENUM('disponible','ocupado','mantenimiento') DEFAULT 'disponible',
    tarifa_hora     DECIMAL(10,2) NOT NULL DEFAULT 2500.00
) ENGINE=InnoDB;

-- ============================================
-- TABLA: servicios
-- ============================================
CREATE TABLE IF NOT EXISTS servicios (
    id_servicio     INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     VARCHAR(300),
    precio          DECIMAL(10,2) NOT NULL,
    estado          ENUM('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB;

-- ============================================
-- TABLA: reservas
-- ============================================
CREATE TABLE IF NOT EXISTS reservas (
    id_reserva      INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente      INT NOT NULL,
    id_equipo       INT NOT NULL,
    fecha_inicio    DATETIME NOT NULL,
    fecha_fin       DATETIME,
    horas           DECIMAL(5,2),
    total_pago      DECIMAL(10,2),
    estado          ENUM('activa','finalizada','cancelada') DEFAULT 'activa',
    observaciones   VARCHAR(500),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_equipo)  REFERENCES equipos(id_equipo)
) ENGINE=InnoDB;

-- ============================================
-- DATOS DE PRUEBA
-- ============================================
INSERT INTO clientes (nombre, apellido, documento, email, telefono) VALUES
('Carlos', 'García', '1001234567', 'carlos@email.com', '3001234567'),
('María', 'López',  '1009876543', 'maria@email.com',  '3109876543'),
('Juan',  'Pérez',  '1005555555', 'juan@email.com',   '3205555555');

INSERT INTO equipos (codigo, descripcion, estado, tarifa_hora) VALUES
('PC-01', 'Computador de escritorio zona A', 'disponible', 2500.00),
('PC-02', 'Computador de escritorio zona A', 'disponible', 2500.00),
('PC-03', 'Computador de escritorio zona B', 'disponible', 3000.00),
('PC-04', 'Computador gaming zona VIP',      'disponible', 5000.00);

INSERT INTO servicios (nombre, descripcion, precio) VALUES
('Impresión B/N',   'Impresión en blanco y negro por hoja', 200.00),
('Impresión Color', 'Impresión a color por hoja',           500.00),
('Escaneo',         'Escaneo de documentos por hoja',       300.00),
('Recarga celular', 'Recarga de saldo a celular',           1000.00);
