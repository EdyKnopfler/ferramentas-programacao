package br.com.gamecursos.gui.crud;

import java.awt.*;

import javax.swing.*;

import br.com.gamecursos.swingcrud.*;
import br.com.gamecursos.gui.telaprincipal.PainelInterno;

public abstract class PainelCadastroPadrao<T> extends PainelInterno {
   
   private TableModelEntidade<T> tableModel;
   private PainelCampos<T> painelCampos;
   private CrudListenerPadrao<T> crudListener;
   
   private ControladorCRUD<T> controlador;
   
   private JTabbedPane abas;
   
   // Será customizável pelos filhos, o form pai apenas reserva espaço
   private JPanel painelPesquisa;
   
   public PainelCadastroPadrao() {
      // Dependências do controlador
      tableModel = criaTableModel();
      painelCampos = criaPainelCampos();
      crudListener = criaCrudListener();
      
      // Criando o controlador
      controlador = new ControladorCRUD<T>(tableModel, painelCampos,
            crudListener);
      crudListener.setControlador(controlador);
      crudListener.setPainelCadastro(this);
      
      // Obtendo os componentes criados pelo controlador
      JTable tabela = controlador.getTabela();
      JButton incluir = controlador.getIncluir();
      JButton alterar = controlador.getAlterar();
      JButton gravar = controlador.getGravar();
      JButton cancelar = controlador.getCancelar();
      JButton excluir = controlador.getExcluir();
      
      // Personalizando os componentes
      Dimension d = new Dimension(100, 30);
      incluir.setPreferredSize(d);
      alterar.setPreferredSize(d);
      gravar.setPreferredSize(d);
      cancelar.setPreferredSize(d);
      excluir.setPreferredSize(d);

      // Layout do formulário
      painelPesquisa = new JPanel();
      JPanel painelBotoes = new JPanel();
      painelBotoes.add(incluir);
      painelBotoes.add(alterar);
      painelBotoes.add(gravar);
      painelBotoes.add(cancelar);
      painelBotoes.add(excluir);
      
      JScrollPane scroll = new JScrollPane(tabela);
      scroll.getViewport().setBackground(Color.WHITE);
      
      JPanel painelListagem = new JPanel();
      painelListagem.setLayout(new BoxLayout(painelListagem, BoxLayout.Y_AXIS));
      painelListagem.add(painelPesquisa);
      painelListagem.add(scroll);
      
      abas = new JTabbedPane();
      abas.addTab("Listagem", painelListagem);
      abas.addTab("Dados", painelCampos);
      
      setLayout(new BorderLayout());
      add(painelBotoes, BorderLayout.NORTH);
      add(abas, BorderLayout.CENTER);
   }

   
   public abstract TableModelEntidade<T> criaTableModel();
   public abstract PainelCampos<T> criaPainelCampos();
   public abstract CrudListenerPadrao<T> criaCrudListener();
   
   
   protected ControladorCRUD<T> getControladorCrud() {
      return controlador;
   }
   
   protected TableModelEntidade<T> getTableModel() {
      return tableModel;
   }

   protected PainelCampos<T> getPainelCampos() {
      return painelCampos;
   }

   protected CRUDListener<T> getCrudListener() {
      return crudListener;
   }

   protected JPanel getPainelPesquisa() {
      return painelPesquisa;
   }
   
   protected void tamanhoColuna(int indice, int largura) {
      controlador.getTabela().getColumnModel().getColumn(indice)
            .setPreferredWidth(largura);
   }

   public JTabbedPane getAbas() {
      return abas;
   }
   
}
