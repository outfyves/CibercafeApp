package com.cibercafe.model;

/**
 * Clase Modelo: Reserva
 * Representa una reserva/sesión de uso en el cibercafé.
 * GA7-220501096-AA2-EV02
 */
public class Reserva {

    private int    idReserva;
    private int    idCliente;
    private int    idEquipo;
    private String fechaInicio;
    private String fechaFin;
    private double horas;
    private double totalPago;
    private String estado;
    private String observaciones;

    // Para mostrar en vistas (joins)
    private String nombreCliente;
    private String codigoEquipo;

    public Reserva() {}

    public Reserva(int idReserva, int idCliente, int idEquipo,
                   String fechaInicio, String fechaFin,
                   double horas, double totalPago,
                   String estado, String observaciones) {
        this.idReserva    = idReserva;
        this.idCliente    = idCliente;
        this.idEquipo     = idEquipo;
        this.fechaInicio  = fechaInicio;
        this.fechaFin     = fechaFin;
        this.horas        = horas;
        this.totalPago    = totalPago;
        this.estado       = estado;
        this.observaciones = observaciones;
    }

    public int    getIdReserva()     { return idReserva; }
    public void   setIdReserva(int i){ this.idReserva = i; }

    public int    getIdCliente()     { return idCliente; }
    public void   setIdCliente(int i){ this.idCliente = i; }

    public int    getIdEquipo()      { return idEquipo; }
    public void   setIdEquipo(int i) { this.idEquipo = i; }

    public String getFechaInicio()   { return fechaInicio; }
    public void   setFechaInicio(String f) { this.fechaInicio = f; }

    public String getFechaFin()      { return fechaFin; }
    public void   setFechaFin(String f) { this.fechaFin = f; }

    public double getHoras()         { return horas; }
    public void   setHoras(double h) { this.horas = h; }

    public double getTotalPago()     { return totalPago; }
    public void   setTotalPago(double t) { this.totalPago = t; }

    public String getEstado()        { return estado; }
    public void   setEstado(String e){ this.estado = e; }

    public String getObservaciones() { return observaciones; }
    public void   setObservaciones(String o) { this.observaciones = o; }

    public String getNombreCliente() { return nombreCliente; }
    public void   setNombreCliente(String n) { this.nombreCliente = n; }

    public String getCodigoEquipo()  { return codigoEquipo; }
    public void   setCodigoEquipo(String c) { this.codigoEquipo = c; }
}
