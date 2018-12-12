/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GestionAsignacionEnvios;

import ClasesEntidades.Almacen;
import ClasesEntidades.Envio;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


/**
 *
 * @author dasoler
 */
public class GestionAsignacionEnvios {
    
    private Connection conexion = null;
    
//Metodo que obtiene una conexion para la propiedad privada conexion
    public void abrirConexion(String nombreBD){
    
        GenerarConexion conex = new GenerarConexion();
        try
        {
            this.conexion = conex.obtenerConexion(nombreBD);
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
    }
    
 //Metodo que cierra la conexion de la propiedad privada conexion
    public void cerrarConexion(){
        
        GenerarConexion conex = new GenerarConexion();
        
        if(conexion!=null)
        {
            conex.cerrar(conexion);
        }
    }
    
    
//Metodo que realiza una consulta a la base de datos y devuelve un array con todos los almacenes
    public ArrayList<Almacen> obtenerAlmacenes(){
        
        GenerarConexion conex = new GenerarConexion();
        Statement sentencia;
        ResultSet rs = null;
        String consulta;
        ArrayList<Almacen> almacenes = new ArrayList<Almacen>();
        Almacen alm;
        
        try {
            sentencia = conexion.createStatement();
            consulta = "SELECT ID, Denominacion, Direccion, Capacidad FROM Almacenes";
            rs = sentencia.executeQuery(consulta);
           
            while(rs.next()){
                alm = new Almacen();
                alm.setID(rs.getInt("ID"));
                alm.setDenominacion(rs.getString("Denominacion"));
                alm.setDireccion(rs.getString("Direccion"));
                alm.setCapacidad(rs.getLong("Capacidad"));
                almacenes.add(alm);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            conex.cerrar(rs);
        }
        
        return almacenes;
    }
    
    //Metodo que realiza una consulta a la base de datos y devuelve un ResultSet con todos los envios asignados
    public ResultSet mostrarEnviosAsignados(){
    
        GenerarConexion conex = new GenerarConexion();
        Statement sentencia;
        ResultSet rs = null;
        String consulta;
        Envio env = null;
        
        try {
            sentencia = conexion.createStatement();
            consulta = "SELECT ENV.ID, NumeroContenedores, FechaCreacion, FechaAsignacion, ALM.Denominacion, ALM.Direccion FROM Envios AS ENV inner JOIN Asignaciones AS ASIG ON ENV.ID=ASIG.IDEnvio inner JOIN Almacenes AS ALM ON ASIG.IDAlmacen=ALM.ID";
            rs = sentencia.executeQuery(consulta);   
        } catch (SQLException e) {
            e.printStackTrace();
        }        
        return rs;
    }

    
    
    //Metodo que realiza una consulta a la base de datos y devuelve un array con todos los envios sin asignar
    public ArrayList<Envio> obtenerEnviosSinAsignar(){
    
        GenerarConexion conex = new GenerarConexion();
        Statement sentencia;
        ResultSet rs = null;
        String consulta;
        ArrayList<Envio> envios = new ArrayList<Envio>();
        Envio env = new Envio();
        
        try {
            sentencia = conexion.createStatement();
            consulta = "SELECT ID, NumeroContenedores, FechaCreacion, FechaAsignacion, AlmacenPreferido FROM Envios WHERE FechaAsignacion IS NULL";
            rs = sentencia.executeQuery(consulta);
            while(rs.next()){
                env = new Envio();
                env.setID(rs.getLong("ID"));
                env.setContenedores(rs.getInt("NumeroContenedores"));
                env.setFechaCreacion(rs.getDate("FechaCreacion"));
                env.setFechaAsignacion(rs.getDate("FechaAsignacion"));
                env.setAlmacenPreferido(rs.getInt("AlmacenPreferido"));
                envios.add(env);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            conex.cerrar(rs);
        }
        
        return envios;
    }
    
    //Metodo que valida sin un id es valido dentro de una lista dada de envios
    public boolean validarIDEnvio(ArrayList<Envio> lista, long id){
    
        boolean valido=false;
        long idsLista;
        
        for(int i=0;i<lista.size() && valido==false; i++){
            idsLista = lista.get(i).getID();
            if(idsLista == id){
                valido=true;
            }
        }
        
        return valido;
    }
    
    //Metodo que actualiza la fecha de asignacion de un envio       ---HACER PREPARADA Y BOOLEAAAAAAAAAAAN
    public void actualizarFechaAsignacion(long id){
    
        GenerarConexion conex = new GenerarConexion();
        Statement sentencia;
        ResultSet rs = null;
        String consulta;
        java.util.Date utilDate = new java.util.Date(); //fecha actual
        Date fechaActual = new Date(utilDate.getTime());
        
        try {
            consulta = "SELECT ID, NumeroContenedores, FechaCreacion, FechaAsignacion, AlmacenPreferido FROM Envios WHERE ID="+id;
            sentencia = conexion.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            rs = sentencia.executeQuery(consulta);
            rs.absolute(1);
            rs.updateDate("FechaAsignacion", fechaActual);
            rs.updateRow();
            }
        catch (SQLException e) {
            e.printStackTrace();
        }
        finally{
            conex.cerrar(rs);
        }
    }
    
    //Metodo que inserta en la tabla asignacionesEnvios la asiganacion de un envio a un almacen
    public void asignarEnvio(long idEnv, int idAlmacen) throws SQLException{
    
        GenerarConexion conex = new GenerarConexion();
        Statement sentencia;
        ResultSet rs = null;
        String consulta;
        
        consulta = "SELECT IDEnvio, IDAlmacen FROM Asignaciones";
        sentencia = conexion.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        rs = sentencia.executeQuery(consulta);
        rs.moveToInsertRow();
        rs.updateLong("IDEnvio", idEnv);
        rs.updateInt("IDAlmacen", idAlmacen);
        rs.insertRow();
        rs.moveToCurrentRow();
        conex.cerrar(rs);
    }
    
    
    public int almacenesMasCercano(int idAlmacen){
    
        String sql = "EXECUTE almacenMasCercano ? , ?";
        CallableStatement callProcedure;
        int almacen = 0;
        
        try{
        callProcedure = conexion.prepareCall (sql);
        callProcedure.setInt (1, idAlmacen);
        callProcedure.registerOutParameter(2,java.sql.Types.INTEGER);
        callProcedure.executeUpdate();
        almacen = callProcedure.getInt(2);        
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        
        return almacen;
        
    }
    
    public boolean insertarEnvio(Envio env){
    
        GenerarConexion conex = new GenerarConexion();
        java.util.Date utilDate = new java.util.Date(); //fecha actual
        Date fechaActual = new Date(utilDate.getTime()); 
        env.setFechaCreacion(fechaActual);
        ResultSet rs;
        Statement sent;
        boolean res = false;
        long idEnv;

        try
        {
            String funcion = "SELECT dbo.nuevoIDEnvio() as ID";
            sent = conexion.createStatement();
            rs = sent.executeQuery(funcion);
            rs.next();
            idEnv = rs.getLong("ID");
            String sql = "INSERT INTO Envios (ID, NumeroContenedores,FechaCreacion, FechaAsignacion, AlmacenPreferido) VALUES (?,?,?,?,?)";
            PreparedStatement sentencia = conexion.prepareStatement(sql);
            sentencia.setLong(1,idEnv);
            sentencia.setInt(2,env.getContenedores());
            sentencia.setDate(3, fechaActual);
            sentencia.setDate(4, null);
            sentencia.setInt(5, env.getAlmacenPreferido());
            sentencia.executeUpdate();
            res = true;
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        
        return res;
    
    }
}
