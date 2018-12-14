package practicasax;


/**
 *
 * @author Leo
 */
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.xml.sax.helpers.*;
import org.xml.sax.*;
import practicasax.Album;
import practicasax.GenerarConexion;

public class GestionContenido extends DefaultHandler {
    
    private Album alb = new Album();
    private String elementName;
    private String cadena;
    private Connection conexion = null;
    private String nombreBD = "Ejemplos";


    public GestionContenido() {
        super();
    }
    @Override
    public void startDocument(){
        
        elementName = "";
        
        GenerarConexion conex = new GenerarConexion();
        
        try{
            this.conexion = conex.obtenerConexion(nombreBD);
        }catch(SQLException e) {
            e.printStackTrace();
        }
    }
    @Override
    public void endDocument(){
        
        try {
            this.conexion.close();
        } catch (SQLException ex) {
            Logger.getLogger(GestionContenido.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    @Override
    public void startElement(String uri, String nombre, String nombreC, Attributes att){
        
        switch(nombre)
        {
            case "autor": elementName = "autor";
                break;
            case "titulo": elementName = "titulo";
                break;
            case "formato": elementName = "formato";
                break;
            case "localizacion": elementName = "localizacion";
                break;
        }
    }
    @Override
    public void endElement(String uri, String nombre, String nombreC){
        
        switch(nombre)
        {
            case "autor": elementName = "";
                break;
            case "titulo": elementName = "";
                break;
            case "formato": elementName = "";
                break;
            case "localizacion": elementName = "";
                                 System.out.println(alb.toString());
                                 insertarDisco(alb);
                break;
        }
    }
    @Override
    public void characters (char[] ch, int inicio, int longitud)
            throws SAXException{
        
        
        switch(elementName)
        {
            case "autor":             
                cadena = new String(ch, inicio, longitud);
                cadena = cadena.replaceAll("[\t\n]","");
                alb.setAutor(cadena);
                break;
            case "titulo":             
                cadena = new String(ch, inicio, longitud);
                cadena = cadena.replaceAll("[\t\n]","");
                alb.setTitulo(cadena);
                break;
            case "formato":             
                cadena = new String(ch, inicio, longitud);
                cadena = cadena.replaceAll("[\t\n]","");
                alb.setFormato(cadena);
                break;
            case "localizacion":             
                cadena = new String(ch, inicio, longitud);
                cadena = cadena.replaceAll("[\t\n]","");
                alb.setLocalizacion(cadena);
                break;
        }
  
    }
    
    public void insertarDisco(Album alb)
    {
       Statement sentencia;
       String act = "INSERT INTO Discos (autor,titulo,formato,localizacion) VALUES ('"+alb.getAutor()+"','"+alb.getTitulo()+"','"+alb.getFormato()+"','"+alb.getLocalizacion()+"')";
       try {
            sentencia = conexion.createStatement();
            sentencia.executeUpdate(act);                              
       } catch (SQLException ex) {
            Logger.getLogger(GestionContenido.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
// FIN GestionContenido
