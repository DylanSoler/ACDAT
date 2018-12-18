/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package corazonesjaxb;

import java.io.File;

/**
 *
 * @author dasoler
 */
public class CorazonesJAXB {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        ManejadorCorazones manej = new ManejadorCorazones();
        
        File origen = new File("src/marcas/CorazonesSolitarios.xml");
        File origen2 = new File("src/marcas/masCorazones.xml");
        File destino = new File("src/marcas/FusionConrazones.xml");
        manej.almacenarListaCorazonesJAXB(origen);
        manej.aniadirCorazonesJAXB(origen2);
        manej.ordenarLista();
        manej.guardarListaCorazones(destino);

    }
    
}
