/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package practicasax;

/**
 *
 * @author dasoler
 */
public class PracticaSAX {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        String nombreArchivo = "discos.xml";
	SAX probando = new SAX (nombreArchivo);
        probando.parseador();
    }
    
}
