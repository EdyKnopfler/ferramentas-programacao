package br.com.gamecursos.repositorio;

import java.util.ArrayList;
import java.util.List;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.db.core.DAO;
import br.com.gamecursos.db.core.DAOException;
import br.com.gamecursos.modelo.*;

public class RegistroMatriculas {

   private ConexaoBD conexao;

   public RegistroMatriculas(ConexaoBD conexao) {
      this.conexao = conexao;
   }
   
   public List<Aluno> alunosDaTurma(Turma turma) throws Exception {
      List<Matricula> matriculas = 
            conexao.getDao().findBy(Matricula.class, "turma = " + turma.getId());
      List<Aluno> alunos = new ArrayList<>();
      
      for (Matricula m: matriculas) {
         alunos.add(m.getAluno());
      }
      
      return alunos;
   }

   public List<Turma> turmasDoAluno(Aluno aluno) throws Exception {
      List<Matricula> matriculas = 
            conexao.getDao().findBy(Matricula.class, "aluno = " + aluno.getId());
      List<Turma> turmas = new ArrayList<>();
      
      for (Matricula m: matriculas) {
         turmas.add(m.getTurma());
      }
      
      return turmas;
   }

   public void registra(Matricula matricula) throws Exception {
      Matricula existente = procurarMatricula(matricula.getAluno(), 
            matricula.getTurma());
      
      if (existente != null)
         throw new Exception("Aluno já matriculado na turma!");
      
      conexao.getDao().insert(matricula);
      new RegistroMensalidades(conexao).gerarMensalidades(matricula);
   }
   
   public Matricula procurarMatricula(Aluno aluno, Turma turma) {
      try {
         List<Matricula> encontradas = conexao.getDao().findBy(Matricula.class, 
               " turma = " + turma.getId() +
               " AND aluno = " + aluno.getId());
         
         if (!encontradas.isEmpty())
            return encontradas.get(0);
         else
            return null;
      } 
      catch (DAOException e) {
         throw new RuntimeException(e);
      }
   }
   
}
