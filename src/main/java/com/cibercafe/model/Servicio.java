package com.cibercafe.model;

/**
 * Clase Modelo: Servicio
 * Representa un servicio adicional ofrecido en el cibercafé.
 * GA7-220501096-AA2-EV02
 */
public class Servicio {

    private int    idServicio;
    private String nombre;
    private String descripcion;
    private double precio;
    private String estado;

    public Servicio() {}

    public Servicio(int idServicio, String nombre, String descripcion,
                    double precio, String estado) {
        this.idServicio  = idServicio;
        this.nombre      = nombre;
        this.descripcion = descripcion;
        this.precio      = precio;
        this.estado      = estado;
    }

    public int    getIdServicio()  { return idServicio; }
    public void   setIdServicio(int idServicio) { this.idServicio = idServicio; }

    public String getNombre()      { return nombre; }
    public void   setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void   setDescripcion(String d) { this.descripcion = d; }

    public double getPrecio()      { return precio; }
    public void   setPrecio(double precio) { this.precio = precio; }

    public String getEstado()      { return estado; }
    public void   setEstado(String estado) { this.estado = estado; }

    @Override
    public String toString() {
        return "Servicio{id=" + idServicio + ", nombre=" + nombre + ", precio=" + precio + "}";
    }
}
