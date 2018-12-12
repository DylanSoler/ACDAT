/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package examenacdat1dylan;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author dasoler
 */
public class GestionPedidos {
    
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
    
    
    //Metodo que devuelve un ResultSet de la tabla Pedidos actualizable
    public ResultSet obtenerPedidosPendientes(){
    
        ResultSet rs = null;
        Statement sentencia;
        
        try {
            sentencia = conexion.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
            String consulta = "SELECT IDPedido,FechaServido FROM dbo.Pedidos WHERE FechaServido IS NULL";
            rs = sentencia.executeQuery(consulta);   
        } catch (SQLException e) {
            e.printStackTrace();
        }        
        return rs;
    }
    
    
    //Metodo que devuelve un ResultSet con info sobre los pedidos pendientes y los clientes de estos con su empresa
    public ResultSet obtenerListadoPedidosPendientesCompleto(){
    
        ResultSet rs = null;
        Statement sentencia;
        
        try {
            sentencia = conexion.createStatement();
            String consulta = "SELECT IDPedido,FechaPedido,C.Nombre,C.Apellidos,C.NombreEmpresa FROM dbo.Pedidos  AS P INNER JOIN Clientes AS C ON P.IDCliente=C.ID WHERE FechaServido IS NULL";
            rs = sentencia.executeQuery(consulta);   
        } catch (SQLException e) {
            e.printStackTrace();
        }        
        return rs;
    }
    
    public boolean comprobarStockPedido(int idPedido)
    {
        boolean stock=false;
        
        String sql = "EXECUTE comprobarStock ? , ?";
        CallableStatement callProcedure;
        int ret;
        
        try{
        callProcedure = conexion.prepareCall (sql);
        callProcedure.setInt (1, idPedido);
        callProcedure.registerOutParameter(2,java.sql.Types.INTEGER);
        callProcedure.executeUpdate();
        ret = callProcedure.getInt(2);
        if(ret==1) { stock = true; }
        }
        catch(SQLException ex)
        {
            ex.printStackTrace();
        }
        
        
        return stock;
    }
    
    //Metodo que devuelve un arraylist con los ids de los productos de un pedido
    public ArrayList obtenerProductosPedido(int idPedido){
    
        ResultSet rs = null;
        Statement sentencia;
        ArrayList<Integer> productos = new ArrayList<>();
        
        try {
            sentencia = conexion.createStatement();
            String consulta = "SELECT PR.IDProducto FROM dbo.Productos AS PR INNER JOIN LineasPedidos AS LP ON PR.IDProducto=LP.IDProducto AND LP.IDPedido="+idPedido;
            rs = sentencia.executeQuery(consulta);
            while(rs.next())
            {
                productos.add(rs.getInt("IDProducto"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }        
        return productos;
    }
    
    //Metodo que actualiza el stock de los productos de un pedido
    //Devuelve ok = true, si todo ha ido bien. En caso contrario devolverá false
    public boolean actualizaStockProductosPedido(int idPedido){
        
        boolean ok=true;
        //obtener productos del pedido
        ArrayList<Integer> productos = obtenerProductosPedido(idPedido);
        
        String sql = "EXECUTE actualizarStock ? , ? , ?";
        CallableStatement callProcedure;
        int ret;
        
        for(Integer n : productos)
        {
            try{
            callProcedure = conexion.prepareCall (sql);
            callProcedure.setInt (1, idPedido);
            callProcedure.setInt (2, n);
            callProcedure.registerOutParameter(3,java.sql.Types.INTEGER);
            callProcedure.executeUpdate();
            ret = callProcedure.getInt(3);
            if(ret==0) { ok = false; }
            }
            catch(SQLException ex)
            {
                ex.printStackTrace();
            }
        } 
        return ok;
    }
    
    //Metodo que devuelve un arraylist con los nombres de los productos sin stock suficiente de un pedido
    public ArrayList productosSinStock(int idPedido){
    
        ResultSet rs = null;
        Statement sentencia;
        ArrayList<String> productos = new ArrayList<>();
        
        try {
            sentencia = conexion.createStatement();
            String consulta = "SELECT Nombre FROM Productos AS PR INNER JOIN LineasPedidos AS LP ON PR.IDProducto=LP.IDProducto INNER JOIN Pedidos AS P ON LP.IDPedido=P.IDPedido WHERE LP.Cantidad>PR.Stock AND P.IDPedido="+idPedido;
            rs = sentencia.executeQuery(consulta);
            while(rs.next())
            {
                productos.add(rs.getString("Nombre"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }        
        return productos;
    }
    
}
