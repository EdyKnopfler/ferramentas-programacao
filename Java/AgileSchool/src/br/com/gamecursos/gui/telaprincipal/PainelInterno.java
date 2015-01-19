package br.com.gamecursos.gui.telaprincipal;

import javax.swing.JPanel;

import br.com.gamecursos.aplicacao.ControladorAplicacao;

public abstract class PainelInterno extends JPanel {

   private FrameInterno frameInterno;
   private JanelaPrincipal janelaPrincipal;
   private ControladorAplicacao controlador;
   
   public FrameInterno getFrameInterno() {
      return frameInterno;
   }
   public void setFrameInterno(FrameInterno frameInterno) {
      this.frameInterno = frameInterno;
   }
   public JanelaPrincipal getJanelaPrincipal() {
      return janelaPrincipal;
   }
   public void setJanelaPrincipal(JanelaPrincipal janelaPrincipal) {
      this.janelaPrincipal = janelaPrincipal;
   }
   public ControladorAplicacao getControladorAplicacao() {
      return controlador;
   }
   public void setControladorAplicacao(ControladorAplicacao controlador) {
      this.controlador = controlador;
   }
   
   /**
    * Cada painel avalia se pode ser fechado.
    * @return true caso possa fechar
    */
   public boolean fecharFrame() {
      return true;
   }
   
   /**
    * Chamado ao ser iniciado o painel
    */
   public void iniciar() {
   }
   
}
