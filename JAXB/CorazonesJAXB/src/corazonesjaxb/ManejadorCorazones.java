/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package corazonesjaxb;

import generadasXSD.Corazoncitos;
import generadasXSD.TipoPersona;
import java.io.File;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

/**
 *
 * @author dasoler
 */
public class ManejadorCorazones {
    
    Corazoncitos listaCorazones;
    
    public void guardarListaCorazonesJAXB (File archivoXML){
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

    
}
