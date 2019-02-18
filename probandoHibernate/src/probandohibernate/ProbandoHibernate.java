/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package probandohibernate;

import java.math.BigDecimal;
import java.util.List;
import java.util.Scanner;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author dasoler
 */
public class ProbandoHibernate {

    /**
     * @param args the command line arguments
     */
    
    private static SessionFactory sf = null;
    
    public static void main(String[] args) {
        
        Session session = null;
        GestionCriaturitasRegalos gest = new GestionCriaturitasRegalos();

        int opcion=0;
        Scanner tec = new Scanner(System.in);
        byte id;
        int idRegalo;
        String denominacion;
        int ancho;
        int largo;
        int alto;
        char tipo;
        int edadMinima;
        BigDecimal precio;
        List<RegaloParaCriaturitaConRegalos> listadoR;
        
      do{
        
        do{ 
            System.out.println("Elige una opcion o cero para salir");
            menu();
            opcion = tec.nextInt();
        }while(opcion<0 || opcion>9);
        
        if(opcion!=0)
        {
            sf = EjemplosSessionFactory.getSessionFactory();
            session = sf.openSession();
            
            switch(opcion)
            {
                case 1: //Listar todas las criaturitas
                        List<Criaturitas> listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        
                        for(Criaturitas c:listadoC)
                            {System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                    break;
                    
                case 2: //Listar todos los regalos
                        listadoR = (List<RegaloParaCriaturitaConRegalos>)session.createQuery("from RegaloParaCriaturitaConRegalos").list();
                        
                        for(RegaloParaCriaturitaConRegalos r:listadoR)
                            {System.out.println(r.toString());}
                    break;
                    
                case 3: //Recuperar una criaturita con todos sus regalos
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c:listadoC)
                            {System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                        
                        do{ System.out.println("Introduce el id de la criaturita");
                            id = tec.nextByte(); }while(id<0);

                        CriaturitaConRegalos cr = gest.obtenerCriaturita(session, id);
                        
                        System.out.println(cr.toString());
                        for(RegaloParaCriaturitaConRegalos r:cr.getRegalitos())
                            {System.out.println(r.toString());}                     
                    break;
                    
                case 4: //Quitar un regalo a una criaturita (sin borrarlo)
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c:listadoC)
                            {System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                        
                        do{ System.out.println("Introduce el id de la criaturita");
                            id = tec.nextByte(); }while(id<0);

                        CriaturitaConRegalos criatura = gest.obtenerCriaturita(session, id);
                        
                        System.out.println(criatura.toString());
                        for(RegaloParaCriaturitaConRegalos r:criatura.getRegalitos())
                            {System.out.println(r.toString());} 
                        
                        do{
                            System.out.println("Que regalo quieres quitarle? Introduce el id");
                            idRegalo = tec.nextInt();
                        }while(idRegalo<0);
                        
                        gest.quitarRegaloCriaturita(session, criatura, idRegalo);
                        System.out.println("Borrado con éxito");
                        
                    break;
                    
                case 5: //Asignar un regalo a una criaturita (o ninguna)
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c:listadoC)
                            {System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                        
                        do{ System.out.println("Introduce el id de la criaturita");
                            id = tec.nextByte(); }while(id<0);
                        
                        listadoR = (List<RegaloParaCriaturitaConRegalos>)session.createQuery("from RegaloParaCriaturitaConRegalos").list();
                        
                        for(RegaloParaCriaturitaConRegalos r:listadoR)
                            {
                                if(r.getPropietario()==null)
                                    System.out.println(r.toString());
                            }
                        
                        do{
                            System.out.println("Que regalo quieres asignarle? Introduce el id");
                            idRegalo = tec.nextInt();
                        }while(idRegalo<0);
                        
                        gest.asignarRegaloCriaturita(session, id, idRegalo);
                        
                        System.out.println("Asignado!");
                        
                    break;
                    
                case 6: //Crear una nueva criaturita
                        String nombre;
                        
                        tec.nextLine();
                        
                        System.out.println("Introduce el nombre:");
                        nombre = tec.nextLine();
                        
                        do{
                            System.out.println("Introduce el id:");
                            id = tec.nextByte();
                        }while(id<0);
     
                        tec.nextLine();
                        
                        gest.insertarCriaturita(session, new Criaturitas(id, nombre));
                        System.out.println("Creado con exito");
                        
                    break;
                    
                case 7: //Crear un nuevo regalo
                        do{
                            System.out.println("Introduce el id:");
                            idRegalo = tec.nextInt();
                        }while(idRegalo<0);
                        tec.nextLine();
                        System.out.println("Denominacion:");
                        denominacion = tec.nextLine();
                        do{
                            System.out.println("Ancho:");
                            ancho = tec.nextInt();
                        }while(ancho<0);
                        do{
                            System.out.println("Largo:");
                            largo = tec.nextInt();
                        }while(largo<0);
                        do{
                            System.out.println("Alto:");
                            alto = tec.nextInt();
                        }while(alto<0);
                        System.out.println("Tipo:");
                        tipo = tec.next().charAt(0);
                        do{
                            System.out.println("Edad minima:");
                            edadMinima = tec.nextInt();
                        }while(ancho<0);
                        do{
                            System.out.println("Precio:");
                            precio = tec.nextBigDecimal();
                        }while(ancho<0);
                        tec.nextLine();
                        
                        RegaloParaCriaturitaConRegalos regalazo = new RegaloParaCriaturitaConRegalos(idRegalo,denominacion,ancho,largo,alto,tipo,edadMinima,precio,null);
                        gest.insertarRegalo(session, regalazo);
                        System.out.println("Creado con exito");
                        
                    break;
                    
                case 8: //Borrar un regalo
                        listadoR = (List<RegaloParaCriaturitaConRegalos>)session.createQuery("from RegaloParaCriaturitaConRegalos").list();
                        for(RegaloParaCriaturitaConRegalos r:listadoR){System.out.println(r.toString());}    
                        
                        do{
                            System.out.println("\nIntroduce el id:");
                            idRegalo = tec.nextInt();
                        }while(idRegalo<0);
                        
                        gest.eliminarRegalo(session, idRegalo);
                        System.out.println("Regalo borrado");
                        
                    break;
                    
                case 9: //Borrar una criaturita y todos sus regalos
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c:listadoC){System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                        
                        do{
                            System.out.println("\nIntroduce el id:");
                            id = tec.nextByte();
                        }while(id<0);
                        
                        gest.eliminarCriaturita(session, id);
                        System.out.println("Eliminada con exito");
                                
                    break;
                    
            }
            
        }
      }while(opcion!=0);
        
      if(session!=null)
        session.close();
    }
    
    private static void menu()
    {
        System.out.println("-----------------------Menu-----------------------");
        System.out.println("1- Listar todas los criaturitas");
        System.out.println("2- Listar todos los regalos");
        System.out.println("3- Recuperar una criaturita");
        System.out.println("4- Quitar un regalo a una criaturita");
        System.out.println("5- Asignar un regalo a una criaturita");
        System.out.println("6- Crear una nueva criaturita");
        System.out.println("7- Crear un nuevo regalo");
        System.out.println("8- Borrar un regalo");
        System.out.println("9- Borrar una criaturita y todos sus regalos");
        System.out.println("--------------------------------------------------");
    }
    
}
