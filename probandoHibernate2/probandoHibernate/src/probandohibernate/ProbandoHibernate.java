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
        List<Cuento> listadoCuentos;
        List<Criaturitas> listadoC;
        CriaturitaConRegalos cr;
        int idCuento;
        String titulo;
        String autor;
        String tema;
        
      do{
        
        do{ 
            System.out.println("Elige una opcion o cero para salir");
            menu();
            opcion = tec.nextInt();
        }while(opcion<0 || opcion>16);
        
        if(opcion!=0)
        {
            sf = EjemplosSessionFactory.getSessionFactory();
            session = sf.openSession();
            
            switch(opcion)
            {
                case 1: //Listar todas las criaturitas
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        
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
                            id = tec.nextByte(); }while(id<1);

                        cr = gest.obtenerCriaturita(session, id);
                        
                        System.out.println(cr.toString());
                        for(RegaloParaCriaturitaConRegalos r:cr.getRegalitos())
                            {System.out.println(r.toString());}                     
                    break;
                    
                case 4: //Quitar un regalo a una criaturita (sin borrarlo)
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c:listadoC)
                            {System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                        
                        do{ System.out.println("Introduce el id de la criaturita");
                            id = tec.nextByte(); }while(id<1);

                        CriaturitaConRegalos criatura = gest.obtenerCriaturita(session, id);
                        
                        System.out.println(criatura.toString());
                        for(RegaloParaCriaturitaConRegalos r:criatura.getRegalitos())
                            {System.out.println(r.toString());} 
                        
                        do{
                            System.out.println("Que regalo quieres quitarle? Introduce el id");
                            idRegalo = tec.nextInt();
                        }while(idRegalo<1);
                        
                        gest.quitarRegaloCriaturita(session, criatura, idRegalo);
                        System.out.println("Borrado con éxito");
                        
                    break;
                    
                case 5: //Asignar un regalo a una criaturita (o ninguna)
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c:listadoC)
                            {System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                        
                        do{ System.out.println("Introduce el id de la criaturita");
                            id = tec.nextByte(); }while(id<1);
                        
                        listadoR = (List<RegaloParaCriaturitaConRegalos>)session.createQuery("from RegaloParaCriaturitaConRegalos").list();
                        
                        for(RegaloParaCriaturitaConRegalos r:listadoR)
                            {
                                if(r.getPropietario()==null)
                                    System.out.println(r.toString());
                            }
                        
                        do{
                            System.out.println("Que regalo quieres asignarle? Introduce el id");
                            idRegalo = tec.nextInt();
                        }while(idRegalo<1);
                        
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
                        }while(id<1);
     
                        tec.nextLine();
                        
                        gest.insertarCriaturita(session, new Criaturitas(id, nombre));
                        System.out.println("Creado con exito");
                        
                    break;
                    
                case 7: //Crear un nuevo regalo
                        do{
                            System.out.println("Introduce el id:");
                            idRegalo = tec.nextInt();
                        }while(idRegalo<1);
                        tec.nextLine();
                        System.out.println("Denominacion:");
                        denominacion = tec.nextLine();
                        do{
                            System.out.println("Ancho:");
                            ancho = tec.nextInt();
                        }while(ancho<1);
                        do{
                            System.out.println("Largo:");
                            largo = tec.nextInt();
                        }while(largo<1);
                        do{
                            System.out.println("Alto:");
                            alto = tec.nextInt();
                        }while(alto<1);
                        System.out.println("Tipo:");
                        tipo = tec.next().charAt(0);
                        do{
                            System.out.println("Edad minima:");
                            edadMinima = tec.nextInt();
                        }while(edadMinima<1);
                        do{
                            System.out.println("Precio:");
                            precio = tec.nextBigDecimal();
                        }while(edadMinima<0);
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
                        }while(idRegalo<1);
                        
                        gest.eliminarRegalo(session, idRegalo);
                        System.out.println("Regalo borrado");
                        
                    break;
                    
                case 9: //Borrar una criaturita y todos sus regalos (POR PROBAR AUN)
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c:listadoC){System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                        
                        do{
                            System.out.println("\nIntroduce el id:");
                            id = tec.nextByte();
                        }while(id<1);
                        
                        gest.eliminarCriaturita(session, id);
                        System.out.println("Eliminada con exito");
                                
                    break;
                    
                case 10: //Listar todos los cuentos
                        listadoCuentos = (List<Cuento>)session.createQuery("from Cuento").list();
                        
                        for(Cuento c:listadoCuentos)
                            {System.out.println("ID: "+c.getId()+"\nTitulo: "+c.getTitulo()+"\nAutor:"+c.getAutor()+"\nTema: "+c.getTema());}
                    break;
                    
                case 11: //Recuperar una criaturita con todos sus cuentos
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c:listadoC)
                            {System.out.println("ID: "+c.getId()+" Nombre:"+c.getNombre());}
                        
                        do{ System.out.println("Introduce el id de la criaturita");
                            id = tec.nextByte(); }while(id<1);

                        cr = gest.obtenerCriaturita(session, id);
                        
                        System.out.println(cr.toString());
                        for(Cuento c:cr.getListaCuentos())
                            {System.out.println(c.toString());}
                    break;
                    
                case 12: //Recuperar un cuento y su lista de lectoras
                        listadoCuentos = (List<Cuento>)session.createQuery("from Cuento").list();
                        for(Cuento c:listadoCuentos)
                            {System.out.println("ID: "+c.getId()+"\nTitulo: "+c.getTitulo());}
                        do{
                            System.out.println("\nIntroduce el id del cuento: ");
                            idCuento = tec.nextInt();
                        }while(idCuento<1);
                        
                        Cuento c = gest.obtenerCuento(session, idCuento);
                        
                        System.out.println(c.toString());
                        for(CriaturitaConRegalos criat : c.getListaLectores())
                        {
                            System.out.println(criat.toString());
                        }
                    break;

                case 13: //Quitar un cuento a una criaturita (sin borrarlo)
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas cri:listadoC)
                            {System.out.println("ID: "+cri.getId()+" Nombre:"+cri.getNombre());}
                        
                        do{ System.out.println("Introduce el id de la criaturita");
                            id = tec.nextByte(); }while(id<0);

                        criatura = gest.obtenerCriaturita(session, id);
                        
                        for(Cuento cuento:criatura.getListaCuentos())
                            {System.out.println(cuento.toString());} 
                        
                        do{
                            System.out.println("Que cuento quieres quitarle? Introduce el id");
                            idCuento = tec.nextInt();
                        }while(idCuento<1);
                        
                        gest.quitarCuento(session, idCuento, criatura);
                        System.out.println("Quitado con éxito");
                    break;

                   case 14: //Asignar un cuento a una criatura
                        listadoC = (List<Criaturitas>)session.createQuery("from Criaturitas").list();
                        for(Criaturitas c1:listadoC)
                            {System.out.println("ID: "+c1.getId()+" Nombre:"+c1.getNombre());}
                        
                        do{ System.out.println("Introduce el id de la criaturita");
                            id = tec.nextByte(); }while(id<0);
                        
                        cr = gest.obtenerCriaturita(session, id);
                        
                        listadoCuentos = (List<Cuento>)session.createQuery("from Cuento").list();
                        
                        for(Cuento cuent:listadoCuentos)
                        {System.out.println(cuent.toString());}
                        
                        do{
                            System.out.println("Que cuento quieres asignarle? Introduce el id");
                            idCuento = tec.nextInt();
                        }while(idCuento<1);
                        
                        c = gest.obtenerCuento(session, idCuento);
                        
                        gest.asignarCuentoCriaturita(session, cr, c);
                        
                        System.out.println("Asignado!");
                        
                    break;
                    
                   case 15: //Crear un nuevo cuento
                            do{
                                System.out.println("Introduce el id del cuento");
                                idCuento = tec.nextInt();
                            }while(idCuento<1);
                            tec.nextLine();
                            System.out.println("Introduce el Titulo");
                            titulo = tec.nextLine();
                            System.out.println("Introduce el nombre del autor");
                            autor = tec.nextLine();
                            System.out.println("Introduce el tema");
                            tema = tec.nextLine();
                            
                            c = new Cuento(idCuento,titulo,autor,tema);
                            
                            gest.insertarCuento(session, c);
                       break;
                       
                   case 16: //Borrar un cuento
                            listadoCuentos = (List<Cuento>)session.createQuery("from Cuento").list();
                            for(Cuento c1:listadoCuentos)
                            {System.out.println("ID: "+c1.getId()+"\nTitulo: "+c1.getTitulo()+"\nAutor:"+c1.getAutor()+"\nTema: "+c1.getTema());}
                       
                            do{
                                System.out.println("Introduce el id del cuento que deseas borrar: ");
                                idCuento = tec.nextInt();
                            }while(idCuento<1);
                            
                            c = gest.obtenerCuento(session, idCuento);
                            gest.eliminarCuento(session, c);
                            
                            System.out.println("Borrado con exito");
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
        System.out.println("10- Listar todos los cuentos");
        System.out.println("11- Recuperar una criaturita con todos sus cuentos");
        System.out.println("12- Recuperar un cuento y su lista de lectoras");
        System.out.println("13- Quitar un cuento a una criaturita");
        System.out.println("14- Asignar un cuento a una criaturita");
        System.out.println("15- Crear un nuevo cuento");
        System.out.println("16- Borrar un cuento");
        System.out.println("--------------------------------------------------");
    }
    
}
