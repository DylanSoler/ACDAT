/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package probandohibernate;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author dasoler
 */
public class GestionCriaturitasRegalos 
{ 
    
  public CriaturitaConRegalos obtenerCriaturita(Session sss, byte id)
  {
    Query query = sss.createQuery("from CriaturitaConRegalos where id= :id");
    query.setByte("id", id);
    CriaturitaConRegalos cr = (CriaturitaConRegalos)query.uniqueResult();
    return cr;
  }
  
  
  public void quitarRegaloCriaturita (Session ses, CriaturitaConRegalos c ,int id)
  {
      Transaction t = ses.beginTransaction();
      
      Boolean salir = false;
      for(int i=0; i<c.getRegalitos().size() && !salir;i++)
      {
          RegaloParaCriaturitaConRegalos r = c.getRegalitos().get(i);
          if(r.getId()==id) {
              c.getRegalitos().remove(i);
              salir = true;
          }
      }

      Query query = ses.createQuery("from RegaloParaCriaturitaConRegalos where id= :id");
      query.setInteger("id", id);
      RegaloParaCriaturitaConRegalos reg = (RegaloParaCriaturitaConRegalos)query.uniqueResult();
      
      reg.setPropietario(null);
      
      t.commit();
  }
    
  
  public void asignarRegaloCriaturita (Session ses, byte idCriatura , int idRegalo)
  {
      Transaction t = ses.beginTransaction();
      
      Query query = ses.createQuery("from CriaturitaConRegalos where id= :id");
      query.setInteger("id", idCriatura);
      CriaturitaConRegalos criatura = (CriaturitaConRegalos)query.uniqueResult();
      
      query = ses.createQuery("from RegaloParaCriaturitaConRegalos where id= :id");
      query.setInteger("id", idRegalo);
      RegaloParaCriaturitaConRegalos reg = (RegaloParaCriaturitaConRegalos)query.uniqueResult();
      
      criatura.getRegalitos().add(reg);
      
      reg.setPropietario(criatura);
      
      t.commit();
  }
    
  public void insertarCriaturita(Session ses, Criaturitas c)
  {
    Transaction tx = ses.beginTransaction();

    ses.save(c);
            
    tx.commit();
  }
  
  public void insertarRegalo(Session ses, RegaloParaCriaturitaConRegalos r)
  {
    Transaction tx = ses.beginTransaction();

    ses.save(r);
            
    tx.commit();
  }
  
  public void eliminarRegalo(Session ses, int idRegalo)
  {
    Transaction tx = ses.beginTransaction();

    RegaloParaCriaturitaConRegalos r = (RegaloParaCriaturitaConRegalos)ses.get(RegaloParaCriaturitaConRegalos.class,idRegalo);
    ses.delete(r);
    
    tx.commit();
  }
  
  public void eliminarCriaturita(Session ses, byte id)
  {
    Transaction tx = ses.beginTransaction();

    Query query = ses.createQuery("from RegaloParaCriaturitaConRegalos where GoesTo= :idPropietario");
    query.setInteger("idPropietario", id);
    List<RegaloParaCriaturitaConRegalos> listadoRegalosCriaturita = (List<RegaloParaCriaturitaConRegalos>)query.list();
    
    for(RegaloParaCriaturitaConRegalos r:listadoRegalosCriaturita)
    {
        r.setPropietario(null);
    }
    
    query = ses.createQuery("from CriaturitaConRegalos where id= :id");
    query.setInteger("id", id);
    CriaturitaConRegalos cr = (CriaturitaConRegalos)query.uniqueResult();
    
    List<Cuento> cuentos = cr.getListaCuentos();
    
    for(Cuento c: cuentos)
    {
        for(int i=0;i<c.getListaLectores().size();i++)
        {
           if(c.getListaLectores().get(i).getId()==id){
               c.getListaLectores().remove(i);
           }
        }
    }
    
    Criaturitas c = (Criaturitas)ses.get(Criaturitas.class,id);
    ses.delete(c);
    
    tx.commit();
  }
  
  public Cuento obtenerCuento(Session sss, int id)
  {
    Query query = sss.createQuery("from Cuento where Id= :id");
    query.setInteger("id", id);
    Cuento c = (Cuento)query.uniqueResult();
    return c;
  }
  
  public void quitarCuento(Session sess, int idCuento, CriaturitaConRegalos cr)
  {
      Transaction tx = sess.beginTransaction();
      
      boolean salir = false;
      boolean salir2 = false;
      Cuento c = null;
      
      for(int i=0; i<cr.getListaCuentos().size() && salir2==false; i++)
      { 
          if(cr.getListaCuentos().get(i).getId()==idCuento) {
              
              c = cr.getListaCuentos().get(i);
              
              for(int j=0; j<c.getListaLectores().size() && salir==false; j++)
              {
                  if(c.getListaLectores().get(j).getId()==cr.getId()) {
                      c.getListaLectores().remove(j);
                      salir=true;}
              }
              cr.getListaCuentos().remove(i);
              salir2 = true;
          }
      }
      
      tx.commit();
  }
  
  public void asignarCuentoCriaturita(Session sess, CriaturitaConRegalos criaturaca, Cuento cuento)
  {
    Transaction tx = sess.beginTransaction();
          
    criaturaca.getListaCuentos().add(cuento);
    
    cuento.getListaLectores().add(criaturaca);
    
    tx.commit();
  }
  
  public void insertarCuento(Session sess, Cuento cuento)
  {
    Transaction tx = sess.beginTransaction();

    sess.save(cuento);
            
    tx.commit();
  }
  
  
  public void eliminarCuento(Session sess, Cuento cuento)
  {
    Transaction tx = sess.beginTransaction();

    List<CriaturitaConRegalos> criaturas = cuento.getListaLectores();
    
    for(CriaturitaConRegalos cr:criaturas)
    {
        for(int i=0; i<cr.getListaCuentos().size(); i++)
        {
            if(cr.getListaCuentos().get(i).getId()==cuento.getId())
            {
                cr.getListaCuentos().remove(i);
            }
        }
    }
    
    sess.delete(cuento);
            
    tx.commit();
  }
}
