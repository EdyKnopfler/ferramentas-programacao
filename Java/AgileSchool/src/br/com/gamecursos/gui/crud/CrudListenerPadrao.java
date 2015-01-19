package br.com.gamecursos.gui.crud;

import static javax.swing.JOptionPane.*;
import br.com.gamecursos.swingcrud.*;

public class CrudListenerPadrao<T> extends CRUDAdapter<T> {

   private ControladorCRUD<T> controlador;
   private PainelCadastroPadrao<T> cadastro;

   public void setControlador(ControladorCRUD<T> controlador) {
      this.controlador = controlador;
   }
   
   public void setPainelCadastro(PainelCadastroPadrao<T> painel) {
      this.cadastro = painel;
   }
   
   @Override
   public void aposBotaoIncluir() {
      cadastro.getAbas().setSelectedIndex(1);
   }
   
   @Override
   public void aposBotaoAlterar() {
      cadastro.getAbas().setSelectedIndex(1);
   }
   
   @Override
   public void aposBotaoGravar() {
      cadastro.getAbas().setSelectedIndex(0);
      controlador.getAlterar().requestFocus();
   }

   @Override
   public void aposBotaoCancelar() {
      cadastro.getAbas().setSelectedIndex(0);
      controlador.getIncluir().requestFocus();
   }

   @Override
   public boolean antesBotaoExcluir() {
      return showConfirmDialog(null, "Tem certeza?", "Excluir",
            YES_NO_OPTION) == YES_OPTION;
   }
   
   @Override
   public void aposBotaoExcluir() {
      controlador.getIncluir().requestFocus();
   }
   
}
