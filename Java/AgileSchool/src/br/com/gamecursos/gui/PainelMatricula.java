package br.com.gamecursos.gui;

import itexto.miocc.annotations.*;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableModel;

import java.text.DateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import br.com.gamecursos.aplicacao.ControladorAplicacao;
import br.com.gamecursos.aplicacao.facade.MatriculaFacade;
import br.com.gamecursos.gui.telaprincipal.PainelInterno;
import br.com.gamecursos.modelo.*;
import static javax.swing.JOptionPane.*;

@Named
public class PainelMatricula extends PainelInterno {

   private MatriculaFacade facade;   
   
   private JTextField txtPesquisaAluno;
   private JButton btnPesquisar;
   private JTable tabelaAlunos;
   
   private DefaultComboBoxModel<Curso> modelCursos;
   private JComboBox<Curso> comboCursos;
   private JTable tabelaTurmas;
   
   private JTextField txtData;
   
   private JButton btnOk;
   private JButton btnCancelar;

   @Inject
   public PainelMatricula(MatriculaFacade facade) {
      this.facade = facade;
      GridBagConstraints gbc = new GridBagConstraints();
      gbc.insets = new Insets(5, 5, 5, 5);
      gbc.fill    = GridBagConstraints.BOTH;
      gbc.gridx   = 0;
      gbc.gridy   = 0;
      gbc.weightx = 0;
      gbc.weighty = 0;
      
      // Alunos
      txtPesquisaAluno = new JTextField(20);
      btnPesquisar = new JButton("Pesquisar");
      
      JPanel pnlPesquisa = new JPanel();
      pnlPesquisa.setLayout(new GridBagLayout());
      gbc.gridx = 0;
      pnlPesquisa.add(new JLabel("Procurar aluno:"), gbc);
      gbc.gridx = 1;
      gbc.weightx = 1;
      pnlPesquisa.add(txtPesquisaAluno, gbc);
      gbc.gridx = 2;
      gbc.weightx = 0;
      pnlPesquisa.add(btnPesquisar, gbc);
      
      tabelaAlunos = new JTable(new AlunosTableModel());
      JScrollPane scrollAlunos = new JScrollPane(tabelaAlunos);
      scrollAlunos.setPreferredSize(new Dimension(300, 200));
      scrollAlunos.getViewport().setBackground(Color.WHITE);
      
      // Cursos e turmas
      modelCursos = new DefaultComboBoxModel<>();
      comboCursos = new JComboBox<>(modelCursos);
      List<Curso> cursos = facade.trazerCursos();
      
      for (Curso c: cursos)
         modelCursos.addElement(c);
      
      JPanel pnlCurso = new JPanel();
      pnlCurso.setLayout(new GridBagLayout());
      gbc.gridx = 0;
      pnlCurso.add(new Label("Curso:"), gbc);
      gbc.gridx = 1;
      gbc.weightx = 1;
      pnlCurso.add(comboCursos, gbc);
      
      tabelaTurmas = new JTable(new TurmasTableModel());
      JScrollPane scrollTurmas = new JScrollPane(tabelaTurmas);
      scrollTurmas.setPreferredSize(new Dimension(300, 200));
      scrollTurmas.getViewport().setBackground(Color.WHITE);
      
      // Dados da matrícula
      txtData = new JTextField(10);
      txtData.setText(DateFormat.getDateInstance().format(new Date()));
      
      JPanel pnlDadosMatricula = new JPanel();
      pnlDadosMatricula.setLayout(new GridBagLayout());
      gbc.gridx = 0;
      gbc.weightx = 0;
      pnlDadosMatricula.add(new JLabel("Data:"), gbc);
      gbc.gridx = 1;
      pnlDadosMatricula.add(txtData, gbc);
      gbc.gridx = 2;
      
      // Botões
      btnOk = new JButton("Matricular");
      btnCancelar = new JButton("Cancelar");
      
      JPanel pnlBotoes = new JPanel();
      pnlBotoes.setLayout(new FlowLayout());
      pnlBotoes.add(btnOk);
      pnlBotoes.add(btnCancelar);
      
      // Juntando tudo
      setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
      add(pnlPesquisa);
      add(scrollAlunos);
      add(pnlCurso);
      add(scrollTurmas);
      add(pnlDadosMatricula);
      add(pnlBotoes);
      
      // Eventos
      AcaoPesquisarAluno acaoPesquisar = new AcaoPesquisarAluno();
      txtPesquisaAluno.addActionListener(acaoPesquisar);
      btnPesquisar.addActionListener(acaoPesquisar);
      
      ItemListener ilCursos = new SelecaoCurso();
      comboCursos.addItemListener(ilCursos);
      ilCursos.itemStateChanged(null);
      
      btnOk.addActionListener(new CliqueOK());
      btnCancelar.addActionListener(new CliqueCancelar());
   }
   
   @Override
   public boolean fecharFrame() {
      return showConfirmDialog(null, "Tem certeza?", "Fechar", YES_NO_OPTION) == YES_OPTION;
   }
   
   private class AlunosTableModel extends AbstractTableModel {

      private List<Aluno> alunos = new ArrayList<>();
      
      public void setAlunos(List<Aluno> alunos) {
         this.alunos = alunos;
         fireTableDataChanged();
      }
      
      @Override
      public int getRowCount() {
         return alunos.size();
      }

      @Override
      public int getColumnCount() {
         return 2;
      }

      @Override
      public Object getValueAt(int linha, int coluna) {
         Aluno a = alunos.get(linha);
         
         switch (coluna) {
            case 0:  return a.getNome();
            case 1:  return a.getResponsavel();
            default: return null;
         }
      }
      
      @Override
      public String getColumnName(int coluna) {
         switch (coluna) {
            case 0:  return "Aluno";
            case 1:  return "Responsável";
            default: return null;
         }
      }

      public Aluno getAluno(int linha) {
         return alunos.get(linha);
      }
      
   }
   
   private class TurmasTableModel extends AbstractTableModel {

      private List<Turma> turmas = new ArrayList<>();
      private DateFormat formatoHora = DateFormat.getTimeInstance(DateFormat.SHORT);
      
      public void setTurmas(List<Turma> turmas) {
         this.turmas = turmas;
         fireTableDataChanged();
      }
      
      @Override
      public int getRowCount() {
         return turmas.size();
      }

      @Override
      public int getColumnCount() {
         return 3;
      }

      @Override
      public Object getValueAt(int linha, int coluna) {
         Turma t = turmas.get(linha);
         Date dateEntrada = new Date(t.getHoraEntrada().getTimeInMillis());
         Date dateSaida = new Date(t.getHoraSaida().getTimeInMillis());
         
         switch (coluna) {
            case 0:  return t.getNome();
            case 1:  return formatoHora.format(dateEntrada);
            case 2:  return formatoHora.format(dateSaida);
            default: return null;
         }
      }
      
      @Override
      public String getColumnName(int coluna) {
         switch (coluna) {
            case 0:  return "Turma";
            case 1:  return "Início";
            case 2:  return "Término";
            default: return null;
         }
      }

      public Turma getTurma(int linha) {
         return turmas.get(linha);
      }
      
   }
   
   private class AcaoPesquisarAluno implements ActionListener {
      @Override
      public void actionPerformed(ActionEvent e) {
         List<Aluno> alunos = facade.trazerAlunos(
               txtPesquisaAluno.getText().trim());
         AlunosTableModel modelAlunos = (AlunosTableModel) tabelaAlunos.getModel();
         modelAlunos.setAlunos(alunos);
      }
   }
   
   private class SelecaoCurso implements ItemListener {
      @Override
      public void itemStateChanged(ItemEvent e) {
         if (comboCursos.getSelectedIndex() == -1) return;
         Curso curso = (Curso) comboCursos.getSelectedItem();
         List<Turma> turmas = facade.trazerTurmas(curso);
         TurmasTableModel modelTurmas = (TurmasTableModel) tabelaTurmas.getModel();
         modelTurmas.setTurmas(turmas);
      }
   }
   
   private class CliqueOK implements ActionListener {
      @Override
      public void actionPerformed(ActionEvent e) {
         // Pegar o aluno
         AlunosTableModel alunosModel = (AlunosTableModel) tabelaAlunos.getModel();
         int linha = tabelaAlunos.getSelectedRow();
         
         if (linha == -1) {
            showMessageDialog(null, "Favor selecionar um aluno!", "Nova Matrícula",
                  WARNING_MESSAGE);
            txtPesquisaAluno.requestFocus();
            return;
         }
         
         Aluno aluno = alunosModel.getAluno(linha);
         
         // Pegar a turma
         TurmasTableModel turmasModel = (TurmasTableModel) tabelaTurmas.getModel();
         linha = tabelaTurmas.getSelectedRow();
         
         if (linha == -1) {
            showMessageDialog(null, "Favor selecionar uma turma!", "Nova Matrícula",
                  WARNING_MESSAGE);
            tabelaTurmas.requestFocus();
            return;
         }
         
         Turma turma = turmasModel.getTurma(linha);
         
         // Pegar a data
         Date data;
         
         try {
            data = DateFormat.getDateInstance().parse(txtData.getText());
         }
         catch (ParseException ex) {
            showMessageDialog(null, "Data inválida!", "Nova Matrícula",
                  WARNING_MESSAGE);
            txtData.requestFocus();
            return;
         }
         
         // Fazer a matrícula
         Matricula matricula = new Matricula(aluno, turma, data);
         
         if (facade.realizar(matricula)) {
            showMessageDialog(null, "Matrícula realizada com sucesso.", 
                  "Nova Matrícula", INFORMATION_MESSAGE);
            getFrameInterno().dispose();
         }
      }
   }
   
   private class CliqueCancelar implements ActionListener {
      public void actionPerformed(ActionEvent e) {
         getFrameInterno().dispose();
      }
   }
   
}
