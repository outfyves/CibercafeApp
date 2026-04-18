package com.cibercafe.model;

/**
 * Clase Modelo: Equipo
 * Representa un computador/equipo del cibercafé.
 * GA7-220501096-AA2-EV02
 */
public class Equipo {

    private int    idEquipo;
    private String codigo;
    private String descripcion;
    private String estado;
    private double tarifaHora;

    public Equipo() {}

    public Equipo(int idEquipo, String codigo, String descripcion,
                  String estado, double tarifaHora) {
        this.idEquipo    = idEquipo;
        this.codigo      = codigo;
        this.descripcion = descripcion;
        this.estado      = estado;
        this.tarifaHora  = tarifaHora;
    }

    public int    getIdEquipo()    { return idEquipo; }
    public void   setIdEquipo(int idEquipo) { this.idEquipo = idEquipo; }

    public String getCodigo()      { return codigo; }
    public void   setCodigo(String codigo) { this.codigo = codigo; }

    public String getDescripcion() { return descripcion; }
    public void   setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getEstado()      { return estado; }
    public void   setEstado(String estado) { this.estado = estado; }

    public double getTarifaHora()  { return tarifaHora; }
    public void   setTarifaHora(double tarifaHora) { this.tarifaHora = tarifaHora; }

    @Override
    public String toString() {
        return "Equipo{id=" + idEquipo + ", codigo=" + codigo + ", estado=" + estado + "}";
    }
}
