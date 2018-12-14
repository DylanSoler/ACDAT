package practicasax;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author NitroPC
 */
public class GenerarConexion {
    
    public Connection obtenerConexion(String nombreBaseDeDatos) throws SQLException{
    
        String url = "jdbc:sqlserver://localhost;databaseName="+nombreBaseDeDatos+";user=Dylan;password=entra;";
        Connection conexion = null;
        
        if(conexion ==null)
        {
            conexion = DriverManager.getConnection(url);   
        }
        
        return conexion;
    }
    
    public void cerrar(ResultSet rs) {
          
        try{   
            rs.close();   
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
    public void cerrar(Statement st) {
        try{
            st.close(); 
        }catch (SQLException e){ 
            e.printStackTrace();
        }
    }
    public void cerrar(Connection conexion) {
        try{
            conexion.close();
        }catch (SQLException e){  
            e.printStackTrace();
        }
    }
    
    
}