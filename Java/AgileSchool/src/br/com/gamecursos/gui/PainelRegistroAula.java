package br.com.gamecursos.gui;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

import itexto.miocc.annotations.Named;
import itexto.miocc.annotations.Inject;
import br.com.gamecursos.aplicacao.ControladorAplicacao;
import br.com.gamecursos.aplicacao.facade.AulaFacade;
import br.com.gamecursos.gui.telaprincipal.PainelInterno;
import br.com.gamecursos.modelo.Aluno;
import br.com.gamecursos.modelo.AulaCronograma;
import br.com.gamecursos.modelo.AulaDada;
import br.com.gamecursos.modelo.Modulo;
import br.com.gamecursos.modelo.Presenca;
import br.com.gamecursos.modelo.Turma;

import java.util.List;
import java.util.ArrayList;

import javax.swing.JInternalFrame;

import static javax.swing.JOptionPane.showMessageDialog;

@Named
public class PainelRegistroAula extends PainelInterno {

   private AulaDada     aula;
   private AulaFacade   facade;
   
   DefaultComboBoxModel<Turma>      modelTurmas     = new DefaultComboBoxModel<>();
   DefaultComboBoxModel<Modulo>     modelModulos    = new DefaultComboBoxModel<>();
   DefaultListModel<AulaCronograma> modelAulasCrono = new DefaultListModel<>();
   DefaultListModel<Presenca>       modelFaltaram   = new DefaultListModel<>();
   DefaultListModel<Presenca>       modelPresentes  = new DefaultListModel<>();
   
   private JComboBox<Turma>      comboTurmas     = new JComboBox<>(modelTurmas);
   private JLabel                lblMostraCurso  = new JLabel();
   private JComboBox<Modulo>     comboModulos    = new JComboBox<>(modelModulos);
   private JList<AulaCronograma> listaAulasCrono = new JList<>(modelAulasCrono);
   private JList<Presenca>       listaFaltaram   = new JList<>(modelFaltaram);
   private JList<Presenca>       listaPresentes  = new JList<>(modelPresentes);
   
   private JTextArea txtConteudo  = new JTextArea();
   private JButton   btnOk        = new JButton("OK");
   private JButton   btnCancelar  = new JButton("Cancelar");
   
   @Inject
   public PainelRegistroAula(AulaFacade facade) {
      
      this.facade = facade;
      
      // Layout ------------------------------------------------------------------------------
      setLayout(new BorderLayout(0, 0));
      setPreferredSize( new Dimension(500, 500) );
      
      JPanel panelCampos = new JPanel();
      panelCampos.setLayout( new GridBagLayout() );
      add(panelCampos, BorderLayout.CENTER);
      
      // Início
      GridBagConstraints gbc = new GridBagConstraints();
      gbc.anchor  = GridBagConstraints.WEST;
      gbc.insets  = new Insets(5, 5, 5, 5);
      gbc.fill    = GridBagConstraints.BOTH;
      gbc.gridx   = 0;
      gbc.gridy   = 0;
      gbc.weightx = 0;
      gbc.weighty = 0;
      
      // Labels
      panelCampos.add( new JLabel("Turma:"), gbc );
      gbc.gridy++;
      
      panelCampos.add( new JLabel("Curso:"), gbc );
      gbc.gridy++;
      
      panelCampos.add( new JLabel("Módulo:"), gbc );
      gbc.gridy++;
      
      panelCampos.add( new JLabel("Aula no Cronograma:"), gbc );
      gbc.gridy++;
      
      panelCampos.add( new JLabel("Alunos (clique 2x):"), gbc );
      
      gbc.gridx = 2;
      panelCampos.add( new JLabel("Presentes (2x para retirar):"), gbc );
      gbc.gridy += 2;
      gbc.gridx = 0;
      
      panelCampos.add( new JLabel("Conteúdo Ministrado:"), gbc );
      
      // Campos
      gbc.gridx     = 1;
      gbc.gridy     = 0;
      gbc.gridwidth = 3;
      gbc.weightx   = 1;
      
      panelCampos.add(comboTurmas, gbc);
      gbc.gridy++;
      
      panelCampos.add(lblMostraCurso, gbc);
      gbc.gridy++;
      
      panelCampos.add(comboModulos, gbc);
      gbc.gridy++;
      
      gbc.weighty = 1;
      gbc.fill    = GridBagConstraints.BOTH;
      panelCampos.add( new JScrollPane(listaAulasCrono), gbc );
      gbc.gridy += 2;
      
      gbc.gridx     = 0;
      gbc.gridwidth = 2;
      panelCampos.add( new JScrollPane(listaFaltaram), gbc );
      
      gbc.gridx     = 2;
      gbc.gridwidth = 2;
      panelCampos.add( new JScrollPane(listaPresentes), gbc );
      
      gbc.gridy    += 2;
      gbc.gridx     = 0;
      gbc.gridwidth = 4;
      panelCampos.add( new JScrollPane(txtConteudo), gbc );
      
      JPanel panelBotoes = new JPanel();
      add(panelBotoes, BorderLayout.SOUTH);
      
      panelBotoes.add(btnOk);
      panelBotoes.add(btnCancelar);
      // ---------------------------------------------------------------------------------------
      
      // Módulos
      comboModulos.addItemListener( new SelecaoModulo() );
      
      // Aulas previstas no cronograma
      listaAulasCrono.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      
      // Alunos
      listaFaltaram.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      listaFaltaram.addMouseListener( new CliqueDuploAluno() );
      
      // Presentes
      listaPresentes.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      listaPresentes.addMouseListener( new CliqueDuploPresentes() );
      
      // Botões
      btnOk.addActionListener( new CliqueOK() );
      btnCancelar.addActionListener( new CliqueCancelar() );
      
      // Turmas
      List<Turma> turmas = facade.trazerTurmas();
      
      for (Turma t: turmas)
         modelTurmas.addElement(t);
      
      ItemListener il = new SelecaoTurma();
      comboTurmas.addItemListener(il);
      
      // Já sai na primeira turma, então processa!
      // Aqui disparamos o evento já com todos os componentes configurados! 
      il.itemStateChanged(null);
   }
   
   public void setAulaEditar(AulaDada aula) {
      comboTurmas.setSelectedItem( aula.getTurma() );
      comboTurmas.setEnabled(false);
      
      comboModulos.setSelectedItem( aula.getAulaCronograma().getModulo() );
      comboModulos.setEnabled(false);
      
      //comboTurmas.getItemListeners()[0].itemStateChanged(null);
      
      listaAulasCrono.setSelectedValue(aula.getAulaCronograma(), true);
      
      List<Presenca> presencas = facade.consultarPresencas(aula);
      modelFaltaram.removeAllElements();
      modelPresentes.removeAllElements();
      
      for (Presenca p: presencas) {
         if ( p.getCompareceu() )
            modelPresentes.addElement(p);
         else
            modelFaltaram.addElement(p);
      }
      
      txtConteudo.setText( aula.getConteudoMinistrado() );
      this.aula = aula;
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
         
         // Carregar alunos
         List<Aluno> alunos = facade.trazerAlunos(t);
         
         modelFaltaram.removeAllElements();
         modelPresentes.removeAllElements();
         
         for (Aluno a: alunos) {
            Presenca p = new Presenca(a, false);
            modelFaltaram.addElement(p);
         }
         
         // Atualizar as aulas do cronograma
         comboModulos.getItemListeners()[0].itemStateChanged(null);
      }
   }
   
   private class SelecaoModulo implements ItemListener {
      public void itemStateChanged(ItemEvent e) {
         if ( comboModulos.getSelectedIndex() >= 0 ) { 
            Modulo m = (Modulo) comboModulos.getSelectedItem();
            List<AulaCronograma> aulasCrono = facade.trazerCronograma(m);
            modelAulasCrono.removeAllElements();
            
            for (AulaCronograma a: aulasCrono)
               modelAulasCrono.addElement(a);
         }
      }
   }
   
   private class CliqueDuploAluno extends MouseAdapter {
      public void mouseClicked(MouseEvent e) {
         if (e.getClickCount() == 2 && listaFaltaram.getSelectedIndex() >= 0) {
            Presenca p = (Presenca) modelFaltaram.remove( listaFaltaram.getSelectedIndex() );
            modelPresentes.addElement(p);
         }
      }
   }

   private class CliqueDuploPresentes extends MouseAdapter {
      public void mouseClicked(MouseEvent e) {
         if (e.getClickCount() == 2 && listaPresentes.getSelectedIndex() >= 0) {
            Presenca p = (Presenca) modelPresentes.remove( listaPresentes.getSelectedIndex() );
            modelFaltaram.addElement(p);
         }
      }
   }
   
   private class CliqueOK implements ActionListener {
      public void actionPerformed(ActionEvent e) {
         if ( ! validar() )
            return;
            
         if (aula == null)
            aula = new AulaDada();
         
         // Montar a lista de presenças
         List<Presenca> presencas = new ArrayList<>();
         
         for ( Object item: modelFaltaram.toArray() ) {
            Presenca p = (Presenca) item;
            p.setAulaDada(aula);
            p.setCompareceu(false);
            presencas.add(p);
         }
            
         for ( Object item: modelPresentes.toArray() ) {
            Presenca p = (Presenca) item;
            p.setAulaDada(aula);
            p.setCompareceu(true);
            presencas.add(p);
         }
         
         aula.setAulaCronograma( (AulaCronograma) listaAulasCrono.getSelectedValue() );
         aula.setTurma( (Turma) comboTurmas.getSelectedItem() );
         aula.setPresencas(presencas);
         aula.setConteudoMinistrado( txtConteudo.getText() );
         
         facade.registrarAula(aula);
         
         showMessageDialog(null, "Aula registrada com sucesso!");
         getFrameInterno().dispose();
      }
      
      private boolean validar() {
         if (listaAulasCrono.getSelectedIndex() == -1) {
            showMessageDialog(null, "Favor selecionar qual aula foi hoje no cronograma!");
            return false;
         }
         
         if (comboTurmas.getSelectedIndex() == -1) {
            showMessageDialog(null, "Favor selecionar a turma!");
            return false;
         }
         
         if (comboTurmas.getSelectedIndex() == -1) {
            showMessageDialog(null, "Favor informar o que foi ministrado na aula!");
            return false;
         }
         
         return true;
      }
   }
   
   private class CliqueCancelar implements ActionListener {
      public void actionPerformed(ActionEvent e) {
         getFrameInterno().dispose();
      }
   }

}
