package br.com.gamecursos.repositorio;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.modelo.Curso;
import br.com.gamecursos.modelo.Turma;

import java.util.List;

public class CadastroTurmas {
   
   private ConexaoBD conexao;
   
   public CadastroTurmas(ConexaoBD conexao) {
      this.conexao = conexao;
   }
   
   public void salvar(Turma t) throws Exception {
      conexao.getDao().save(t);
   }

   public void excluir(Turma t) throws Exception {
      conexao.getDao().delete(t);
   }
   
   public List<Turma> listarTurmas() throws Exception {
      return conexao.getDao().findAll(Turma.class);
   }

   public List<Turma> turmasDoCurso(Curso curso) throws Exception {
      return conexao.getDao().findBy(Turma.class,
            "curso = " + curso.getId());
   }
   
}