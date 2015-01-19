package br.com.gamecursos.gui.crud.aluno;

import static javax.swing.JOptionPane.*;

import java.awt.event.*;

import javax.swing.*;

import java.util.List;

import itexto.miocc.annotations.*;
import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.gui.crud.*;
import br.com.gamecursos.modelo.Aluno;
import br.com.gamecursos.repositorio.CadastroAlunos;
import br.com.gamecursos.swingcrud.*;

@Named
public class PainelCadastroAlunos extends PainelCadastroPadrao<Aluno> {
   
   private ConexaoBD conexao;
   private JTextField txtPesquisa = new JTextField(30);
   private JButton btnPesquisar = new JButton("Pesquisar >>");

   @Inject
   public PainelCadastroAlunos(ConexaoBD conexao) {
      this.conexao = conexao;
      tamanhoColuna(0, 150);
      tamanhoColuna(1, 150);
      
      getPainelPesquisa().add(new JLabel("Procurar:"));
      getPainelPesquisa().add(txtPesquisa);
      getPainelPesquisa().add(btnPesquisar);
      txtPesquisa.addActionListener(new AcaoPesquisarAluno());
      btnPesquisar.addActionListener(new AcaoPesquisarAluno());
   }
   
   @Override
   public TableModelEntidade<Aluno> criaTableModel() {
      return new TableModelAluno();
   }

   @Override
   public PainelCampos<Aluno> criaPainelCampos() {
      return new PainelCamposAluno();
   }

   @Override
   public CrudListenerPadrao<Aluno> criaCrudListener() {
      return new CrudListenerAluno();
   }
   
   @Override
   public void iniciar() {
      try {
         List<Aluno> alunos = new CadastroAlunos(conexao).listar();
         getTableModel().setListaObjetos(alunos);
      } 
      catch (Exception e) {
         showMessageDialog(null, "Erro ao carregar alunos!", "ERRO", 
               ERROR_MESSAGE);
         e.printStackTrace();
      }
   }
   
   @Override
   public boolean fecharFrame() {
      return true;
   }
   
   private class CrudListenerAluno extends CrudListenerPadrao<Aluno> {

      @Override
      public void aposBotaoIncluir() {
         super.aposBotaoIncluir();
         ((PainelCamposAluno) getPainelCampos()).focoEmNome();
      }

      @Override
      public void aposBotaoAlterar() {
         super.aposBotaoAlterar();
         ((PainelCamposAluno) getPainelCampos()).focoEmNome();
      }

      @Override
      public void acaoGravarInclusao(Aluno aluno) throws Exception {
         new CadastroAlunos(conexao).salvar(aluno);
         conexao.finalizarTransacao();
      }

      @Override
      public void acaoGravarAlteracao(Aluno aluno) throws Exception {
         new CadastroAlunos(conexao).salvar(aluno);
         conexao.finalizarTransacao();
      }

      @Override
      public void acaoExcluir(Aluno aluno) throws Exception {
         new CadastroAlunos(conexao).excluir(aluno);
         conexao.finalizarTransacao();
      }
      
   }
   
   private class AcaoPesquisarAluno implements ActionListener {
      @Override
      public void actionPerformed(ActionEvent e) {
         try {
            String pesquisa = txtPesquisa.getText().trim();
            List<Aluno> alunos = new CadastroAlunos(conexao)
                  .pesquisarPorNome(pesquisa);
            if (alunos.size() > 0)
               getTableModel().setListaObjetos(alunos);
            else
               showMessageDialog(null, "Não encontrado: " + pesquisa,
                     "Pesquisar", WARNING_MESSAGE);
         } 
         catch (Exception ex) {
            showMessageDialog(null, "Erro ao pesquisar!", "ERRO", 
                  ERROR_MESSAGE);
            ex.printStackTrace();
         }
      }
   }

}
