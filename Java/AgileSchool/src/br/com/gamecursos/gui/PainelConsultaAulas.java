package br.com.gamecursos.gui;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.table.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import itexto.miocc.annotations.Named;
import itexto.miocc.annotations.Inject;
import br.com.gamecursos.aplicacao.ControladorAplicacao;
import br.com.gamecursos.aplicacao.facade.AulaFacade;
import br.com.gamecursos.gui.telaprincipal.PainelInterno;
import br.com.gamecursos.modelo.AulaDada;
import br.com.gamecursos.modelo.Modulo;
import br.com.gamecursos.modelo.Turma;

@Named
public class PainelConsultaAulas extends  PainelInterno {
   
   private AulaFacade facade;
   
   DefaultComboBoxModel<Turma>   modelTurmas     = new DefaultComboBoxModel<>();
   DefaultComboBoxModel<Modulo>  modelModulos    = new DefaultComboBoxModel<>();
   private JComboBox<Turma>      comboTurmas     = new JComboBox<>(modelTurmas);
   private JLabel                lblMostraCurso  = new JLabel();
   private JComboBox<Modulo>     comboModulos    = new JComboBox<>(modelModulos);
   
   private JTable tabela;
   
   @Inject
   public PainelConsultaAulas(AulaFacade facade) {
      
      this.facade = facade;
      
      // Layout ----------------------------------------------------------------------------
      
      // Painel de campos
      JPanel painelCampos = new JPanel();
      painelCampos.setLayout( new GridBagLayout() );
      
      GridBagConstraints gbc = new GridBagConstraints();
      gbc.anchor  = GridBagConstraints.WEST;
      gbc.insets  = new Insets(5, 5, 5, 5);
      gbc.fill    = GridBagConstraints.BOTH;
      gbc.gridx   = 0;
      gbc.gridy   = 0;
      gbc.weightx = 0;
      gbc.weighty = 0;
      
      painelCampos.add( new JLabel("Turma:"), gbc );
      gbc.gridy++;
      painelCampos.add( new JLabel("Curso:"), gbc );
      gbc.gridy++;
      painelCampos.add( new JLabel("Módulo:"), gbc );
      gbc.gridx     = 1;
      gbc.gridy     = 0;
      gbc.weightx   = 1;
      painelCampos.add(comboTurmas, gbc);
      gbc.gridy++;
      painelCampos.add(lblMostraCurso, gbc);
      gbc.gridy++;
      painelCampos.add(comboModulos, gbc);
      
      // Grid
      this.tabela = new JTable( new AulaTableModel() );
      tabela.getColumnModel().getColumn(2).setPreferredWidth(300);
      JScrollPane scrollTabela = new JScrollPane(tabela);
      scrollTabela.getViewport().setBackground(Color.WHITE);
      
      // Juntar tudo ;)
      setLayout( new BorderLayout() );
      add( painelCampos, BorderLayout.NORTH );
      add( scrollTabela, BorderLayout.CENTER );
      
      // Eventos ---------------------------------------------------------------------------

      // Turmas
      List<Turma> turmas = facade.trazerTurmas();
      
      for (Turma t: turmas)
         modelTurmas.addElement(t);
      
      // Módulos
      comboModulos.addItemListener( new SelecaoModulo() );
      
      // Clique duplo
      tabela.addMouseListener( new CliqueDuploTabela() );
      
      // Evento da seleção de turma por último, pois ele dispara os outros ;)
      ItemListener il = new SelecaoTurma();
      comboTurmas.addItemListener(il);
      il.itemStateChanged(null);
   }
   
   private class SelecaoTurma implements ItemListener {
      public void itemStateChanged(ItemEvent e) {
         if (comboTurmas.getSelectedIndex() == -1)
            return;
         
         Turma t = (Turma) comboTurmas.getSelectedItem();
         lblMostraCurso.setText( t.getCurso().getNome() );
         
         // Carregar módulos
         List<Modulo> modulos = t.getCurso().getModulos();
         
         modelModulos.removeAllElements();
         
         for (Modulo m: modulos)
            modelModulos.addElement(m);
         
         // Atualizar o registro de aulas
         comboModulos.getItemListeners()[0].itemStateChanged(null); 
      }
   }
   
   private class SelecaoModulo implements ItemListener {
      public void itemStateChanged(ItemEvent e) {
         if ( comboModulos.getSelectedIndex() == -1 )
            return;
         
         Turma  t = (Turma) comboTurmas.getSelectedItem();
         Modulo m = (Modulo) comboModulos.getSelectedItem();
         List<AulaDada> aulas = facade.consultarAulas(t, m);
         ( (AulaTableModel) tabela.getModel() ).setAulas(aulas);
      }
   }
   
   private class CliqueDuploTabela extends MouseAdapter {
      public void mouseClicked(MouseEvent e) {
         if (e.getClickCount() == 2) {
            AulaDada aula = 
                  ( (AulaTableModel) tabela.getModel() ).getAula( tabela.getSelectedRow() );
            PainelRegistroAula painel = 
                  (PainelRegistroAula) getControladorAplicacao().pegarBean("painelRegistroAula");
            painel.setAulaEditar(aula);
            getJanelaPrincipal().novaJanela("Editar Aula", painel);
         }
      }
   }

   private class AulaTableModel extends AbstractTableModel {
      
      private List<AulaDada> aulas = new ArrayList<>();
      
      public void setAulas(List<AulaDada> aulas) {
         this.aulas = aulas;
         fireTableDataChanged();
      }
      
      public int getColumnCount() {
         return 3;
      }

      public int getRowCount() {
         return aulas.size();
      }

      public Object getValueAt(int linha, int coluna) {
         AulaDada aula = aulas.get(linha);
         SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
         
         switch (coluna) {
            case 0:  return aula.getAulaCronograma().getNumeroAula();
            case 1:  return formato.format( aula.getData() );
            case 2:  return aula.getAulaCronograma().getDescricao();
            default: return null;
         }
      }
      
      public String getColumnName(int coluna) {
         switch (coluna) {
            case 0:  return "Aula nº";
            case 1:  return "Data";
            case 2:  return "Descrição da Aula";
            default: return null;
         }
      }
      
      public AulaDada getAula(int linha) {
         return aulas.get(linha);
      }
      
   }
   
}
