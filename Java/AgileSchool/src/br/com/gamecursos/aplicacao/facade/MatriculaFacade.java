package br.com.gamecursos.aplicacao.facade;

import static javax.swing.JOptionPane.*;

import java.util.List;

import itexto.miocc.annotations.*;
import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.modelo.*;
import br.com.gamecursos.repositorio.*;

@Named @Singleton
public class MatriculaFacade {
   
   private ConexaoBD conexao;

   @Inject
   public MatriculaFacade(ConexaoBD conexao) {
      this.conexao = conexao;
   }

   public List<Aluno> trazerAlunos(String pesquisa) {
      try {
         return new CadastroAlunos(conexao).pesquisarPorNome(pesquisa);
      } 
      catch (Exception ex) {
         showMessageDialog(null, "Erro ao consultar alunos!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return null;
      }
   }

   public List<Curso> trazerCursos() {
      try {
         return new CadastroCursos(conexao).listarCursos();
      } 
      catch (Exception ex) {
         showMessageDialog(null, "Erro ao consultar alunos!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return null;
      }
   }

   public List<Turma> trazerTurmas(Curso curso) {
      try {
         return new CadastroTurmas(conexao).turmasDoCurso(curso);
      } 
      catch (Exception ex) {
         showMessageDialog(null, "Erro ao consultar turmas!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return null;
      }
   }

   public boolean realizar(Matricula matricula) {
      try {
         new RegistroMatriculas(conexao).registra(matricula);
         conexao.finalizarTransacao();
         return true;
      } 
      catch (Exception ex) {
         showMessageDialog(null, ex.getMessage(), "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return false;
      }
   }
   
}
