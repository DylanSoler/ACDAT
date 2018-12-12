/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package asignacionenvios;

import ClasesEntidades.Almacen;
import ClasesEntidades.Envio;
import GestionAsignacionEnvios.GestionAsignacionEnvios;
import GestionAsignacionEnvios.GestionMenues;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**Asignacion de envios AlmacenesLeo
 * 
 * @author dasoler
 * 
 * El programa presenta un menu con tres opciones ademas de la de salir.
 * La primera se tratá de insertar un nuevo envio en la base de datos
 * AlmacenesLeo, la segunda asignar un envio a un almacen, y la tercera
 * mostrar todos los envios.
 * 
 * Pseudocodigo generalizado
 *  Inicio
 *      repetir
 *      mostrarMenuValidarOpcion
 *      Si(opcion!=0)
 *        abrirConexion
 *        Segun(opcion)
 *              caso 1: insertarEnvio
 *              caso 2: asignarEnvio
 *              caso 3: mostrarEnviosAsignados
 *        Fin_Segun
 *      Fin_Si
 *      mientras(opcion!=0)
 *      cerrarConexion
 *  Fin
 * 
 */
public class AsignacionEnvios {

    public static void main(String[] args) {
        
        //Declaracion de variables
        Scanner tec = new Scanner(System.in);
        int opcionPrincipal = 0, numContenedores, idAlmacen = 0;
        long idEnvio;
        char confirmacion=' '; 
        char repetir=' ', reasignar=' ';
        Boolean asignado = false;
        Boolean idValido;
        GestionAsignacionEnvios gestEnvios = new GestionAsignacionEnvios();
        ArrayList<Envio> enviosSinAsignar = new ArrayList<Envio>();
        
        
        do{
            
            //mostrarMenuValidarOpcion
            do{
                GestionMenues.menuPrincipal();
                opcionPrincipal = tec.nextInt();
            }while(opcionPrincipal<0 || opcionPrincipal>3);
            
            if(opcionPrincipal!=0){
                
                //abrirConexion
                gestEnvios.abrirConexion("AlmacenesLeo");
                
                switch(opcionPrincipal) {
                    
                    case 1: //insertarEnvio
                            do{
                                  System.out.println("Introduzca el numero de contenedores del envio: ");
                                  numContenedores = tec.nextInt();
                            }while(numContenedores<1);
                            
                            do{
                                  ArrayList<Almacen> almacenes = new ArrayList<Almacen>();
                                  almacenes = gestEnvios.obtenerAlmacenes();
                                  System.out.println("----*------------------------------*--------------------------------------------------*------------------------*");
                                  System.out.println("ID  |"+"     Denominacion             |"+"     Direccion                                    |"+"  Capacidad             |");
                                  for (Almacen object: almacenes) {
                                      System.out.println("----|------------------------------|--------------------------------------------------|------------------------|");
                                      System.out.printf("%-4d"+"|"+"%-30s"+"|"+"%-50s"+"|"+"%-24d|\n", object.getID(), object.getDenominacion(), object.getDireccion(), object.getCapacidad());
                                    }
                                  System.out.println("----*------------------------------*--------------------------------------------------*------------------------*");
                                  System.out.println("Introduzca el id del almacen preferido para la asignacion del envio: ");
                                  idAlmacen = tec.nextInt();
                                  Envio envio = new Envio(numContenedores,idAlmacen);
                                  Boolean b = gestEnvios.insertarEnvio(envio);
                                  if(b==true){System.out.println("\nSe ha insertado correctamente\n");}
                                  
                            }while(idAlmacen<1);
                            
                        
                        break;
                        
                        
                    case 2: //asignarEnvio
                        do{
                                //mostrar envios sin asignar
                            enviosSinAsignar = gestEnvios.obtenerEnviosSinAsignar();
                            for(Envio object: enviosSinAsignar){
                                System.out.println(object);
                            }
                                //leer ID del envio elegido y validar
                            do {
                                System.out.println("Introduzca el ID del envio elegido");
                                idEnvio = tec.nextLong();
                                idValido = gestEnvios.validarIDEnvio(enviosSinAsignar, idEnvio);
                            } while(idValido==false); 
                            
                            //obtenemos idAlmacen
                            for(Envio object: enviosSinAsignar){
                                if(object.getID()==idEnvio) 
                                    idAlmacen = object.getAlmacenPreferido();
                            }
                            
                                 //asignar (si cabe) al almacen favorito
                            try {
                                gestEnvios.asignarEnvio(idEnvio,idAlmacen);
                                gestEnvios.actualizarFechaAsignacion(idEnvio);
                                asignado = true;
                                System.out.println("\nEl envio se ha asignado correctamente\n");
                            } catch (SQLException ex) {
                                asignado = false;
                                System.out.println("\n"+ex.getMessage().toString()+"\n");
                            }
                                //si no cupo en el almacen preferido
                            if(asignado==false)
                            {
                                //buscar almacen mas cercano y preguntar si asignar....etc
                                int almacenMasCercano = gestEnvios.almacenesMasCercano(idAlmacen);
                                do{
                                    System.out.println("\nDesea asignarlo al almacen mas cercano? S/N \n");
                                    reasignar = Character.toUpperCase(tec.next().charAt(0));
                                }while(reasignar!='S' && reasignar!='N');
                                
                                //si desea asignarlo
                                if(reasignar=='S'){ 
                                            
                                    try {
                                        gestEnvios.asignarEnvio(idEnvio,almacenMasCercano);
                                        gestEnvios.actualizarFechaAsignacion(idEnvio);
                                        asignado = true;
                                        System.out.println("\nEl envio se ha asignado correctamente\n");
                                    } catch (SQLException ex) {
                                        asignado = false;
                                        System.out.println("\n"+ex.getMessage().toString()+"\n");
                                    }
                                }
                                    
                                
                            }
                                    
                            
                                //preguntar si desea asignar otro envio
                            do{
                                System.out.println("Quiere asignar otro envio?");
                                repetir = Character.toUpperCase(tec.next().charAt(0));
                            }while(repetir!='S' && repetir!='N');
                            
                        }while(repetir!='N');
                        break;
                        
                        
                    case 3: //mostrarEnvios
                            ResultSet rs = gestEnvios.mostrarEnviosAsignados();
                            System.out.println("\n--------Envios------------------------------------");
                            System.out.printf("%-6s","ID");
                            System.out.printf("%-7s","Cont.");
                            System.out.printf("%-18s","FechaCreacion");
                            System.out.printf("%-19s","FechaAsignacion");
                            System.out.printf("%-34s","Denominacion");
                            System.out.printf("%-35s"+"\n","Direccion");
                            
                            try {
                                while(rs.next())
                                {
                                    System.out.printf("%-6d"+"|"+"%-6d"+"|"+"%-16s"+"|"+"%-16s"+"|"+"%-30s"+"|"+"%-30s"+"\n", rs.getLong("ID"), rs.getInt("NumeroContenedores"), rs.getDate("FechaCreacion"), rs.getDate("FechaAsignacion"),rs.getString("Denominacion"),rs.getString("Direccion"));
                                }
                            } 
                            catch (SQLException ex) {
                                ex.printStackTrace();
                            }
                            
                            System.out.println("\n");
                
                        break;
                }
            }
            
        }while(opcionPrincipal!=0);
        
        //cerrarConexion
        gestEnvios.cerrarConexion();
    }
    
}
