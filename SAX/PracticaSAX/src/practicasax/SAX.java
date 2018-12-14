/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practicasax;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

/**
 *
 * @author dasoler
 */
public class SAX {
    
    XMLReader procesadorXML;
    GestionContenido gestor;
    InputSource archivoXML;
    
    public SAX (String nombreArchivo){
        try {
            procesadorXML = XMLReaderFactory.createXMLReader();
        } catch (SAXException ex) {
            Logger.getLogger(SAX.class.getName()).log(Level.SEVERE, null, ex);
        }
        gestor = new GestionContenido();
        procesadorXML.setContentHandler(gestor);
        archivoXML = new InputSource(nombreArchivo);
    }
    void parseador(){
        try {
            procesadorXML.parse(archivoXML);
        } catch (IOException ex) {
            Logger.getLogger(SAX.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(SAX.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
