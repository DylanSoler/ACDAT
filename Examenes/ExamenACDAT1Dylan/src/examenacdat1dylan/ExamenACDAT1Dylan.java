/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package examenacdat1dylan;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 *
 * @author dasoler
 */
public class ExamenACDAT1Dylan {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        //Variables
        Scanner tec = new Scanner(System.in);
        char ejecutar = ' ', utilizarSustitutos = ' ';
        int pedElegido = 0, nListado = 0;
        boolean stockDisponible = false;
        
        //abrirConexion
        GestionPedidos gest = new GestionPedidos();
        gest.abrirConexion("ACDAT");
        
        //preguntarValidarEjecutar
        do{
            System.out.println("Desea ejecutar el programa? Si/No");
            ejecutar = Character.toLowerCase(tec.next().charAt(0));
        }while(ejecutar!='s' && ejecutar!='n');
        
        while(ejecutar=='s'){
        
           //obtenerResultSet de los pedidos no servidos
            //actualizable
            ResultSet pedidos = gest.obtenerPedidosPendientes();
            //listado
            ResultSet listado = gest.obtenerListadoPedidosPendientesCompleto();
            
            nListado = 1;
           //mostrarListaPedidos
            try
            {
                System.out.println("\nPedidos:\n");
                while(listado.next())
                {
                    System.out.print(nListado+"\t");
                    System.out.print(listado.getInt("IDPedido")+"\t");
                    System.out.print(listado.getDate("FechaPedido")+"\t");
                    System.out.print(listado.getString("Nombre")+"\t");
                    System.out.print(listado.getString("Apellidos")+"\t");
                    System.out.println(listado.getString("NombreEmpresa"));
                    nListado++;
                }
                //leerPedidoElegido
                do{
                   System.out.println("\nIntroduce el numero del pedido de la lista que desea servir:\n");
                   pedElegido = tec.nextInt();
                }while(pedElegido<1 || pedElegido>nListado);
                
                //comprobarStock
                    //nos situamos en la fila del resultset de pedidos actualizable elegido
                pedidos.absolute(pedElegido);
                    //comrpobamos stock
                stockDisponible = gest.comprobarStockPedido(pedidos.getInt("IDPedido"));
                if(stockDisponible)
                {
                    //obtener fecha actual
                    java.util.Date utilDate = new java.util.Date();
                    Date fechaActual = new Date(utilDate.getTime());
                    //actualizar resultset pedidos
                    pedidos.updateDate("FechaServido", fechaActual);
                    pedidos.updateRow();
                    //actualizarStock
                    gest.actualizaStockProductosPedido(pedidos.getInt("IDPedido"));
                    System.out.println("Pedido servido y stock actualizado");
                }
                else
                {
                    System.out.print("No hay stock suficiente para los productos:\t");
                   //obtenerProductosSinStock
                    ArrayList<String> prodSinStock = new ArrayList<>();
                    prodSinStock = gest.productosSinStock(pedidos.getInt("IDPedido"));
                   //mostrarProductos
                    for(String s : prodSinStock){
                        System.out.print("s  ");
                    }
                   //preguntarSiUtilizarSustitutos
                    do{
                    System.out.println("Desea utlizar los productos sustitutos para completar el pedido?");
                    utilizarSustitutos = Character.toLowerCase(tec.next().charAt(0));
                    }while(utilizarSustitutos!='s' && utilizarSustitutos!='n');
                   
                    if(utilizarSustitutos=='s'){
                        
                        System.out.println("En construccion");
                        /*
                        obtener resultset de productos sin stock (id,cantidadPedida,cantDisponible)
                        obtener resultset productos sustitutos
                        (metodo)comprobar si hay stock para la cantidad (cantidadPedida-cantDisponible) en los sustitutos
                        si hay stock
                            actualizar cantidad pedida de productos sin stock a (cantDisponible)
                            insertar en LineasPedidos los productos sustitutos con cantidad = (cantidadPedida-cantDisponible)
                            (metodo ya hecho)ejecutar el metodo actualizarStock que actualiza el stock de todos los productos del pedido
                            actualizar la fechaServido de ese pedido en el resultset pedidos 
                            informar
                        sino
                            informar
                        */

                    }
                }
            }
            catch(SQLException e)
            {
                e.printStackTrace();
            }
            
        
        //preguntarValidarSiVolverEjecutar
        do{
            System.out.println("Desea volver a ejecutar el programa? Si/No");
            ejecutar = Character.toLowerCase(tec.next().charAt(0));
        }while(ejecutar!='s' && ejecutar!='n');
        
        }//fin while grande
        
        //cerrarConexion
        gest.cerrarConexion();
    }
    
}
