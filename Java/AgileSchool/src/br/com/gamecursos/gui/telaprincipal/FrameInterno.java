package br.com.gamecursos.gui.telaprincipal;

import javax.swing.JInternalFrame;
import javax.swing.event.InternalFrameAdapter;
import javax.swing.event.InternalFrameEvent;

public class FrameInterno extends JInternalFrame {
   
   private PainelInterno painelInterno;
   
   public FrameInterno(String titulo, PainelInterno painel) {
      super(titulo, true, true, true, true);
      
      this.painelInterno = painel;
      painel.setFrameInterno(this);
      painel.iniciar();
      setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
      
      addInternalFrameListener(new InternalFrameAdapter() {
         @Override
         public void internalFrameClosing(InternalFrameEvent e) {
            if (painelInterno.fecharFrame())
               dispose();
         }
      });
   }

   public void janelaPrincipalFechando() {
      getInternalFrameListeners()[0].internalFrameClosing(null);
   }
   
}
