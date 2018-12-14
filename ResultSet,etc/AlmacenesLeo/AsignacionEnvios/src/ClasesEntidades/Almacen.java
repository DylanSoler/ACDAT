/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ClasesEntidades;

/**
 *
 * @author NitroPC
 */
public class Almacen {
    
    //Propiedades
    private int ID;
    private String denominacion;
    private String direccion;
    private long capacidad;
    
    //Constructores
    
    public Almacen() {
    }
    
    public Almacen(int ID, String denominacion, String direccion, long capacidad) {
        this.ID = ID;
        this.denominacion = denominacion;
        this.direccion = direccion;
        this.capacidad = capacidad;
    }
    
    //Getters y Setters
    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getDenominacion() {
        return denominacion;
    }

    public void setDenominacion(String denominacion) {
        this.denominacion = denominacion;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public long getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(long capacidad) {
        this.capacidad = capacidad;
    }
    
    //toString
    @Override
    public String toString() {
        return "ID=" + ID + ", denominacion=" + denominacion + ", direccion=" + direccion + ", capacidad=" + capacidad;
    }
    
    public String toString2() {
        return ID+denominacion+direccion+capacidad;
    }
}
