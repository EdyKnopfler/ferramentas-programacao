package br.com.gamecursos.repositorio;

import java.util.List;

import br.com.gamecursos.aplicacao.ConexaoBD;
import br.com.gamecursos.modelo.Curso;

public class CadastroCursos {

   private ConexaoBD conexao;

   public CadastroCursos(ConexaoBD conexao) {
      this.conexao = conexao;
   }

   public List<Curso> listarCursos() throws Exception {
      return conexao.getDao().findAll(Curso.class);
   }

}
