package com.cibercafe.model;

/**
 * Clase Modelo: Cliente
 * Representa a un cliente del cibercafé.
 * GA7-220501096-AA2-EV02
 */
public class Cliente {

    private int    idCliente;
    private String nombre;
    private String apellido;
    private String documento;
    private String email;
    private String telefono;
    private String fechaRegistro;
    private String estado;

    // Constructor vacío
    public Cliente() {}

    // Constructor completo
    public Cliente(int idCliente, String nombre, String apellido,
                   String documento, String email, String telefono,
                   String fechaRegistro, String estado) {
        this.idCliente     = idCliente;
        this.nombre        = nombre;
        this.apellido      = apellido;
        this.documento     = documento;
        this.email         = email;
        this.telefono      = telefono;
        this.fechaRegistro = fechaRegistro;
        this.estado        = estado;
    }

    // Getters y Setters
    public int    getIdCliente()     { return idCliente; }
    public void   setIdCliente(int idCliente) { this.idCliente = idCliente; }

    public String getNombre()        { return nombre; }
    public void   setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido()      { return apellido; }
    public void   setApellido(String apellido) { this.apellido = apellido; }

    public String getDocumento()     { return documento; }
    public void   setDocumento(String documento) { this.documento = documento; }

    public String getEmail()         { return email; }
    public void   setEmail(String email) { this.email = email; }

    public String getTelefono()      { return telefono; }
    public void   setTelefono(String telefono) { this.telefono = telefono; }

    public String getFechaRegistro() { return fechaRegistro; }
    public void   setFechaRegistro(String f) { this.fechaRegistro = f; }

    public String getEstado()        { return estado; }
    public void   setEstado(String estado) { this.estado = estado; }

    public String getNombreCompleto() { return nombre + " " + apellido; }

    @Override
    public String toString() {
        return "Cliente{id=" + idCliente + ", nombre=" + nombre
             + " " + apellido + ", doc=" + documento + "}";
    }
}
