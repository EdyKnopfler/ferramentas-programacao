package br.com.gamecursos.repositorio;

import java.util.List;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.modelo.Aluno;

public class CadastroAlunos {

   private ConexaoBD conexao;
   
   public CadastroAlunos(ConexaoBD conexao) {
      this.conexao = conexao;
   }
   
   public void salvar(Aluno a) throws Exception {
      conexao.getDao().save(a);
   }

   public void excluir(Aluno a) throws Exception {
      conexao.getDao().delete(a);
   }

   public List<Aluno> pesquisarPorNome(String pesquisa) throws Exception {
      return conexao.getDao().findBy(Aluno.class,
            "nome LIKE '%" + pesquisa + "%'");
   }
   
   public List<Aluno> listar() throws Exception {
      return conexao.getDao().findAll(Aluno.class);
   }
   
}
