/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesEntidades;

import java.sql.Date;

/**
 *
 * @author NitroPC
 */
public class Envio {
    
    //Propiedades
    private long ID;
    private int contenedores;
    private Date fechaCreacion;
    private Date fechaAsignacion;
    private int almacenPreferido;
    
    //Constructores
            //Por defecto
    public Envio() {
        java.util.Date utilDate = new java.util.Date(); 
        this.fechaCreacion = new java.sql.Date(utilDate.getTime());;
    }
            //Con parametros
    public Envio(int contenedores, int almacenPreferido) {
        this.contenedores = contenedores;
        this.almacenPreferido = almacenPreferido;
        
        java.util.Date utilDate = new java.util.Date(); 
        this.fechaCreacion = new java.sql.Date(utilDate.getTime());;
    }

    //Getters y Setters
    
    public long getID() {
        return ID;
    }

    public int getContenedores() {
        return contenedores;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public Date getFechaAsignacion() {
        return fechaAsignacion;
    }

    public int getAlmacenPreferido() {
        return almacenPreferido;
    }

    public void setID(long ID) {
        this.ID = ID;
    }

    public void setContenedores(int contenedores) {
        this.contenedores = contenedores;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public void setFechaAsignacion(Date fechaAsignacion) {
        this.fechaAsignacion = fechaAsignacion;
    }

    public void setAlmacenPreferido(int almacenPreferido) {
        this.almacenPreferido = almacenPreferido;
    }
    
    //toString
    @Override
    public String toString() {
        return "Envio{" + "ID=" + ID + ", contenedores=" + contenedores + ", fechaCreacion=" + fechaCreacion + ", fechaAsignacion=" + fechaAsignacion + ", almacenPreferido=" + almacenPreferido + '}';
    }
    
    
    
}
