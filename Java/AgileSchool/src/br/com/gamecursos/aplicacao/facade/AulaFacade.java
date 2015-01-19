package br.com.gamecursos.aplicacao.facade;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.modelo.*;
import br.com.gamecursos.repositorio.*;
import itexto.miocc.annotations.*;

import java.util.List;

import static javax.swing.JOptionPane.*;

@Named @Singleton
public class AulaFacade {

   private ConexaoBD conexao;
   
   @Inject
   public AulaFacade(ConexaoBD conexao) {
      this.conexao = conexao;
   }
   
   public List<Turma> trazerTurmas() {
      try {
         return new CadastroTurmas(conexao).listarTurmas();
      }
      catch (Exception ex) {
         showMessageDialog(null, "Erro ao consultar turmas!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return null;
      }
   }
   
   public List<Aluno> trazerAlunos(Turma t) {
      try {
         return new RegistroMatriculas(conexao).alunosDaTurma(t);
      }
      catch (Exception ex) {
         showMessageDialog(null, "Erro ao consultar alunos!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return null;
      }
   }
   
   public List<AulaCronograma> trazerCronograma(Modulo m) {
      try {
         return new CronogramaAulas(conexao).consultarPorModulo(m);
      }
      catch (Exception ex) {
         showMessageDialog(null, "Erro ao consultar cronograma!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return null;
      }
   }
   
   public void registrarAula(AulaDada a) {
      try {
         new RegistroAulas(conexao).salvar(a);
         conexao.finalizarTransacao();
      }
      catch (Exception ex) {
         conexao.cancelarTransacao();
         showMessageDialog(null, "Erro ao registrar aula!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
     }
   }
   
   public List<AulaDada> consultarAulas(Turma t, Modulo m) {
      try {
         return new RegistroAulas(conexao).consultarAulas(t, m);
      }
      catch (Exception ex) {
         showMessageDialog(null, "Erro ao consultar aulas!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return null;
      }
   }
   
   public List<Presenca> consultarPresencas(AulaDada a) {
      try {
         return new RegistroFrequencia(conexao).consultarPorAula(a);
      }
      catch (Exception ex) {
         showMessageDialog(null, "Erro ao consultar presenças!\n\n" + ex.getMessage(),
               "ERRO", ERROR_MESSAGE);
         ex.printStackTrace();
         return null;
      }
   }
   
}