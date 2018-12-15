/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package corazonesjaxb;

import generadasXSD.Corazoncitos;
import generadasXSD.TipoPersona;
import java.io.File;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

/**
 *
 * @author dasoler
 */
public class ManejadorCorazones {
    
    Corazoncitos listaCorazones;
    
    public void almacenarListaCorazonesJAXB (File archivoXML){
        JAXBContext contexto;
        try {
            contexto = JAXBContext.newInstance(Corazoncitos.class);
            Unmarshaller u = contexto.createUnmarshaller();
            listaCorazones = (Corazoncitos) u.unmarshal(archivoXML);
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }
    
    public void aniadirCorazonesJAXB (File archivoXML) {
        JAXBContext contexto;
        Corazoncitos adicionales;
        try {
            contexto = JAXBContext.newInstance(Corazoncitos.class);
            Unmarshaller u = contexto.createUnmarshaller();
            adicionales = (Corazoncitos) u.unmarshal(archivoXML);
            
            for(TipoPersona persona:adicionales.getPersona()){
                
                listaCorazones.getPersona().add(persona);
            }
            
        }catch (Exception ex) {
            ex.printStackTrace();
        }
    }
     
    public void ordenarLista() {
        
        
        
    }
    
    public void guardarListaCorazones(File FusionCorazones){
        JAXBContext contexto;
        try {
            contexto = JAXBContext.newInstance(Corazoncitos.class);
            Marshaller marshalero = contexto.createMarshaller();
            marshalero.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
            StringWriter escribiente = new StringWriter();
            marshalero.marshal(listaCorazones, FusionCorazones);
            // ahora lo marshaleamos a un stream para visualizarlo
            marshalero.marshal(listaCorazones, escribiente);
            System.out.println("-----------------");
            System.out.println("Object2XML:");
            System.out.println(escribiente.toString());
            System.out.println("-----------------");
        } catch (JAXBException ex) {
            Logger.getLogger(ManejadorCorazones.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void mostrarLista() {
    
        for(TipoPersona persona:listaCorazones.getPersona()){
                
                System.out.println(persona.toStringBueno());
            }
    }
    
    

    
}
